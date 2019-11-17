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

TITLES["a"] := ["powershell.exe", "MINGW64", "Docker Quickstart Terminal"]
TITLES["s"] := ["- Notepad++"]
TITLES["d"] := ["Visual Studio Code", "Microsoft Visual Studio"]
TITLES["f"] := ["Sourcetree", "Google Web Designer", "Postman", "VirtualBox", "Microsoft SQL Server Management Studio", "Internet Information Services (IIS) Manager", "Fiddler"]
TITLES["g"] := ["Snip & Sketch", "ahk_exe PaintDotNet.exe", "Astah", "Pencil", "- MarkdownPad 2"]
TITLES["z"] := ["- Outlook", "Gmail"]
TITLES["x"] := ["| Microsoft Teams", "MightyText", "WhatsApp", "Viber", "Slack", "Messenger", "Discord", "Skype"]
TITLES["c"] := ["Chrome", "Opera", "Firefox", "- Microsoft Edge", "Chromium", "Remote Desktop Connection"]
TITLES["v"] := ["- OneNote", "Google Calendar"]
TITLES["b"] := ["Adobe Acrobat Reader"]

for which, titlez in TITLES {
	for index, title in titlez {
		GroupAdd, switch_%which%, %title%
		GroupAdd, switch_%which%, ahk_exe %title%
	}
}

;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TO RUN ;;

APP_TO_RUN_ON_KEY := {}

APP_TO_RUN_ON_KEY["a"] := "powershell"
APP_TO_RUN_ON_KEY["s"] := "C:\Program Files\Notepad++\notepad++.exe"
APP_TO_RUN_ON_KEY["g"] := "C:\Program Files (x86)\MarkdownPad 2\MarkdownPad2.exe"
APP_TO_RUN_ON_KEY["c"] := "shell:Appsfolder\MSEdgeBeta"
APP_TO_RUN_ON_KEY["v"] := "shell:Appsfolder\chrome"
APP_TO_RUN_ON_KEY["b"] := "shell:Appsfolder\chrome --profile-directory=""Profile 1"""
APP_TO_RUN_ON_KEY["f"] := "C:\Program Files\Freeplane\freeplane.exe"

;; app window titles to consider for app switch before running APP_TO_RUN_ON_KEY above
APP_TITLE_TO_SWITCH_TO_ON_KEY := {}
APP_TITLE_TO_SWITCH_TO_ON_KEY["s"] := "- Notepad++"
APP_TITLE_TO_SWITCH_TO_ON_KEY["f"] := "- Freeplane"
APP_TITLE_TO_SWITCH_TO_ON_KEY["g"] := "- MarkdownPad 2"

for which, title in APP_TITLE_TO_SWITCH_TO_ON_KEY {
	GroupAdd, app_title_to_switch_%which%, %title%
}

switch(which)
{
  global TITLES
  GroupActivate, switch_%which%, R
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