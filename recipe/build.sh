export CMAKE_BUILD_TYPE=Release
export CXXFLAGS="$CXXFLAGS -isystem $PREFIX/include"

if [[ $(uname) == "Linux" ]]; then
    export CXXFLAGS="$CXXFLAGS -Wno-dangling-reference"
    # Disable LTO to avoid linker issues with tvm_ffi shared library
    export CXXFLAGS="$CXXFLAGS -fno-lto"
    export LDFLAGS="$LDFLAGS -fno-lto"
else
    export CXXFLAGS="$CXXFLAGS -Wno-deprecated-literal-operator"
fi
$PYTHON -m pip install . -vv --no-deps --no-build-isolation

rm $SP_DIR/xgrammar/lib/libxgrammar.a

if [ -f $SP_DIR/xgrammar/libxgrammar_bindings.so ]; then
    strip -S $SP_DIR/xgrammar/libxgrammar_bindings.so
fi
