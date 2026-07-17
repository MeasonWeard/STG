global.stashPanel = self;

pageIndex = 0;
maxPages = 0;

tab = "guns";
tabDirty = true;

mode = "select";

image_speed = 0;

//formatting
slotSize = 96;
slotGap = 12;

inventory = global.stashController.inventory;
equippedGear = global.stashController.equippedGear;
equippedWeapons = global.stashController.equippedWeapons;

displayedItems = [];

var height = sprite_height - slotGap * 2;
var width = sprite_width - slotGap * 2;

rows = 0;
while (height >= slotSize) {
	rows++;
	height -= slotSize + slotGap;
}

columns = 0;
while (width >= slotSize) {
	columns++;
	width -= slotSize + slotGap;
}

//functions
equipLeft = function(key, index) {

	var arr = inventory[$ key];
	
	if (is_undefined(arr)) exit;
	
	var len = array_length(arr);
	if (index >= len) exit;
	
	var item = arr[index];
	
	if (is_undefined(item)) exit;
	
	var type = item.type;
	
	if (type == itemTypes.weapon or type == itemTypes.gun or type == itemTypes.melee) {
	
		var oldItem = global.stashController.equippedWeapons.weapon1;
		arr[index] = oldItem;
		
		global.stashController.equippedWeapons.weapon1 = item;
	
	}
	
	if (type == itemTypes.device) {
	
		var oldItem = global.stashController.equippedGear.device1;
		arr[index] = oldItem;
		
		global.stashController.equippedGear.device1 = item;
	
	}
	
	if (type == itemTypes.headgear) {
	
		var oldItem = global.stashController.equippedGear.headgear;
		arr[index] = oldItem;
		
		global.stashController.equippedGear.headgear = item;
	
	}
	
	if (type == itemTypes.tie) {
	
		var oldItem = global.stashController.equippedGear.tie;
		arr[index] = oldItem;
		
		global.stashController.equippedGear.tie = item;
	
	}
	
}

equipRight = function(key, index) {

	var arr = inventory[$ key];
	
	if (is_undefined(arr)) exit;
	
	var len = array_length(arr);
	if (index >= len) exit;
	
	var item = arr[index];
	
	if (is_undefined(item)) exit;
	
	var type = item.type;
	
	if (type == itemTypes.weapon or type == itemTypes.gun or type == itemTypes.melee) {
	
		var oldItem = global.stashController.equippedWeapons.weapon2;
		arr[index] = oldItem;
		
		global.stashController.equippedWeapons.weapon2 = item;
	
	}
	
	if (type == itemTypes.device) {
	
		var oldItem = global.stashController.equippedGear.device2;
		arr[index] = oldItem;
		
		global.stashController.equippedGear.device2 = item;
	
	}
	
	if (type == itemTypes.headgear) {
	
		var oldItem = global.stashController.equippedGear.headgear;
		arr[index] = oldItem;
		
		global.stashController.equippedGear.headgear = item;
	
	}
	
	if (type == itemTypes.tie) {
	
		var oldItem = global.stashController.equippedGear.tie;
		arr[index] = oldItem;
		
		global.stashController.equippedGear.tie = item;
	
	}
	
}

scrap = function(key, index) {
	
	var arr = inventory[$ key];
	
	if (is_undefined(arr)) exit;
	
	var len = array_length(arr);
	if (index >= len) exit;
	
	var item = arr[index];
	
	if (is_undefined(item)) exit;
	
	arr[index] = undefined;
	
	audio_play_sound(snd_recycle, 0, false);
	
}