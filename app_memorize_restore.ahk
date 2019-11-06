2APP_MEM_OUTPUT_VAR := Object()

; - memorize current app ID to group by some 'which' key
; - toggle through apps in group by some 'which' key
; - reset group for 'which' key
;
; sample use:
;   +!q::memorize("a")
;   !q::restore("a")
;   ^+!q::reset_memory("a")
;

APP_MEM_GROUP_INDICES := {}
APP_MEM_GROUP_COUNT := {}
APP_MEM_GROUP_IDS := {}

HasVal(haystack, needle) {
	for index,value in haystack
		if (value = needle)
			return true
	return false
}

Remove(haystack, what) {
	count := 0
	newhaystack := []
	for index,value in haystack {
		if (value != what) {
			newhaystack.push((string)value)
		}
	}
	return newhaystack
}

ensureAppMemGroupCount(which, index) {
  global APP_MEM_GROUP_COUNT
  global APP_MEM_GROUP_IDS
  if (! APP_MEM_GROUP_COUNT.HasKey(which . "_" . index)) {
    APP_MEM_GROUP_COUNT[which . "_" . index] := 0
	APP_MEM_GROUP_IDS[which . "_" . index] := []
  }
}

incrementAppMemGroupCount(which, index) {
	global APP_MEM_GROUP_COUNT
    if (! APP_MEM_GROUP_COUNT.HasKey(which . "_" . index)) {
      APP_MEM_GROUP_COUNT[which . "_" . index] := 0
    }	
    if (APP_MEM_GROUP_COUNT[which . "_" . index] < 0) {
      APP_MEM_GROUP_COUNT[which . "_" . index] := 0
    }	
	APP_MEM_GROUP_COUNT[which . "_" . index] := APP_MEM_GROUP_COUNT[which . "_" . index] + 1
}

setAppMemGroupCount(which, index, count) {
	global APP_MEM_GROUP_COUNT
	APP_MEM_GROUP_COUNT[which . "_" . index] := count
}

memorize(which)
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT
  global APP_MEM_GROUP_IDS

  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  }
  index := APP_MEM_GROUP_INDICES[which]
  ensureAppMemGroupCount(which, index)

  WinGet, APP_MEM_CURRENT_APP, ID, A
  Winget,APP_TITLE,ProcessName,A
  if (! HasVal(APP_MEM_GROUP_IDS[which . "_" . index], APP_MEM_CURRENT_APP)) {
  	  APP_MEM_GROUP_IDS[which . "_" . index].Push(APP_MEM_CURRENT_APP)
	  GroupAdd, memorize_app_%which%_%index%, ahk_id %APP_MEM_CURRENT_APP%
	  incrementAppMemGroupCount(which, index)
  }
  return
}

reset_memory(which) {
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_IDS
  WinGet, APP_MEM_CURRENT_APP, ID, A  
  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  } else {
	index := APP_MEM_GROUP_INDICES[which]
	toreadd := []
	single := false
    if (HasVal(APP_MEM_GROUP_IDS[which . "_" . index], APP_MEM_CURRENT_APP)) {
		MsgBox, 4,, Forget just current app or all? ("Yes" for current, "No" for all)
		IfMsgBox Yes 
			single := true
		if (single)
		{
			toreadd := Remove(APP_MEM_GROUP_IDS[which . "_" . index],APP_MEM_CURRENT_APP)
		}
	}
	if (!single) {
		MsgBox, 4,, Are you sure you want to forget all?
		IfMsgBox No
			return
	}
    APP_MEM_GROUP_INDICES[which] := APP_MEM_GROUP_INDICES[which] + 1
	setAppMemGroupCount(which, index, 0)
	if (toreadd.length() > 0) {
		index := index + 1
		APP_MEM_GROUP_IDS[which . "_" . index] := toreadd
		for key, value in toreadd {
			GroupAdd, memorize_app_%which%_%index%, ahk_id %value%
		}		
	} 
	setAppMemGroupCount(which, index, toreadd.Count())
  }
}

restoreone(which)
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT
  index := APP_MEM_GROUP_INDICES[which]
  ensureAppMemGroupCount(which, index)
  GroupActivate, memorize_app_%which%_%index%, R
  WinGet, APP_MEM_CURRENT_APP, ID, A
  centerMouse()
  return
}

restoreall(which)
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT
  index := APP_MEM_GROUP_INDICES[which]
  ensureAppMemGroupCount(which, index)
  count := APP_MEM_GROUP_COUNT[which . "_" . index]
  seen := []
  while count > 0 {
    GroupActivate, memorize_app_%which%_%index%, R
	count := count - 1
	WinGet, APP_MEM_CURRENT_APP, ID, A
	if (! HasVal(seen, APP_MEM_CURRENT_APP)) {
		seen.Push(APP_MEM_CURRENT_APP)
	} else {
		break
	}
  }
  return
}

retrieve(which) 
{
	global APP_MEM_GROUP_IDS
	global APP_MEM_GROUP_INDICES
	index := APP_MEM_GROUP_INDICES[which]
	return APP_MEM_GROUP_IDS[which . "_" . index]
}

dump(ids)
{
	output := ""  
	for key, id in ids {
		WinGetTitle, title, ahk_id %id%
		output .= title . "`n`n"
	}

	MsgBox, %output%
	return
}

debug()
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT
  global APP_MEM_GROUP_IDS
  
  output := "vim.ahk DUMP`n`n"  

  for which, index in APP_MEM_GROUP_INDICES {
	output .= "`n`nWHICH: " . which . "    INDEX: " . index . "     COUNT: " . APP_MEM_GROUP_COUNT[which . "_" . index]
	ids := APP_MEM_GROUP_IDS[which . "_" . index]
	for key, id in ids {
		WinGetTitle, title, ahk_id %id%
		output .= "`n   " . id . "`n      " title
	}
  }

  MsgBox, %output%
  return
}
