; primarily meant to be included in other scripts
; #Requires AutoHotKey v2.0+
; #SingleInstance
; #Include "%A_ScripDir%"
; #Include "functions.ahk"

; === functions ===

/**
 * Uses the clipboard for sending large amounts of text quickly.
 * Probably bad and not worth doing but i'm weird like this, sorry.
 * 
 * @param text The text to be sent/pasted.
 */
HotPaste(text) {
    current := A_Clipboard
    left := 0
    Sleep(25)
    ; process $|$ cursor hint (Espanso-like)
    A_Clipboard := ""
    Loop parse, StrReplace(text, "$|$", "⏏"), "⏏" {
        if(A_Index > 1)
            left := StrLen(A_LoopField)
        A_Clipboard := A_Clipboard . A_LoopField
    }
    SendInput("^v" . "{Left " . left . "}")
    Sleep(25)
    A_Clipboard := current
    Sleep(25)
    current := ""
}

/**
 * Small sketchy function for sanitizing certain characters in URLs.
 * 
 * @param str The string to sanitize.
 * @returns {string} The sanitized string.
 */
Sanitize(str) {
    sanitized := StrReplace(str, "+", "{NumpadAdd}")
    sanitized := StrReplace(sanitized, "#", "+{3}")

    return sanitized
}

/**
 * Operates on a text selection, wrapping it with provided strings.
 * 
 * @param left String to place on left of selection.
 * @param right Optional String to place on right of selection. If not provided, `left` is used instead.
 */
WrapWith(left, right?) {
    if(!IsSet(right)){
        right := left
    }
    current := A_Clipboard
    Sleep(25)
    SendInput("^c")
    Sleep(25)
    HotPaste(
        left
        . A_Clipboard
        . right
    )
    A_Clipboard := current
}

/**
 * Operates on a selection, replacing characters in provided map with other characters (though strings may also work as replacements).
 * 
 * @param charMap A map of characters and their replacements.
 */
CharReplace(charMap) {
    out := ""
    current := A_Clipboard
    Sleep(25)
    SendInput("^c")
    Sleep(25)
    Loop parse, A_Clipboard, "" {
        if(charMap.Has(A_LoopField)) {
            ch := charMap[A_LoopField]
        }
        else {
            ch := A_LoopField
        }
        out := out . ch
    }
    HotPaste(out)
    A_Clipboard := current
}