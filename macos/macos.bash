if [ "$(uname -s)" == "Darwin" ]; then
    export DISPLAY=localhost:0.0

    alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc"
fi
