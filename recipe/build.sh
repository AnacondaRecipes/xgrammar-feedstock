export CMAKE_BUILD_TYPE=Release
export CXXFLAGS="$CXXFLAGS -isystem $PREFIX/include"

# verify that the vendored picojson license has not changed from the expected license
# picojson.license is a copy+paste of the top of the picojson.h file that was done at
# the time of the xgrammar 0.28.0 build.
diff <(head -27 3rdparty/picojson/picojson.h ) <(head -27 $RECIPE_DIR/picojson.license) -s

if [[ $(uname) == "Linux" ]]; then
    export CXXFLAGS="$CXXFLAGS -Wno-dangling-reference"
    # Disable LTO to avoid linker issues with tvm_ffi shared library
    export CXXFLAGS="$CXXFLAGS -fno-lto"
    export LDFLAGS="$LDFLAGS -fno-lto"
else
    export CXXFLAGS="$CXXFLAGS -Wno-deprecated-literal-operator"
fi
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

if [ -f $SP_DIR/xgrammar/libxgrammar_bindings.so ]; then
    strip -S $SP_DIR/xgrammar/libxgrammar_bindings.so
fi
