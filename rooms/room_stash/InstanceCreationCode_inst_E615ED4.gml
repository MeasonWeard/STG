panel = global.stashPanel;
txt = "<";

constantFunc = function() {

	if (instance_exists(panel)) {
		active = panel.pageIndex > 0;
	}
	
}

leftFunc = function() {

	if (instance_exists(panel)) {
		panel.pageIndex --;
		if (panel.pageIndex < 0) panel.pageIndex = 0;
	}

}