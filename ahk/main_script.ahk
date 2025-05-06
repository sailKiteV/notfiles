#Requires AutoHotkey v2.0+
#SingleInstance
#Include "%A_ScriptDir%"
#Include "functions.ahk"
#Include "box_drawing.ahk"
#Include "obsidian_menu.ahk"
#Include "obsidian_pastes_large.ahk"

; === link pasting stuff ===

:*?:;angp:: {
    HotPaste("<" . A_Clipboard . ">")
}

:*?:;mdlink:: 
    mdlink(hs?) {
        output := "[$|$](" . A_Clipboard . ")"
        HotPaste(output)
    }

:*?:;mdlank::
    mdlank(hs?) {
        output := "[$|$](<" . A_Clipboard . ">)"
        HotPaste(output)
    }

:*?:;plug:: {
    params := SubStr(A_Clipboard, 23)
    A_Clipboard := "https://obsidian.md/plugins" . params
    mdlink()
}

:*?:;plag:: {
    params := SubStr(A_Clipboard, 23)
    A_Clipboard := "https://obsidian.md/plugins" . params
    mdlank()
}

lowerAlpha := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
whisperChars := ["𝑎","𝑏","𝑐","𝑑","𝑒","𝑓","𝑔","ℎ","𝑖","𝑗","𝑘","𝑙","𝑚","𝑛","𝑜","𝑝","𝑞","𝑟","𝑠","𝑡","𝑢","𝑣","𝑤","𝑥","𝑦","𝑧"]
whisperMap := Map()

for char in lowerAlpha {
    whisperMap.Set(lowerAlpha[A_Index], whisperChars[A_Index])
}

!#t:: { ; launch and/or focus Windows Terminal
    if (!WinExist("ahk_exe wezterm-gui.exe")) {
        RunWait('*RunAs "C:\Users\sailK\scoop\apps\wezterm\current\wezterm-gui.exe"',,"Max")
    } else {
        WinActivate("ahk_exe wezterm-gui.exe")
    }
}

; === text wrapping and replacement ===

!#,:: { ; wrap selection in angle brackets
    WrapWith("<", ">")
}

!#.:: { ; wrap selection in single backticks
    WrapWith("``")
}

!#w::CharReplace(whisperMap) ; replace selection with whisper chars

; === a bunch of basic replacements ===

:*T?:;kams::감사합니다

:*T?:;rog::"f al|ress|os re|ck ski|ine thr|ne bo|claw|l arr"

:*T?:;redd::old.reddit.com/r/

:*T?:;cogg::COGGERS

:*T?:;leq::≤

:*T?:;greq::≥

; Typography: (—) Em dash
:*T?:;em::—

; Typography: (–) En dash
:*T?:;en::–

; Typography: (→ ) Short right arrow with space after
:*T?:;. ::→`s

; Typography: (← ) Short left arrow with space after
:*T?:;, ::←`s

; Typography: (⟶ ) Long right arrow with space after
:*T?:;.. ::⟶`s

; Typography: (⟵ ) Short left arrow with space after
:*T?:;,, ::⟵`s

; Typography: ( ) Braille space (for crimes against .md)
:*T0?:;braille ::⠀

; Typograph: ( ) no-break space (for crimes against .md)
:*T0?:;nbsp::{U+00a0}

; some double combining chars
; o͝o
:*T0?:;over2breve::{U+035d}

; o͞o
:*T0?:;over2macron::{U+035e}

; o͠o
:*T0?:;over2tilde::{U+0360}

; o͡o
:*T0?:;over2invbreve::{U+0361}

; o͜o
:*T0?:;undr2breve::{U+035c}

; o͟o
:*T0?:;undr2macron::{U+035f}

; zero width space
:*T0?:;zwsp::{U+200B}

; zero width non-joiner
:*T0?:;zwnj::{U+200C}

; zero width joiner
:*T0?:;zwj::{U+200D}

; word joiner
:*T0?:;wj::{U+2060}

; diacritical ring below
:*T0?:;ringbelow::{U+0325}

; === Discord pasting stuff ===

; tilde fenced code, cursor ready to add language identifier
:*T0?:;3td:: {
    HotPaste("
        (
        ~~~$|$
        ~~~
        )"
    )
}

; backtick fenced code, cursor ready to add language identifier
:*T0?:;3bt:: {
    HotPaste("
        (
        ``````$|$
        ``````
        )"
    )
}

; css fence, cursor ready inside
:*T0?Z:;css;:: {
    HotPaste("
        (
        ``````css
        $|$
        ``````
        )"
    )
}

