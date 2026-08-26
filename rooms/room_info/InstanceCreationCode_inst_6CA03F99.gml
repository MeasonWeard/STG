ic = global.infoController;
font = fnt_large;
hAlign = fa_middle;
vAlign = fa_middle;

textGetter = function() {

	var page = ic.pageIndex + 1;
	var pages = array_length(ic.text);
	
	return "Page " + string(page) + " of " + string(pages);
	
}