hAlign = fa_right;
vAlign = fa_middle;
panel = global.stashPanel;

col = c_lime;
font = fnt_large;

textGetter = function() {

	var maxPages = panel.maxPages;
	var pageIndex = panel.pageIndex;
	
	var txt = string(pageIndex + 1) + "/" + string(maxPages);
	return txt;
	
}