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

GetFirstWord(words) {
	wordArray := StrSplit(words, A_Space)
	num := 1
	return wordArray[num]
}

GetLastWord(words) {
	wordArray := StrSplit(words, A_Space)
	num := wordArray.MaxIndex()
	return wordArray[num]
}

PRESS_TRACK := {}
toggleLastTime(which) {
	global PRESS_TRACK
    last := PRESS_TRACK[which]
	PRESS_TRACK[which] := A_TickCount
	if (!last) {
		return 999999
	}	
	return A_TickCount - last
}

getWindowLocationStirng(id) {	
    WinGetPos, winTopL_x, winTopL_y, width, height, ahk_id %id%
    winCenter_x := winTopL_x + width/2
    winCenter_y := winTopL_y + height/2
    ;;Tooltip winTopL_x:%winTopL_x% winTopL_y:%winTopL_y% winCenter_x:%winCenter_x% winCenter_y:%winCenter_y%

	locationString := "["
	SysGet, Count, MonitorCount
	num = 1
	Loop, %Count%
	{
		SysGet, Mon, MonitorWorkArea, %num%

	    ;;MsgBox, %winCenter_x% %winCenter_y% %MonLeft% %MonRight% %MonTop% %MonBottom%
		if( winCenter_x >= MonLeft && winCenter_x <= MonRight && winCenter_y >= MonTop && winCenter_y <= MonBottom )
		{
			if ( winCenter_y > (MonTop + ((MonBottom - MonTop) / 2)) ) {
				locationChar := "v"
			} Else If ( winCenter_y < (MonTop + ((MonBottom - MonTop) / 2)) ) {
				locationChar := "^"
			} Else {
				locationChar := "="
			}
		
			if ( winCenter_x < (MonLeft + ((MonRight - MonLeft) / 2)) ) {
				locationString .= locationChar . " "
			} Else if ( winCenter_x > (MonLeft + ((MonRight - MonLeft) / 2)) ) {
				locationString .= " " . locationChar
			} Else {
				locationString .= locationChar . locationChar
			}
		} else {
			locationString .= "  "
		}
		num += 1
	}
	locationString .= "]"
	return locationString
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