#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; cursor movements
>^h:: 
{
    SendInput {Left}
    return
}
>^j:: 
{
    SendInput {Down}
    return
}
>^k:: 
{
    SendInput {Up}
    return
}
>^l:: 
{
    SendInput {Right}
    return
}
>^g:: 
{
    SendInput ^{Home}
    return
}
>^+g:: 
{
    SendInput ^{End}
    return
}
>^b:: 
{
    SendInput {PgUp}
    return
}
>^f:: 
{
    SendInput {PgDn}
    return
}
>^e::
{
    SendInput ^{Up}
    return
}
>^y::
{
    SendInput ^{Down}
    return
}

; page movements
>^w:: 
{
    SendInput ^{Right}
    return
}
>^q:: 
{
    SendInput ^{Left}
    return
}
>^d:: 
{
    SendInput {Delete}
    return
}
>^0:: ; Add to the inputNumber if inputNumber != null, otherwise HOME
{
    SendInput {Home}
    return
}
>^-:: 
{
    SendInput {End}
    return
}
>^$:: 
{
    SendInput {End}
    return
}

; selection movements with Shift
>^+h:: 
{
    SendInput +{Left}
    return
}
>^+j:: 
{
    SendInput +{Down}
    return
}
>^+k:: 
{
    SendInput +{Up}
    return
}
>^+l::
{
    SendInput +{Right}
    return
}
>^+w:: 
{
    SendInput +^{Right}
    return
}
>^+q:: 
{
    SendInput +^{Left}
    return
}
>^+d:: 
{
    SendInput +{Delete}
    return
}
>^):: 
{
    SendInput +{Home}
    return
}
>^_:: 
{
    SendInput +{End}
    return
}

; selection movements with Shift
>^!h:: 
{
    SendInput {Browser_Back}
    return
}
; selection movements with Shift
>^!l:: 
{
    SendInput {Browser_Forward}
    return
}
