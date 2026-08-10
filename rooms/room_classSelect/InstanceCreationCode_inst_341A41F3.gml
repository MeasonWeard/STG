txt = "Biology";
cs = global.classSelectController;

leftFunc = function() {

	global.classSelectController.selectedClass = classes.biology;
	
}

hoverFunc = function() {

	var c = global.classSelectController;
	c.hoverHeading = "Biology";
	c.hoverDescription = c.biologyTxt;
	c.hoverMajor = c.bioMajor;
	c.hoverMinor = c.bioMinor;
}

constantFunc = function() {

	if (cs.classNum == 2) {
		
		var c1 = cs.class1;
		
		if (is_struct(c1)) {
		
			if (c1.id == classes.biology) active = false;
		
		}
		
	}
	
}