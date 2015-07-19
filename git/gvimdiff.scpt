on run argv
    tell application "Terminal"
        if not (exists window 1) then reopen
        set argvStr to my joinList(argv, " ")
        do script "vimdiff " & argvStr & " && exit || exit 1"
        activate
    end tell
end run

to joinList(aList, delimiter)
    set retVal to ""
    set prevDelimiter to AppleScript's text item delimiters
    set AppleScript's text item delimiters to delimiter
    set retVal to aList as string
    set AppleScript's text item delimiters to prevDelimiter
    return retVal
end joinList
