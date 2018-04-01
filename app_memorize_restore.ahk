APP_MEM_OUTPUT_VAR := Object()

; memorize some app window ID on double press of 'key'
; restore the app window by ID on single press of 'key'
; 'which' indicates which memory index to store this ID at, e.g. 1,2,3...
;
; sample use:
;   +!q::memorize(1)
;   !q::restore(1)
;

APP_MEM_MEMORIZED_APPS := Object()
APP_MEM_NUM_PRESSES := 0

memorize(which)
{
    global APP_MEM_MEMORIZED_APPS
    global APP_MEM_PREVIOUS_APP
    global APP_MEM_NUM_PRESSES

    if (A_PriorHotkey <> A_ThisHotkey or A_TimeSincePriorHotkey > 500)
    {
        ; single press
        APP_MEM_NUM_PRESSES := 1
        APP_MEM_PREVIOUS_APP := APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
        WinGet, APP_MEM_CURRENT_APP, ID, A
        APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which] := APP_MEM_CURRENT_APP
        return
    }

    if (A_PriorHotkey == A_ThisHotkey and APP_MEM_NUM_PRESSES == 1 and A_TimeSincePriorHotkey < 500)
    {
        ; double press
        APP_MEM_NUM_PRESSES := 2
        APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES - 1, which] := APP_MEM_PREVIOUS_APP
        APP_MEM_PREVIOUS_APP := APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
        WinGet, APP_MEM_CURRENT_APP, ID, A
        APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which] := APP_MEM_CURRENT_APP
        return
    }

    if (A_PriorHotkey == A_ThisHotkey and APP_MEM_NUM_PRESSES == 2 and A_TimeSincePriorHotkey < 500)
    {
        ; triple press
        APP_MEM_NUM_PRESSES := 3
        APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES - 1, which] := APP_MEM_PREVIOUS_APP
        APP_MEM_PREVIOUS_APP := APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
        WinGet, APP_MEM_CURRENT_APP, ID, A
        APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which] := APP_MEM_CURRENT_APP
        return
    }

    return
}

restore(which)
{
    global APP_MEM_MEMORIZED_APPS
    global APP_MEM_NUM_PRESSES

    if (A_PriorHotkey <> A_ThisHotkey or A_TimeSincePriorHotkey > 500)
    {
        ; single press
        APP_MEM_NUM_PRESSES := 1
        input_var :=  APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
        WinActivate, ahk_id %input_var%
        return
    }

    if (A_PriorHotkey == A_ThisHotkey and APP_MEM_NUM_PRESSES == 1 and A_TimeSincePriorHotkey < 500)
    {
        ; double press
        APP_MEM_NUM_PRESSES := 2
        input_var :=  APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
        WinActivate, ahk_id %input_var%
        return
    }

    if (A_PriorHotkey == A_ThisHotkey and APP_MEM_NUM_PRESSES == 2 and A_TimeSincePriorHotkey < 500)
    {
        ; triple press
        APP_MEM_NUM_PRESSES := 3
        input_var :=  APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
        WinActivate, ahk_id %input_var%
        return
    }

    return
}

