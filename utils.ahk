centerMouse() {
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    winCenter_x := winTopL_x + width/2
    winCenter_y := winTopL_y + height/2
    ;MouseMove, X, Y, 0 ; does not work with multi-monitor
    DllCall("SetCursorPos", int, winCenter_x, int, winCenter_y)
    ;Tooltip winTopL_x:%winTopL_x% winTopL_y:%winTopL_y% winCenter_x:%winCenter_x% winCenter_y:%winCenter_y%
	return
}

writeGroup(key) {
	Gui, Color, Black
	Gui, Font, s18
	Gui, Margin, 2, 1
	Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
	Gui, +LastFound +AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
	Gui, Add, Text, cWhite, %key%
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Coords, Monitor, MonitorPrimary
	x := coordsRight - 55
	y := coordsBottom - 63
	Gui, Show, x%x% y%y%
	return
}

clearGroup() {
	Gui, Destroy
	return
}

writeMessage(key) {
	Gui, Color, Green
	Gui, Font, s18
	Gui, Margin, 2, 1
	Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
	Gui, +LastFound +AlwaysOnTop -Border -SysMenu +Owner -Caption +ToolWindow
	Gui, Add, Text, cRed BackgroundTrans, %key%
	SysGet, MonitorPrimary, MonitorPrimary
	SysGet, Coords, Monitor, MonitorPrimary
	WinSet, TransColor, Green
	x := coordsLeft
	y := coordsTop
	Gui, Show, x%x% y%y%
	return
}

clearMessage() {
	Gui, Destroy
	return
}

dump(ids)
{
	length := ids.length()
    output := "" . length . "`n`n"
    for key, id in ids {
        WinGetTitle, title, ahk_id %id%
        output .= title . "`n`n"
    }

    MsgBox, %output%
    
    return
}

AltTab_window_list() {
  Global
  Static WS_EX_TOOLWINDOW = 0x80, WS_EX_APPWINDOW = 0x40000, GW_OWNER = 4
  DetectHiddenWindows, Off
  listids := []
  WinGet, wid_List, List,,, Program Manager ; gather a list of running programs
  Loop, %wid_List%
    {
    ownerID := wid := wid_List%A_Index%
    Loop {
      ownerID := Decimal_to_Hex( DllCall("GetWindow", "UInt", ownerID, "UInt", GW_OWNER))
    } Until !Decimal_to_Hex( DllCall("GetWindow", "UInt", ownerID, "UInt", GW_OWNER))
    ownerID := ownerID ? ownerID : wid
    If (Decimal_to_Hex(DllCall("GetLastActivePopup", "UInt", ownerID)) = wid)
      {
      WinGet, es, ExStyle, ahk_id %wid%
      If !((es & WS_EX_TOOLWINDOW) && !(es & WS_EX_APPWINDOW))
        {
			listids.Push(wid)
        }
      }
    }
	return listids
}

GetFirstWord(word, num){
	StringSplit, wordArray, word, % A_Space
	return wordArray%num%
}