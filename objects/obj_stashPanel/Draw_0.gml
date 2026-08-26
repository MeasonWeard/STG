draw_self();

if (mode == "select") image_index = 0;
if (mode == "scrap") image_index = 1;

var title = "";

switch(tab) {

	case "devices": title = "Devices"; break;
	case "headgear": title = "Headgear"; break;
	case "ties": title = "Ties"; break;
	case "coats": title = "Coats"; break;
	case "guns": title = "Ranged"; break;
	case "melee": title = "Melee"; break;
	
}
draw_set_font(fnt_large);
draw_set_halign(fa_left);
draw_text(x + 20, y + 16, title);

var itemCount = array_length(displayedItems);
var itemsPerPage = columns * rows;

var maxPageIndex = max(maxPages - 1, 0);

pageIndex = clamp(pageIndex, 0, maxPageIndex);

var startIndex = pageIndex * itemsPerPage;
var endIndex = min(startIndex + itemsPerPage, itemCount);

var startX = x + slotGap;
var startY = y + slotGap + titleGap;

for (var i = startIndex; i < endIndex; i++) {

	var indexOnPage = i - startIndex;

	var col = indexOnPage mod columns;
	var row = indexOnPage div columns;

	var slotX = startX + col * (slotSize + slotGap);
	var slotY = startY + row * (slotSize + slotGap);
	
	var args = [tab, i];
	
	var leftFunc = equipLeft;
	var rightFunc = equipRight;
	
	if (mode == "scrap") {
		leftFunc = scrap;
		rightFunc = scrap;
	}

	scr_ui_drawItemSlot(
		displayedItems[i],
		slotX,
		slotY,
		0,
		slotSize,
		fnt_large,
		true,
		leftFunc,
		args,
		rightFunc,
		args
	);

}