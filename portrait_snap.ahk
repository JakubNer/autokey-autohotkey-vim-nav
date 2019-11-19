; dir 0 = top part
; dir 1 = bottom part
; size 0 = half of screen
; size 1 = third of screen

ResizeWin(dir = 1, size = 0)
{
    WinGet activeWin, ID, A
    activeMon := GetMonitorIndexFromWindow(activeWin)

    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%

    w := MonitorWorkAreaRight - MonitorWorkAreaLeft
    if (size == 0)
        h := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/2
    else
        h := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/3

    if (dir == 1)
        t := MonitorWorkAreaBottom - h
    else
        t := MonitorWorkAreaTop

    WinMove,A,,%MonitorWorkAreaLeft%,%t%,%w%,%h%
}

; From http://www.autohotkey.com/board/topic/69464-how-to-determine-a-window-is-in-which-monitor/
GetMonitorIndexFromWindow(windowHandle)
{
    ; Starts with 1.
    monitorIndex := 1

    VarSetCapacity(monitorInfo, 40)
    NumPut(40, monitorInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2)) 
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) 
    {
        monitorLeft   := NumGet(monitorInfo,  4, "Int")
        monitorTop    := NumGet(monitorInfo,  8, "Int")
        monitorRight  := NumGet(monitorInfo, 12, "Int")
        monitorBottom := NumGet(monitorInfo, 16, "Int")
        workLeft      := NumGet(monitorInfo, 20, "Int")
        workTop       := NumGet(monitorInfo, 24, "Int")
        workRight     := NumGet(monitorInfo, 28, "Int")
        workBottom    := NumGet(monitorInfo, 32, "Int")
        isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

        SysGet, monitorCount, MonitorCount

        Loop, %monitorCount%
        {
            SysGet, tempMon, Monitor, %A_Index%

            ; Compare location to determine the monitor index.
            if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
                and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom))
            {
                monitorIndex := A_Index
                break
            }
        }
    }

    return %monitorIndex%
}

