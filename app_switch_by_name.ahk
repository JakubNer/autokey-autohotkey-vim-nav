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

getIds() {
	WinGet, idlist, list,,, Program Manager
	listids := []
    loop, %idlist% {
		listids[A_Index] := idlist%A_Index%
	}
	return listids
}

SortArray(Array, Order="A") {
    ;Order A: Ascending, D: Descending, R: Reverse
    MaxIndex := ObjMaxIndex(Array)
    If (Order = "R") {
        count := 0
        Loop, % MaxIndex
            ObjInsert(Array, ObjRemove(Array, MaxIndex - count++))
        Return
    }
    Partitions := "|" ObjMinIndex(Array) "," MaxIndex
    Loop {
        comma := InStr(this_partition := SubStr(Partitions, InStr(Partitions, "|", False, 0)+1), ",")
        spos := pivot := SubStr(this_partition, 1, comma-1) , epos := SubStr(this_partition, comma+1)    
        if (Order = "A") {    
            Loop, % epos - spos {
                if (Array[pivot] > Array[A_Index+spos])
                    ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))    
            }
        } else {
            Loop, % epos - spos {
                if (Array[pivot] < Array[A_Index+spos])
                    ObjInsert(Array, pivot++, ObjRemove(Array, A_Index+spos))    
            }
        }
        Partitions := SubStr(Partitions, 1, InStr(Partitions, "|", False, 0)-1)
        if (pivot - spos) > 1    ;if more than one elements
            Partitions .= "|" spos "," pivot-1        ;the left partition
        if (epos - pivot) > 1    ;if more than one elements
            Partitions .= "|" pivot+1 "," epos        ;the right partition
    } Until !Partitions
}

ID_FLIPPED_ALREADY := []

switch(which, LIMITING_APP_IDS)
{
  global TITLES
  global ID_FLIPPED_ALREADY
  
  if (LIMITING_APP_IDS.length() > 0) {
	WinGet, active_id, id,A
	listids := getIds()
	SortArray(listids)
	Loop {
		for i,id in listids {
			if (active_id != id) {
				if (!HasVal(ID_FLIPPED_ALREADY, id)) {
					for j,value in LIMITING_APP_IDS {
						if (id == value) {
							WinGetTitle title, ahk_id %value%
							WinGet, process, ProcessName, ahk_id %value%
							for k, targettitle in TITLES[which] {
								if (InStr(title, targettitle) or InStr(process, targettitle)) {
									WinActivate, ahk_id %value%
									ID_FLIPPED_ALREADY.Push(value)
									centerMouse()
									return
								}
							}
						}
					}
				}
			}
		}
		if (ID_FLIPPED_ALREADY.Length() == 0) {
			break
		}
		ID_FLIPPED_ALREADY := []	
	}
  } else {
    GroupActivate, switch_%which%, R
    centerMouse()
  }
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