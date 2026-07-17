stashController = global.stashController;

slotSize = 96;
item = undefined;

slotKey = "";
type = undefined;

unequip = function () {
	
	if (is_undefined(item)) exit;
	
	//get array
	var invKey = undefined;
	
	if (item.type == itemTypes.gun) invKey = "guns";
	if (item.type == itemTypes.melee) invKey = "melee";
	if (item.type == itemTypes.device) invKey = "devices";
	if (item.type == itemTypes.headgear) invKey = "headgear";
	if (item.type == itemTypes.tie) invKey = "ties";
	
	var arr = stashController.inventory[$ invKey];
	
	if (is_undefined(arr)) exit;
	
	//look for an empty spot first
	var len = array_length(arr);
	var found = false;
	for (var i = 0; i < len; i++) {
	
		var entry = arr[i];
		if (is_undefined(entry)) {
			arr[i] = item;
			found = true;
			break;
		}
		
	}
	
	//add to end if no spot found
	if (!found) array_push(arr, item);
	
	//clear
	item = undefined;
	
	if (type == itemTypes.weapon) {
		stashController.equippedWeapons[$ slotKey] = undefined;
	}
	
	if (type == itemTypes.gear) {
		stashController.equippedGear[$ slotKey] = undefined;
	}
	
	//refresh panel
	global.stashPanel.tabDirty = true;
	
}