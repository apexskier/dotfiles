if [ "$(uname -s)" != "Darwin" ]; then
    return 0
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

export DISPLAY=localhost:0.0

alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"

# convert clipboard contents to plain text
# https://twitter.com/jf/status/1071105968153350144
alias pbclean='pbpaste -Prefer txt | pbcopy; pbpaste; echo'

# output mixed format clipboard content as html
alias pbhtml="osascript -e 'the clipboard as «class HTML»' | perl -ne 'print chr foreach unpack(\"C*\",pack(\"H*\",substr(\$_,11,-3)))'"

# quicklook from the terminal
alias ql="qlmanage -p ${@} > /dev/null 2> /dev/null"
