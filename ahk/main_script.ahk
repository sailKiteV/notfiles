﻿#Requires AutoHotkey v2.0
#SingleInstance
#Include "%A_ScriptDir%"
#Include "obsidian_menu.ahk"
#Include "box_drawing.ahk"

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

; === functions ===
Sanitize(str) {
    sanitized := StrReplace(str, "+", "{NumpadAdd}")
    sanitized := StrReplace(sanitized, "#", "+{3}")

    return sanitized
}

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

lowerAlpha := ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
whisperChars := ["𝑎","𝑏","𝑐","𝑑","𝑒","𝑓","𝑔","ℎ","𝑖","𝑗","𝑘","𝑙","𝑚","𝑛","𝑜","𝑝","𝑞","𝑟","𝑠","𝑡","𝑢","𝑣","𝑤","𝑥","𝑦","𝑧"]
whisperMap := Map()

for char in lowerAlpha {
    whisperMap.Set(lowerAlpha[A_Index], whisperChars[A_Index])
}

; === text wrapping and replacement ===

; wrap selection in angle brackets
!#,:: {
    WrapWith("<", ">")
}

; wrap selection in single backticks
!#.:: {
    WrapWith("``")
}

!#w::CharReplace(whisperMap)

; === a bunch of basic replacements ===

:*T?:;kams::감사합니다

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
:*T0?:;css;:: {
    HotPaste("
        (
        ``````css
        $|$
        ``````
        )"
    )
}

; make css fence with clipbard contents inside, cursor at end
:*T0?:;cssp:: {
    HotPaste(
        "``````css`n"
        . A_Clipboard
        . "`n``````"
    )
}

; === big pastes, mostly Obsidian-related ===

