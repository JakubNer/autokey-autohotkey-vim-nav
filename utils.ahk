centerMouse() {
    Sleep 50
    CoordMode,Mouse,Screen
    WinGetPos, winTopL_x, winTopL_y, width, height, A
    winCenter_x := winTopL_x + width/2
    winCenter_y := winTopL_y + height/2
    ;MouseMove, X, Y, 0 ; does not work with multi-monitor
    DllCall("SetCursorPos", int, winCenter_x, int, winCenter_y)
    ;Tooltip winTopL_x:%winTopL_x% winTopL_y:%winTopL_y% winCenter_x:%winCenter_x% winCenter_y:%winCenter_y%
}

writeGroup(key) {
	Gui, Destroy
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
}

clearGroup() {
	Gui, Destroy
}
