txt = "Engineering";

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