:*T0?:;pmdb:: {
    text := "
    (
    ### Markdown Resources
    - [Obsidian Basic Formatting](<https://help.obsidian.md/Editing+and+formatting/Basic+formatting+syntax>) | Learn many of the basics of Markdown in Obsidian.
    - [Markdown Guide](<https://www.markdownguide.org/basic-syntax>) | Learn more about how Markdown renders various elements by syntax.
    )"

    HotPaste(text)
}
; full Markdown resources
:*T0?:;pmdf:: {
    text := "
    (
    ### Markdown Resources
    - [Obsidian Basic Formatting](<https://help.obsidian.md/Editing+and+formatting/Basic+formatting+syntax>) | Learn many of the basics of Markdown in Obsidian.
    - [Markdown Guide](<https://www.markdownguide.org/basic-syntax>) | Learn more about how Markdown renders various elements by syntax.
    - [CommonMark Spec](<https://spec.commonmark.org/current/>) | One of the more detailed specifications for Markdown (as a reference).
    - [GFM Spec](<https://github.github.com/gfm/>) | Specification for GitHub Flavored Markdown; based on CommonMark.
    - [Canadian Government of Northwest Territories, Justice Dept.](<https://www.justice.gov.nt.ca/en/docs/markdown/page/3/>) | Surprisingly concise resource for learning about loose lists, don't ask me why.
    )"

    HotPaste(text)
}

; Demonstration of Markdown link and Wikilink syntaxes
:*T0?:;lnks:: {
    text := "
    (
    > Markdown: ``[link text](target)``
    > Wikilink: ``[[target|link text]]``
    > - [Reference](<https://help.obsidian.md/Linking+notes+and+files/Internal+links>) 
    )"

    HotPaste(text)
}

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

; AHKv2 Help file
!#a::WinExist("AutoHotkey v2 Help") ? WinActivate("AutoHotkey v2 Help") : Run("C:/Program Files/AutoHotkey/v2/AutoHotkey.chm")

; Obsidian Quick Plugin Search
!#p:: {
    if(WinExist("ahk_exe obsidian.exe")) {
        Run("obsidian://show-plugin?id=%20")
        Sleep(100)
        SendInput("{BackSpace}")
    }
}

; === Unicode Alchemy  ===

:*T0?:;alch:: {
    alchGUI := Gui(,"Unicode Alchemy",)

    alchText := ["Quintessence (🜀)","Air (🜁)","Fire (🜂)","Earth (🜃)","Water (🜄)","Aquafortis (🜅)","Aqua Regia (🜆)","Aqua Regia 2 (🜇)","Aqua Vitae (🜈)","Aqua Vitae 2 (🜉)","Vinegar (🜊)","Vinegar 2 (🜋)","Vinegar 3 (🜌)","Sulfur (🜍)","Philosophers Sulfur (🜎)","Black Sulfur (🜏)","Mercury Sublimate (🜐)","Mercury Sublimate 2 (🜑)","Mercury Sublimate 3 (🜒)","Cinnabar (🜓)","Salt (🜔)","Nitre (🜕)","Vitriol (🜖)","Vitriol 2 (🜗)","Rock Salt (🜘)","Rock Salt 2 (🜙)","Gold (🜚)","Silver (🜛)","Iron Ore (🜜)","Iron Ore 2 (🜝)","Crocus of Iron (🜞)","Regulus of Iron (🜟)","Copper Ore (🜠)","Iron-Copper Ore (🜡)","Sublimate of Copper (🜢)","Crocus of Copper (🜣)","Crocus of Copper 2 (🜤)","Antimoniate (🜥)","Salt of Copper Antimoniate (🜦)","Sublimate of Salt of Copper (🜧)","Verdigris (🜨)","Tin Ore (🜩)","Lead Ore (🜪)","Antimony Ore (🜫)","Sublimate of Antimony (🜬)","Salt of Antimony (🜭)","Sublimate of Salt of Antimony (🜮)","Vinegar of Antimony (🜯)","Regulus of Antimony (🜰)","Regulus of Antimony 2 (🜱)","Regulus (🜲)","Regulus 2 (🜳)","Regulus 3 (🜴)","Regulus 4 (🜵)","Alkali (🜶)","Alkali 2 (🜷)","Marcasite (🜸)","Sal-Ammoniac (🜹)","Arsenic (🜺)","Realgar (🜻)","Realgar 2 (🜼)","Auripigment (🜽)","Bismuth Ore (🜾)","Tartar (🜿)","Tartar 2 (🝀)","Quick Lime (🝁)","Borax (🝂)","Borax 2 (🝃)","Borax 3 (🝄)","Alum (🝅)","Oil (🝆)","Spirit (🝇)","Tincture (🝈)","Gum (🝉)","Wax (🝊)","Powder (🝋)","Calx (🝌)","Tutty (🝍)","Caput Mortuum (🝎)","Scepter of Jove (🝏)","Caduceus (🝐)","Trident (🝑)","Starred Trident (🝒)","Lodestone (🝓)","Soap (🝔)","Urine (🝕)","Horse Dung (🝖)","Ashes (🝗)","Pot Ashes (🝘)","Brick (🝙)","Powdered Brick (🝚)","Amalgam (🝛)","Stratum Super Stratum (🝜)","Stratum Super Stratum 2 (🝝)","Sublimation (🝞)","Precipitate (🝟)","Distill (🝠)","Dissolve (🝡)","Dissolve 2 (🝢)","Purify (🝣)","Putrefaction (🝤)","Crucible (🝥)","Crucible 2 (🝦)","Crucible 3 (🝧)","Crucible 4 (🝨)","Crucible 5 (🝩)","Alembic (🝪)","Bath of Mary (🝫)","Bath of Vapours (🝬)","Retort (🝭)","Hour (🝮)","Night (🝯)","Day-Night (🝰)","Month (🝱)","Half Dram (🝲)","Half Ounce (🝳)"]

    alchDDL := alchGUI.AddListBox("V:alchDDL Choose1 R8 W200 Sort",alchText)
    alchSubmit := alchGui.AddButton("default W200","Submit")

    alchSubmit.OnEvent("Click", SendAlchChar)

    SendAlchChar(*) {
        RegExMatch(alchDDL.Text, "\((.)\)", &Submitted)
        alchGUI.Destroy()
        Sleep(25)
        SendText(Submitted[1])
    }
    alchGUI.Show()
}