:*T0?:;cllt:: {
    SendText(".callout[data-callout=`"`"]")
    Sleep(10)
    SendInput("{Left 2}")
}

:*?Z:;tag;:: { ; generate and insert paired HTML tags, with cursor between
    KeyWait(";")

    if (ib := InputBox(, "HTML Tag", "W200 H70")).result = "OK"
        Sleep(30)
        HotTextThenHint(format("<{1}>$|$</{1}>", ib.Value))
}

; make css fence with clipboard contents inside, cursor at end
:*T0?:;cssp:: {
    HotPaste(
        "``````css`n"
        . A_Clipboard
        . "`n``````"
    )
}

; string for referring to "Paste as plain text"
:*T?:;pasteas::``Ctrl+Shift+V``/``Paste as plain text``

; string for devtools
:*T?:;devtools::``Ctrl+Shift+I``/``Cmd+Opt+I``

; string for Obsidian file recovery
:*T?:;recov::``Settings -> File Recovery -> Snapshots -> View``

; === Obsidian community plugin pastes
:*T?:;advuri::[Advanced URI](<https://obsidian.md/plugins?id=obsidian-advanced-uri>)

:*T?:;dataview::[Dataview](<https://obsidian.md/plugins?id=dataview>)

:*T?:;templ::[Templater](<https://obsidian.md/plugins?id=templater-obsidian>)

:*T?:;quickadd::[QuickAdd](<https://obsidian.md/plugins?id=quickadd>)

:*T?:;styset::[Style Settings](<https://obsidian.md/plugins?id=obsidian-style-settings>)

:*T?:;brat::[BRAT](<https://obsidian.md/plugins?id=obsidian42-brat>)

:*T?:;metabind::[Meta Bind](<https://obsidian.md/plugins?id=obsidian-meta-bind-plugin>)

:*T?:;jsengine::[JS Engine](<https://obsidian.md/plugins?id=js-engine>)

:*T?:;customsort::[Custom File Explorer sort](<https://obsidian.md/plugins?id=custom-sort>)

; === Obsidian snippets pastes

:*T?:;itscall::[SlRvb's Callout Adjustments](<https://publish.obsidian.md/slrvb-docs/ITS+Theme/Callout+Adjustments>)

; === Discord Navigation and Functionality ===

; Discord fast reply to most recent message
:*?:;qr:: {
    SendInput("{LShift}{Tab}")
    Sleep(25)
    SendInput("{Up}")
    Sleep(150)
    SendInput("r")
}

;Discord fast emoji reaction to most recent message
:*?:;qe:: {
    SendInput("{LShift}{Tab}")
    Sleep(25)
    SendInput("{Up}")
    Sleep(150)
    SendInput("{NumpadAdd}")
}

!#a::WinExist("AutoHotkey v2 Help") ? WinActivate("AutoHotkey v2 Help") : Run("C:/Program Files/AutoHotkey/v2/AutoHotkey.chm") ; AHKv2 Help file

!#r::Reload ; reload main script

!#p:: { ; Obsidian Quick Plugin Search
    if(WinExist("ahk_exe obsidian.exe")) {
        Run("obsidian://show-plugin?id=%20")
        Sleep(100)
        SendInput("{BackSpace}")
    }
}

; === Unicode Alchemy  ===

:*T0?:;alch:: {
    alchGui := Gui(,"Unicode Alchemy",)

    alchText := ["Quintessence (🜀)","Air (🜁)","Fire (🜂)","Earth (🜃)","Water (🜄)","Aquafortis (🜅)","Aqua Regia (🜆)","Aqua Regia 2 (🜇)","Aqua Vitae (🜈)","Aqua Vitae 2 (🜉)","Vinegar (🜊)","Vinegar 2 (🜋)","Vinegar 3 (🜌)","Sulfur (🜍)","Philosophers Sulfur (🜎)","Black Sulfur (🜏)","Mercury Sublimate (🜐)","Mercury Sublimate 2 (🜑)","Mercury Sublimate 3 (🜒)","Cinnabar (🜓)","Salt (🜔)","Nitre (🜕)","Vitriol (🜖)","Vitriol 2 (🜗)","Rock Salt (🜘)","Rock Salt 2 (🜙)","Gold (🜚)","Silver (🜛)","Iron Ore (🜜)","Iron Ore 2 (🜝)","Crocus of Iron (🜞)","Regulus of Iron (🜟)","Copper Ore (🜠)","Iron-Copper Ore (🜡)","Sublimate of Copper (🜢)","Crocus of Copper (🜣)","Crocus of Copper 2 (🜤)","Antimoniate (🜥)","Salt of Copper Antimoniate (🜦)","Sublimate of Salt of Copper (🜧)","Verdigris (🜨)","Tin Ore (🜩)","Lead Ore (🜪)","Antimony Ore (🜫)","Sublimate of Antimony (🜬)","Salt of Antimony (🜭)","Sublimate of Salt of Antimony (🜮)","Vinegar of Antimony (🜯)","Regulus of Antimony (🜰)","Regulus of Antimony 2 (🜱)","Regulus (🜲)","Regulus 2 (🜳)","Regulus 3 (🜴)","Regulus 4 (🜵)","Alkali (🜶)","Alkali 2 (🜷)","Marcasite (🜸)","Sal-Ammoniac (🜹)","Arsenic (🜺)","Realgar (🜻)","Realgar 2 (🜼)","Auripigment (🜽)","Bismuth Ore (🜾)","Tartar (🜿)","Tartar 2 (🝀)","Quick Lime (🝁)","Borax (🝂)","Borax 2 (🝃)","Borax 3 (🝄)","Alum (🝅)","Oil (🝆)","Spirit (🝇)","Tincture (🝈)","Gum (🝉)","Wax (🝊)","Powder (🝋)","Calx (🝌)","Tutty (🝍)","Caput Mortuum (🝎)","Scepter of Jove (🝏)","Caduceus (🝐)","Trident (🝑)","Starred Trident (🝒)","Lodestone (🝓)","Soap (🝔)","Urine (🝕)","Horse Dung (🝖)","Ashes (🝗)","Pot Ashes (🝘)","Brick (🝙)","Powdered Brick (🝚)","Amalgam (🝛)","Stratum Super Stratum (🝜)","Stratum Super Stratum 2 (🝝)","Sublimation (🝞)","Precipitate (🝟)","Distill (🝠)","Dissolve (🝡)","Dissolve 2 (🝢)","Purify (🝣)","Putrefaction (🝤)","Crucible (🝥)","Crucible 2 (🝦)","Crucible 3 (🝧)","Crucible 4 (🝨)","Crucible 5 (🝩)","Alembic (🝪)","Bath of Mary (🝫)","Bath of Vapours (🝬)","Retort (🝭)","Hour (🝮)","Night (🝯)","Day-Night (🝰)","Month (🝱)","Half Dram (🝲)","Half Ounce (🝳)"]
    alchRef := &alchText

    alchDDL := alchGui.AddListBox("V:alchDDL Choose1 R8 W200 Sort",%alchRef%)
    alchSubmit := alchGui.AddButton("default W200","Submit")

    alchSubmit.OnEvent("Click", SendAlchChar)

    SendAlchChar(*) {
        RegExMatch(alchDDL.Text, "\((.)\)", &Submitted)
        alchGui.Destroy()
        Sleep(25)
        SendText(Submitted[1])
    }
    alchGui.Show()
}

; ======================================= ;
; HIGHLY EXPERIMENTAL SECTION VERY W.I.P. ;
; ======================================= ;

!#h::MsgBox(foundHotkeys)

thisFile := FileRead(A_ScriptFullPath)
hotkeyMatchExpr := "xm)^([^:\n]*?)::[^;]*?(;.*)?$"
hotkeyIndex := 1
foundHotkeys := ""
while (RegExMatch(thisFile, hotkeyMatchExpr, &matchedHotkey, hotkeyIndex)) {
    foundHotkeys := foundHotkeys . (hotkeyIndex == 1 ? "" :"`n") . matchedHotkey[1] . " | " . matchedHotkey[2]
    hotkeyIndex := matchedHotkey.Pos + StrLen(matchedHotkey[0])
}

includedInFile := GetThisAndIncludedFiles(A_ScriptFullPath)

!#f:: {
    output := ""
    for file in includedInFile
        output := output . file . "`n"

    MsgBox(output)
}

GetThisAndIncludedFiles(path) {
    fileContents := FileRead(path)
    included := []

    includedMatch := "m)^#Include `"(.*)`"$"
    includedIndex := 1

    while (RegExMatch(fileContents, includedMatch, &includedFile, includedIndex)) {
        included.Push(includedFile[1])
        includedIndex := includedFile.Pos + StrLen(includedFile[0])
    }

    return included
}

NumberFromUnicode(unicodeString) {
    numberString := SubStr(unicodeString, 3)
    digits := StrSplit(numberString)
    power := 0
    output := 0

    while(digits.Length > 0) {
        value := 0
        digit := digits.Pop()
        switch digit, 0 {
            case "f": value := 15
            case "e": value := 14
            case "d": value := 13
            case "c": value := 12
            case "b": value := 11
            case "a": value := 10
                
            default: value := Number(digit)
        }
        output += value*16**power
        power++
    }

    return output
}

CreateUnicodeCharArray(startPoint, endPoint) {
    currentCode := NumberFromUnicode(startPoint)
    finalCode := NumberFromUnicode(endPoint)
    output := []

    while(currentCode <= finalCode) {
        output.Push(Chr(currentCode))
        currentCode++
    }

    return output
}

!#q::MsgBox(CreateUnicodeCharArray("U+1F700", "U+1F77F")[3])
