txt = "Chemistry";

leftFunc = function() {

	global.classSelectController.selectedClass = classes.chemistry;
	
}

hoverFunc = function() {

	var c = global.classSelectController;
	c.hoverHeading = "Chemistry";
	c.hoverDescription = c.chemistryTxt;
	
}