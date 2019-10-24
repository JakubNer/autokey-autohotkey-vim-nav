APP_MEM_OUTPUT_VAR := Object()

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

ensureAppMemGroupCount(which, index) {
  global APP_MEM_GROUP_COUNT
  global APP_MEM_GROUP_IDS
  if (! APP_MEM_GROUP_COUNT.HasKey(%which%_%index%)) {
    APP_MEM_GROUP_COUNT[%which%_%index%] := 0
	APP_MEM_GROUP_IDS[%which%_%index%] := []
  }
}

incrementAppMemGroupCount(which, index) {
	global APP_MEM_GROUP_COUNT
	APP_MEM_GROUP_COUNT[%which%_%index%] := APP_MEM_GROUP_COUNT[%which%_%index%] + 1
}

resetAppMemGroupCount(which, index) {
	global APP_MEM_GROUP_COUNT
	APP_MEM_GROUP_COUNT.Delete(%which%_%index%)
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
  if (! HasVal(APP_MEM_GROUP_IDS[%which%_%index%], APP_MEM_CURRENT_APP)) {
  	  APP_MEM_GROUP_IDS[%which%_%index%].Push(APP_MEM_CURRENT_APP)
	  GroupAdd, memorize_app_%which%_%index%, ahk_id %APP_MEM_CURRENT_APP%
	  incrementAppMemGroupCount(which, index)
  }
  return
}

reset_memory(which) {
  global APP_MEM_GROUP_INDICES
  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  } else {
	index := APP_MEM_GROUP_INDICES[which]
	resetAppMemGroupCount(which, index)
    APP_MEM_GROUP_INDICES[which] := APP_MEM_GROUP_INDICES[which] + 1
  }
}

restore(which)
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT
  index := APP_MEM_GROUP_INDICES[which]
  ensureAppMemGroupCount(which, index)
  count := APP_MEM_GROUP_COUNT[%which%_%index%]
  seen := []
  firstOneActive := false
  while count > 0 {
    GroupActivate, memorize_app_%which%_%index%, R
	count := count - 1
	WinGet, APP_MEM_CURRENT_APP, ID, A
	if (! HasVal(seen, APP_MEM_CURRENT_APP)) {
		seen.Push(APP_MEM_CURRENT_APP)
	} else {
		firstOneActive := true
		break
	}
  }
  if (! firstOneActive) {
    GroupActivate, memorize_app_%which%_%index%, R
  }
  return
}
