txt = "Scrap";
panel = global.stashPanel;

leftFunc = function() {
	
	if (panel.mode == "select") {
		panel.mode = "scrap";
		txt = "Select";
	} else if (panel.mode == "scrap") {
		panel.mode = "select";
		txt = "Scrap";
	}
		
}