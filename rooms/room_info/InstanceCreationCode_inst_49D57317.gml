ic = global.infoController;

txt = ">";

leftKey = ord("D");
rightKey = vk_right;

leftFunc = function() {
	
	ic.pageIndex ++;
	if (ic.pageIndex >= array_length(ic.text)) ic.pageIndex = 0;
	
}

rightFunc = leftFunc;