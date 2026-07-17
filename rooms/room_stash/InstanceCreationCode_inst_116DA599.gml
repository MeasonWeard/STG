panel = global.stashPanel;
txt = ">";

constantFunc = function() {

	if (instance_exists(panel)) {
		active = panel.pageIndex < panel.maxPages - 1;
	}
	
}

leftFunc = function() {

	if (instance_exists(panel)) {
		panel.pageIndex ++;
		if (panel.pageIndex > panel.maxPages) panel.pageIndex = 0;
	}
	
}