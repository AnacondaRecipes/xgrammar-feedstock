export CMAKE_BUILD_TYPE=Release
export CXXFLAGS="$CXXFLAGS -isystem $PREFIX/include"

if [[ $(uname) == "Linux" ]]; then
    export CXXFLAGS="$CXXFLAGS -Wno-dangling-reference"
else
    export CXXFLAGS="$CXXFLAGS -Wno-deprecated-literal-operator"
fi
$PYTHON -m pip install . -vv --no-deps --no-build-isolation