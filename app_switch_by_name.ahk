APP_MEM_OUTPUT_VAR := Object()

; using *AHL Window Spy* get a portion of the `ahk_class`
;
; sample use:
;   q::switch("c")
;
; for run:
;   q::run("c")

SetTitleMatchMode, 2 
#WinActivateForce

TITLES := {}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TITLES TO RECALL 
;;
;; - CAPS-ALT combinations 
;; - cycles already open apps
;; - provide overrides here or in ./overrides.ahk (not checked in)
;;

TITLES["a"] := ["cmd.exe", "powershell.exe"]
TITLES["s"] := []
TITLES["d"] := ["Visual Studio Code"]
TITLES["f"] := []
TITLES["g"] := []
TITLES["z"] := ["outlook.exe", "teams.exe"]
TITLES["x"] := ["Gmail", "WhatsApp", "Viber", "Slack", "Messenger", "Discord", "Skype"]
TITLES["c"] := ["- Microsoft Edge", "msedge.exe"]
TITLES["v"] := ["- Chromium", "- Google Chrome"]
TITLES["b"] := ["- OneNote", "Adobe Acrobat Reader"]

;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TO RUN 
;;
;; - CAPS-SPACE combinations 
;; - opens new or cycles (iff APP_TITLE_TO_SWITH_TO_IN_KEY configured)
;; - provide overrides here or in ./overrides.ahk (not checked in)
;;

APP_TO_RUN_ON_KEY := {}

APP_TO_RUN_ON_KEY["a"] := ""
APP_TO_RUN_ON_KEY["s"] := "C:\Program Files\Notepad++\notepad++.exe"
APP_TO_RUN_ON_KEY["f"] := ""
APP_TO_RUN_ON_KEY["g"] := ""
APP_TO_RUN_ON_KEY["x"] := ""
APP_TO_RUN_ON_KEY["c"] := "shell:Appsfolder\msedge"
APP_TO_RUN_ON_KEY["v"] := ""

;; app window titles to consider for app switch before running APP_TO_RUN_ON_KEY above
APP_TITLE_TO_SWITCH_TO_ON_KEY := {}
APP_TITLE_TO_SWITCH_TO_ON_KEY["a"] := ""
APP_TITLE_TO_SWITCH_TO_ON_KEY["s"] := "- Notepad++"
APP_TITLE_TO_SWITCH_TO_ON_KEY["f"] := ""
APP_TITLE_TO_SWITCH_TO_ON_KEY["g"] := ""
APP_TITLE_TO_SWITCH_TO_ON_KEY["x"] := ""
APP_TITLE_TO_SWITCH_TO_ON_KEY["c"] := "- Microsoft Edge"
APP_TITLE_TO_SWITCH_TO_ON_KEY["v"] := ""

#IncludeAgain overrides.ahk

for which, title in APP_TITLE_TO_SWITCH_TO_ON_KEY {
    GroupAdd, app_title_to_switch_%which%, %title%
}

getIds() {
    WinGet, idlist, list,,, Program Manager
    listids := []
    loop, %idlist% {
        listids[A_Index] := idlist%A_Index%
    }
    return listids
}

getAllMatches(which) {
    global TITLES
    ids := []
    listids := AltTab_window_list()
    for i,id in listids {
        WinGetTitle title, ahk_id %id%
        WinGet, process, ProcessName, ahk_id %id%
        for k, targettitle in TITLES[which] {
            if (InStr(title, targettitle) or InStr(process, targettitle)) {
                ids.Push(getWindowLocationStirng(id) . " " . process . " :: " . title . " :: " id)
            }
        }
    }
    return ids
}

switchImmediate(which) {
    Gui, Destroy
    match := getAllMatches(which)
    if (match.Count() > 0) {
        id := GetLastWord(match[1])
        WinActivate, ahk_id %id%
        centerMouse()
    }
    return
}

switch(which)
{
  global TITLES
  global chosenid

  Gui, Destroy
  ids := getAllMatches(which)
  count := ids.Count()
  if (count == 1) {
    switchImmediate(which)
    return
  }
  idchoices := ""
  For i, v In ids
    idchoices .= StrReplace(v, "|", " ") . "|"
  idchoices := RTrim(idchoices, "|")
  idchoices := StrReplace(idchoices, "|", "||",,1)
    
  Gui, 1:-Border
  Gui, Font, s9, Consolas
  Gui, Add, Button, w700, Close
  Gui, Add, ListBox, gidchosen vchosenid w700 r10, %idchoices%
  Gui, Add, Button, Hidden Default, IDCHOSEN  
  Gui, Add, Button, w700, Close
  Gui, Show,, AppSwitchByNameListBox
  PostMessage, 0x185, 0, -1, AppSwitchByNameListBox  ; Deselect all items.
  centerMouse()
 
  return
}

run(which) 
{
  global APP_TO_RUN_ON_KEY
  
  WinGet, BEFOREAPP, ID, A
  WinGetTitle beforeT, ahk_id %beforeApp%
  GroupActivate, app_title_to_switch_%which%, R
  WinGet, NOWAPP, ID, A
  
  if (BEFOREAPP == NOWAPP) {
      app := APP_TO_RUN_ON_KEY[which]
      WinGet, ORIGINAL_APP, ID, A
      Run, %app%
      tries := 0
      While (tries < 30) {
        WinGet, CURRENT_APP, ID, A
        if (ORIGINAL_APP != CURRENT_APP) {
            centerMouse()
            return
        }
        Sleep, 100
        tries := tries + 1
      }
  } else {
      centerMouse()
  }
 
  return
}

centerGui() {
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    winCenter_x := winTopL_x + width/2 - 350
    winCenter_y := winTopL_y + height/2
    Gui, Show, x%winCenter_x% y%winCenter_y%, AppSwitchByNameListBox	
	return
}

return

;; for above listview with keyboard  
idchosen:
    If (A_GuiEvent = "Normal") {
        global chosenid
        Gui, Submit
        id := GetLastWord(chosenid)
        WinActivate, ahk_id %id%		
		centerGui()
        centerMouse()   
	}
    return  

;; for above listview with keyboard  
ButtonIDCHOSEN:
    ControlGet, number, List, Count Focused, SysListView321, A
    Trigger_idchosen := true
    GoSub, idchosen
    Trigger_idchosen := false
		
    return

ButtonClose:
    Gui, Destroy	
    return
	
