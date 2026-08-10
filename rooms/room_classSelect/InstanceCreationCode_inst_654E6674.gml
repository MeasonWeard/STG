txt = "Chemistry";
cs = global.classSelectController;

leftFunc = function() {

	global.classSelectController.selectedClass = classes.chemistry;
	
}

hoverFunc = function() {

	var c = global.classSelectController;
	c.hoverHeading = "Chemistry";
	c.hoverDescription = c.chemistryTxt;
	c.hoverMajor = c.chemMajor;
	c.hoverMinor = c.chemMinor;
}

constantFunc = function() {

	if (cs.classNum == 2) {
		
		var c1 = cs.class1;
		
		if (is_struct(c1)) {
		
			if (c1.id == classes.chemistry) active = false;
		
		}
		
	}
	
}