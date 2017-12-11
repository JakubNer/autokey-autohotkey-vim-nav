APP_MEM_OUTPUT_VAR := Object()

; memorize some app window ID on double press of 'key'
; restore the app window by ID on single press of 'key'
; 'which' indicates which memory index to store this ID at, e.g. 1,2,3...
;
; sample use: 
;   !q::memorizeOrRestore(1,"!q")
;
memorizeOrRestore(which,key)
{
    global APP_MEM_OUTPUT_VAR
    global APP_MEM_OUTPUT_VAR_BEFORE_CLICK
    
    if (A_PriorHotkey <> key or A_TimeSincePriorHotkey > 400)
    {
        ; single press
        WinGet, APP_MEM_OUTPUT_VAR_BEFORE_CLICK, ID, A
        input_var :=  APP_MEM_OUTPUT_VAR[which]
        WinActivate, ahk_id %input_var%
        return
    }
    ; double press    
    APP_MEM_OUTPUT_VAR[which] := APP_MEM_OUTPUT_VAR_BEFORE_CLICK
    WinActivate, ahk_id %APP_MEM_OUTPUT_VAR_BEFORE_CLICK%
    return
}

