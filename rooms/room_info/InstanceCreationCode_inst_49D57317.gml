ic = global.infoController;

txt = ">";

leftFunc = function() {
	
	ic.pageIndex ++;
	if (ic.pageIndex >= array_length(ic.text)) ic.pageIndex = 0;
	
}