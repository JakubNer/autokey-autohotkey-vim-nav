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
;; COFIGURE APP TITLES TO RECALL ;;

TITLES["a"] := ["ConsoleZ", "cmd.exe", "WindowsTerminal.exe", "powershell.exe", "MINGW64", "Docker Quickstart Terminal"]
TITLES["s"] := ["mstsc.exe", "Virtual Machine Connection", "ahk_exe VmConnect.exe", "VmConnect.exe"]
TITLES["d"] := ["Visual Studio Code", "Microsoft Visual Studio", "DevTools - "]
TITLES["f"] := ["Sourcetree", "Git Extensions", "Google Web Designer", "Postman", "VirtualBox", "Microsoft SQL Server Management Studio", "Internet Information Services (IIS) Manager", "Fiddler"]
TITLES["g"] := ["Snip & Sketch", "ahk_exe PaintDotNet.exe", "Astah", "Pencil", "- Typora"]
TITLES["z"] := ["outlook.exe", "teams.exe"]
TITLES["x"] := ["Gmail", "MightyText", "WhatsApp", "Viber", "Slack", "Messenger", "Discord", "Skype", "Google Calendar"]
TITLES["c"] := ["- Microsoft Edge", "msedge.exe"]
TITLES["v"] := ["- Chromium", "- Google Chrome"]
TITLES["b"] := ["- OneNote", "Adobe Acrobat Reader"]

;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TO RUN ;;

APP_TO_RUN_ON_KEY := {}

APP_TO_RUN_ON_KEY["a"] := "*RunAs c:\jj\usr\ConsoleZ\Console.exe"
APP_TO_RUN_ON_KEY["s"] := "C:\Program Files\Notepad++\notepad++.exe"
APP_TO_RUN_ON_KEY["g"] := "C:\Program Files\Typora\Typora.exe"
APP_TO_RUN_ON_KEY["c"] := "shell:Appsfolder\msedge"
APP_TO_RUN_ON_KEY["v"] := "C:\Users\janer\AppData\Local\Chromium\Application\chrome.exe"
APP_TO_RUN_ON_KEY["f"] := "C:\Program Files\Freeplane\freeplane.exe"
APP_TO_RUN_ON_KEY["x"] := """C:\Program Files (x86)\Google\Chrome\Application\chrome_proxy.exe""  --profile-directory=Default --app-id=kjbdgfilnfhdoflbpgamdcdgpehopbep"

;; app window titles to consider for app switch before running APP_TO_RUN_ON_KEY above
APP_TITLE_TO_SWITCH_TO_ON_KEY := {}
APP_TITLE_TO_SWITCH_TO_ON_KEY["a"] := "ConsoleZ"
APP_TITLE_TO_SWITCH_TO_ON_KEY["s"] := "- Notepad++"
APP_TITLE_TO_SWITCH_TO_ON_KEY["f"] := "- Freeplane"
APP_TITLE_TO_SWITCH_TO_ON_KEY["g"] := "- Typora"
APP_TITLE_TO_SWITCH_TO_ON_KEY["x"] := "Google Calendar"
APP_TITLE_TO_SWITCH_TO_ON_KEY["c"] := "- Microsoft Edge"
APP_TITLE_TO_SWITCH_TO_ON_KEY["v"] := "- Chromium"

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
				ids.Push(id . " -- " . process . " :: " . title)
			}
		}
	}
	return ids
}

switchImmediate(which) {
	Gui, Destroy
	match := getAllMatches(which)
	if (match.Count() > 0) {
		id := match[1]
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
    idchoices .= v . "|"
  idchoices := RTrim(idchoices, "|")
  idchoices := StrReplace(idchoices, "|", "||",,1)
  Gui, Add, ListBox, gidchosen vchosenid w600 r20, %idchoices%
  Gui, Add, Button, Hidden Default, IDCHOSEN  
  Gui, Show
  centerMouse()
  return
}

;; for above listview with keyboard  
idchosen:
	If ((A_GuiEvent = "DoubleClick") || (Trigger_idchosen))
	{
		global chosenid
		Gui, Submit
		Gui, Destroy
		id := GetFirstWord(chosenid, 1)
		WinActivate, ahk_id %id%
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