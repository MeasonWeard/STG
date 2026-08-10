txt = "Engineering";
cs = global.classSelectController;

leftFunc = function() {

	global.classSelectController.selectedClass = classes.engineering;
	
}

hoverFunc = function() {

	var c = global.classSelectController;
	c.hoverHeading = "Engineering";
	c.hoverDescription = c.engineeringTxt;
	c.hoverMajor = c.engMajor;
	c.hoverMinor = c.engMinor;
}

constantFunc = function() {

	if (cs.classNum == 2) {
		
		var c1 = cs.class1;
		
		if (is_struct(c1)) {
		
			if (c1.id == classes.engineering) active = false;
		
		}
		
	}
	
}