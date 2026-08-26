ic = global.infoController;

txt = "<";

leftFunc = function() {
	
	ic.pageIndex --;
	if (ic.pageIndex < 0 ) ic.pageIndex = array_length(ic.text) - 1;
	
}