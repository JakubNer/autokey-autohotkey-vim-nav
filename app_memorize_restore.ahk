; - memorize current app ID to group by some 'which' key
; - restore group for 'which' key
;
; sample use:
;   +!q::memorize("a")
;   !q::restore("a")
;

APP_MEM_GROUP := {}
APP_MEM_MAX_APPS_TO_MEM := 7

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

;; transform array of IDs by reversing and trimming to APP_MEM_MAX_APPS_TO_MEM
transform(listids) {
	global APP_MEM_MAX_APPS_TO_MEM
	result := []
	for i,id in listids {
		if (result.length() >= APP_MEM_MAX_APPS_TO_MEM) {
			break
		}
		wingettitle, title, ahk_id %id%
		winget, wstate, minmax, ahk_id %id%
		if (title != "") && (wstate == 1 || wstate == 0) {
			result.InsertAt(1, id)
		}
	}
	return result
}

memorize(which)
{
	global APP_MEM_GROUP

	listids := AltTab_window_list()
	listids := transform(listids)

	APP_MEM_GROUP[which] := listids
	return
}

restoreall(which)
{
	global APP_MEM_GROUP

	for i,id in APP_MEM_GROUP[which] {
		WinActivate, ahk_id %id%
	}

	return
}