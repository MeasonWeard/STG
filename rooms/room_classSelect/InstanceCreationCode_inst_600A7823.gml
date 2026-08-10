txt = "Physics";
cs = global.classSelectController;

leftFunc = function() {

	global.classSelectController.selectedClass = classes.physics;
	
}

hoverFunc = function() {

	var c = global.classSelectController;
	c.hoverHeading = "Physics";
	c.hoverDescription = c.physicsTxt;
	c.hoverMajor = c.physMajor;
	c.hoverMinor = c.physMinor;
}

constantFunc = function() {

	if (cs.classNum == 2) {
		
		var c1 = cs.class1;
		
		if (is_struct(c1)) {
		
			if (c1.id == classes.physics) active = false;
		
		}
		
	}
	
}