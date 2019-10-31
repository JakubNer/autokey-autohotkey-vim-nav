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

TITLES["a"] := ["Windows PowerShell", "Administrator: ", "powershell (running as", "MINGW64", "Docker Quickstart Terminal"]
TITLES["s"] := ["Notepad++", "miMind", "Freeplane"]
TITLES["d"] := ["Visual Studio Code", "Microsoft Visual Studio"]
TITLES["f"] := ["Sourcetree", "Google Web Designer", "Postman", "VirtualBox", "Microsoft SQL Server Management Studio", "Internet Information Services (IIS) Manager"]
TITLES["g"] := ["Snip & Sketch", "ahk_exe PaintDotNet.exe", "Astah", "Pencil"]
TITLES["z"] := ["- Outlook", "Gmail"]
TITLES["x"] := ["| Microsoft Teams", "MightyText", "WhatsApp", "Viber", "Slack", "Messenger", "Discord", "Skype"]
TITLES["c"] := ["Chrome", "Opera", "Firefox", "- Microsoft Edge", "Chromium", "Remote Desktop Connection"]
TITLES["v"] := ["- OneNote", "Google Calendar"]
TITLES["b"] := ["Adobe Acrobat Reader"]

for which, titles in TITLES {
	for index, title in titles {
		GroupAdd, switch_%which%, %title%
	}
}


;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TO RUN ;;

APP_TO_RUN_ON_KEY := {}

APP_TO_RUN_ON_KEY["a"] := "powershell"
APP_TO_RUN_ON_KEY["s"] := "C:\Program Files\Notepad++\notepad++.exe"
APP_TO_RUN_ON_KEY["c"] := "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
APP_TO_RUN_ON_KEY["v"] := "C:\Users\jakub\AppData\Local\Chromium\Application\chrome.exe --profile-directory=""Profile 1"""

switch(which, LIMITING_APP_IDS)
{
  WinGet, beforeApp, ID, A
  WinGetTitle beforeT, ahk_id %beforeApp%
  GroupActivate, switch_%which%, R
  WinGet, FIRST_APP, ID, A
  CURRENT_APP := FIRST_APP
  if (LIMITING_APP_IDS.length() > 0 && ! HasVal(LIMITING_APP_IDS, FIRST_APP)) {
	Loop {
		GroupActivate, switch_%which%, R
		if (! HasVal(LIMITING_APP_IDS, CURRENT_APP)) {
			WinMinimize, ahk_id %CURRENT_APP%
		}
		WinGet, CURRENT_APP, ID, A
		if (FIRST_APP == CURRENT_APP) {
			break
		}
		if (HasVal(LIMITING_APP_IDS, CURRENT_APP)) {
			break
		}
	}
  }
  WinGet, afterApp, ID, A
  WinGetTitle afterT, ahk_id %afterApp%
  ;;TrayTip,, %beforeT% (%beforeApp%) `r`r %afterT% (%afterApp%), 1, 17
  centerMouse()
  return
}

run(which) 
{
  global APP_TO_RUN_ON_KEY
  app := APP_TO_RUN_ON_KEY[which]
  Run, %app%
  centerMouse()
}