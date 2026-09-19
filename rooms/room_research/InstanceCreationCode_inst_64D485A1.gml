rc = global.researchController;
txt = "Cancel";
leftKey = vk_enter;

visibleWhenInactive = false;

leftFunc = function() {
	
	var rc = global.researchController;
	var cp = rc.currentProject;
	
	if (is_struct(cp)) {
		
		rc.currentProject = undefined;
		global.gameData.research.currentResearch = undefined;
		rc.reset();
	
	}
	
}

constantFunc = function() {

	var cp = global.researchController.currentProject;

	if (is_struct(cp)) {
		
		active = true;
	
	} else {
	
		active = false;
	
	}
	
}