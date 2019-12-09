; - memorize current app ID to group by some 'which' key
; - restore group for 'which' key
;
; sample use:
;   +!q::memorize("a")
;   !q::restore("a")
;

APP_MEM_GROUP := {}
APP_MEM_MAX_APPS_TO_MEM := 7

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