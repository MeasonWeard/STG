ic = global.infoController;

txt = "<";

leftKey = ord("A");
rightKey = vk_left;

leftFunc = function() {
	
	ic.pageIndex --;
	if (ic.pageIndex < 0 ) ic.pageIndex = array_length(ic.text) - 1;
	
}

rightFunc = leftFunc;