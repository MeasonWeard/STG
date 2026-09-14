rc = global.researchController;
txt = "Activate";

leftFunc = function() {

	if (is_struct(rc.viewedProject)) {
		
		var success = scr_research_activateProject(rc.viewedProject);
		if (success) rc.reset();
		
	}
	
}

constantFunc = function() {

	var vp = rc.viewedProject;
	var vn = rc.viewedNode;

	if (!is_struct(vp)) {
		
		active = false;
	
	} else {
	
		var alreadyActive = false;
		
		if (instance_exists(vn)) {
			alreadyActive = vn.active;	
		}
	
		if (vp.level > 0 and !alreadyActive) {
			active = true;
		} else {
			active = false;	
		}
	
	}
	
}