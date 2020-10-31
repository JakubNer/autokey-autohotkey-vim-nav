;DockWin v0.3 - Save and Restore window positions when docking/undocking (using hotkeys)
; Paul Troiano, 6/2014
;
; Hotkeys: ^ = Control; ! = Alt; + = Shift; # = Windows key; * = Wildcard;
;          & = Combo keys; Others include ~, $, UP (see "Hotkeys" in Help)

;#InstallKeybdHook
#SingleInstance, Force

RestoreWindowPositionsFromFile() {
  SetTitleMatchMode, 2		; 2: A window's title can contain WinTitle anywhere inside it to be a match. 
  SetTitleMatchMode, Fast		;Fast is default
  DetectHiddenWindows, off	;Off is default
  SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
  CrLf=`r`n
  FileName:="WinPos.txt"
  WinGetActiveTitle, SavedActiveWindow
  ParmVals:="Title x y height width"
  SectionToFind:= SectionHeader()
  SectionFound:= 0
 
  Loop, Read, %FileName%
  {
    if !SectionFound
    {
      ;Read through file until correction section found
      If (A_LoopReadLine<>SectionToFind) 
	Continue
    }	  

		;Exit if another section reached
		If ( SectionFound and SubStr(A_LoopReadLine,1,8)="SECTION:")
			Break

                SectionFound:=1
		Win_Title:="", Win_x:=0, Win_y:=0, Win_width:=0, Win_height:=0

		Loop, Parse, A_LoopReadLine, CSV 
		{
			EqualPos:=InStr(A_LoopField,"=")
			Var:=SubStr(A_LoopField,1,EqualPos-1)
			Val:=SubStr(A_LoopField,EqualPos+1)
			IfInString, ParmVals, %Var%
			{
				;Remove any surrounding double quotes (")
				If (SubStr(Val,1,1)=Chr(34)) 
				{
					StringMid, Val, Val, 2, StrLen(Val)-2
				}
				Win_%Var%:=Val  
			}
		}

		If ( (StrLen(Win_Title) > 0) and WinExist(Win_Title) )
		{	
			WinRestore
			WinActivate
			WinMove, A,,%Win_x%,%Win_y%,%Win_width%,%Win_height%
		}

  }

  if !SectionFound
  {
    msgbox,,Dock Windows, Section does not exist in %FileName% `nLooking for: %SectionToFind%`n`nTo save a new section, use Win-Shift-0 (zero key above letter P on keyboard)
  }

  ;Restore window that was active at beginning of script
  WinActivate, %SavedActiveWindow%
RETURN
}

SaveCurrentWindowsToFile() {
 SetTitleMatchMode, 2		; 2: A window's title can contain WinTitle anywhere inside it to be a match. 
 SetTitleMatchMode, Fast		;Fast is default
 DetectHiddenWindows, off	;Off is default
 SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
 CrLf=`r`n
 FileName:="WinPos.txt"

 WinGetActiveTitle, SavedActiveWindow

 file := FileOpen(FileName, "a")
 if !IsObject(file)
 {
	MsgBox, Can't open "%FileName%" for writing.
	Return
 }

  line:= SectionHeader() . CrLf
  file.Write(line)

  ; Loop through all windows on the entire system
  WinGet, id, list,,, Program Manager
  Loop, %id%
  {
    this_id := id%A_Index%
    WinActivate, ahk_id %this_id%
    WinGetPos, x, y, Width, Height, A ;Wintitle
    WinGetClass, this_class, ahk_id %this_id%
    WinGetTitle, this_title, ahk_id %this_id%

	if ( (StrLen(this_title)>0) and (this_title<>"Start") )
	{
		line=Title="%this_title%"`,x=%x%`,y=%y%`,width=%width%`,height=%height%`r`n
		file.Write(line)
   	}
  }

  file.write(CrLf)  ;Add blank line after section
  file.Close()

  ;Restore active window
  WinActivate, %SavedActiveWindow%
RETURN
}

; -------

;Create standardized section header for later retrieval
SectionHeader()
{
	SysGet, MonitorCount, MonitorCount
	SysGet, MonitorPrimary, MonitorPrimary
	line=SECTION: Monitors=%MonitorCount%,MonitorPrimary=%MonitorPrimary%

        WinGetPos, x, y, Width, Height, Program Manager
	line:= line . "; Desktop size:" . x . "," . y . "," . width . "," . height

	Return %line%
}

;<EOF>