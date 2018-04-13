APP_MEM_OUTPUT_VAR := Object()

; memorize some app window ID on double press of 'key'
; restore the app window by ID on single press of 'key'
; 'which' indicates which memory index to store this ID at, e.g. 1,2,3...
;
; sample use:
;   +!q::memorize(1)
;   !q::restore(1)
;

APP_MEM_TIMEOUT := 400
APP_MEM_MEMORIZED_APPS := Object()
APP_MEM_NUM_PRESSES := 0
APP_MEM_MEMORIZED := ""

app_mem_info() {
  global APP_MEM_MEMORIZED
  MsgBox %APP_MEM_MEMORIZED%
}

memorize_app(which,tag) {
  global APP_MEM_MEMORIZED_APPS
  global APP_MEM_NUM_PRESSES
  global APP_MEM_MEMORIZED
  WinGet, APP_MEM_CURRENT_APP, ID, A
  Winget,APP_TITLE,ProcessName,A
  APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which] := APP_MEM_CURRENT_APP  
  APP_MEM_MEMORIZED = %APP_MEM_MEMORIZED%`r`n%APP_TITLE% (%APP_MEM_NUM_PRESSES% x %tag%)
  TrayTip %APP_TITLE%, (%APP_MEM_NUM_PRESSES% x %tag%),,1
  return
}

memorize(which,tag)
{
    global APP_MEM_NUM_PRESSES
    global APP_MEM_TIMEOUT

    if (A_PriorHotkey <> A_ThisHotkey or A_TimeSincePriorHotkey > APP_MEM_TIMEOUT)
    {
        ; single press
        APP_MEM_NUM_PRESSES := 1
        fn := Func("memorize_app").Bind(which,tag)
        SetTimer, %fn%, -%APP_MEM_TIMEOUT%
        return
    }

    if (A_PriorHotkey == A_ThisHotkey and APP_MEM_NUM_PRESSES >= 1 and A_TimeSincePriorHotkey < APP_MEM_TIMEOUT)
    {
        ; multiple presses
        APP_MEM_NUM_PRESSES := APP_MEM_NUM_PRESSES + 1
        return
    }

    return
}

restore_app(which) {
  global APP_MEM_MEMORIZED_APPS
  global APP_MEM_NUM_PRESSES
  input_var :=  APP_MEM_MEMORIZED_APPS[APP_MEM_NUM_PRESSES, which]
  WinActivate, ahk_id %input_var%
  return
}

restore(which)
{
    global APP_MEM_NUM_PRESSES
    global APP_MEM_TIMEOUT

    if (A_PriorHotkey <> A_ThisHotkey or A_TimeSincePriorHotkey > APP_MEM_TIMEOUT)
    {
        ; single press
        APP_MEM_NUM_PRESSES := 1
        fn := Func("restore_app").Bind(which)
        SetTimer, %fn%, -%APP_MEM_TIMEOUT%
        return
    }

    if (A_PriorHotkey == A_ThisHotkey and APP_MEM_NUM_PRESSES >= 1 and A_TimeSincePriorHotkey < APP_MEM_TIMEOUT)
    {
        ; multiple presses
        APP_MEM_NUM_PRESSES := APP_MEM_NUM_PRESSES + 1
        return
    }

    return
}
