;; script by MrMaxP: https://autohotkey.com/board/topic/108780-move-window-to-half-quarter-of-current-monitor/
;; script by ophthalmos:  https://autohotkey.com/boards/viewtopic.php?t=13288

;; My function to reset last 4 windows to corners
TopFourToCorners()
{
  Global
  AltTabTotalNum = 0;
  AltTabListID_1 =    ; hwnd from last active windows
  AltTabListID_2 =    ; hwnd from previous active windows
  AltTabListID_3 = ;
  AltTabListID_4 = ; 
  AltTabWindows()
  
  ;; do them in this order so tab order remains as it should
  
  ;; 4th to lower right
  WinActivate, ahk_id %AltTabListID_4%
  time := A_Now
  loop
  {
    Sleep, 20
    WinGet, which, ID, A
    if (which = AltTabListID_4)
      break
    if (A_Now > time + 5)
      break
  }
  MoveIt(3)

  ;; 3rd to lower left
  WinActivate, ahk_id %AltTabListID_3%
  time := A_Now
  loop
  {
    Sleep, 20
    WinGet, which, ID, A
    if (which = AltTabListID_3)
      break
    if (A_Now > time + 5)
      break
  }
  MoveIt(1)

  ;; 2nd to upper right
  WinActivate, ahk_id %AltTabListID_2%
  time := A_Now
  loop
  {
    Sleep, 20
    WinGet, which, ID, A
    if (which = AltTabListID_2)
      break
    if (A_Now > time + 5)
      break
  }
  MoveIt(9)

  ;; main to upper left
  WinActivate, ahk_id %AltTabListID_1%
  time := A_Now
  loop
  {
    Sleep, 20
    WinGet, which, ID, A
    if (which = AltTabListID_1)
      break
    if (A_Now > time + 5)
      break
  }
  MoveIt(7)
  return
}

WS_EX_APPWINDOW = 0x40000 ; provides a taskbar button
WS_EX_TOOLWINDOW = 0x80 ; removes the window from the alt-tab list
GW_OWNER = 4

AltTabWindows() {
  Global
  AltTabTotalNum := 0 ; the number of windows found
  AltTabListID_1 =    ; hwnd from last active windows
  AltTabListID_2 =    ; hwnd from previous active windows
  AltTabListID_3 = ;
  AltTabListID_4 = ;
  windowList =
  DetectHiddenWindows, Off ; makes DllCall("IsWindowVisible") unnecessary
  WinGet, windowList, List ; gather a list of running programs
  Loop, %windowList%
    {
    ownerID := windowID := windowList%A_Index%
    Loop {
      ownerID := Decimal_to_Hex( DllCall("GetWindow", "UInt", ownerID, "UInt", GW_OWNER))
    } Until !Decimal_to_Hex( DllCall("GetWindow", "UInt", ownerID, "UInt", GW_OWNER))
    ownerID := ownerID ? ownerID : windowID
    If (Decimal_to_Hex(DllCall("GetLastActivePopup", "UInt", ownerID)) = windowID)
      {
      WinGet, es, ExStyle, ahk_id %windowID%
      If (!((es & WS_EX_TOOLWINDOW) && !(es & WS_EX_APPWINDOW)) && !IsInvisibleWin10BackgroundAppWindow(windowID))
        {
          AltTabTotalNum ++
          AltTabListID_%AltTabTotalNum% := windowID
        }
      }
    }
  }
  
  Decimal_to_Hex(var) {
  SetFormat, IntegerFast, H
  var += 0 
  var .= "" 
  SetFormat, Integer, D
  return var
}

IsInvisibleWin10BackgroundAppWindow(hWindow) {
  result := 0
  VarSetCapacity(cloakedVal, A_PtrSize) ; DWMWA_CLOAKED := 14
  hr := DllCall("DwmApi\DwmGetWindowAttribute", "Ptr", hWindow, "UInt", 14, "Ptr", &cloakedVal, "UInt", A_PtrSize)
  if !hr ; returns S_OK (which is zero) on success. Otherwise, it returns an HRESULT error code
    result := NumGet(cloakedVal) ; omitting the "&" performs better
  return result ? true : false
  }

/*
DWMWA_CLOAKED: If the window is cloaked, the following values explain why:
1  The window was cloaked by its owner application (DWM_CLOAKED_APP)
2  The window was cloaked by the Shell (DWM_CLOAKED_SHELL)
4  The cloak value was inherited from its owner window (DWM_CLOAKED_INHERITED)
*/

MoveIt(Q)
{
  ; Get the windows pos
	WinGetPos,X,Y,W,H,A,,,
	WinGet,M,MinMax,A

  ; Calculate the top center edge
  CX := X + W/2
  CY := Y + 20

  ;MsgBox, X: %X% Y: %Y% W: %W% H: %H% CX: %CX% CY: %CY%

  SysGet, Count, MonitorCount

  num = 1
  Loop, %Count%
  {
    SysGet, Mon, MonitorWorkArea, %num%

    if( CX >= MonLeft && CX <= MonRight && CY >= MonTop && CY <= MonBottom )
    {
		MW := (MonRight - MonLeft)
		MH := (MonBottom - MonTop)
		MHW := (MW / 2)
		MHH := (MH / 2)
		MMX := MonLeft + MHW
		MMY := MonTop + MHH

		if( M != 0 )
			WinRestore,A

		if( Q == 1 )
			WinMove,A,,MonLeft,MMY,MHW,MHH
		if( Q == 2 )
			WinMove,A,,MonLeft,MMY,MW,MHH
		if( Q == 3 )
			WinMove,A,,MMX,MMY,MHW,MHH
		if( Q == 4 )
			WinMove,A,,MonLeft,MonTop,MHW,MH
		if( Q == 5 )
		{
			if( M == 0 )
				WinMaximize,A
			else
				WinRestore,A
		}
		if( Q == 6 )
			WinMove,A,,MMX,MonTop,MHW,MH
		if( Q == 7 )
			WinMove,A,,MonLeft,MonTop,MHW,MHH
		if( Q == 8 )
			WinMove,A,,MonLeft,MonTop,MW,MHH
		if( Q == 9 )
			WinMove,A,,MMX,MonTop,MHW,MHH
        return
    }

    num += 1
  }

return
}
