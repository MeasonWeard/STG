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