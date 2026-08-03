txt = "Biology";

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