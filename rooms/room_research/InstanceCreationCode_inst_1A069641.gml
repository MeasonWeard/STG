rc = global.researchController;
txt = "Start Research";

leftFunc = function() {

	if (is_struct(rc.viewedProject)) {
		
		global.gameData.research.currentResearch = rc.viewedProject.key;
	
	}
	
}

constantFunc = function() {

	var vp = rc.viewedProject;

	if (!is_struct(vp)) {
		
		active = false;
	
	} else {
	
		if (vp.level < vp.maxLevel) {
			active = true;
		} else {
			active = false;	
		}
	
	}
	
}