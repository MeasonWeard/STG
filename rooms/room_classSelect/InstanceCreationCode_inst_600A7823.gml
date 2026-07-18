txt = "Physics";

leftFunc = function() {

	global.classSelectController.selectedClass = classes.physics;
	
}

hoverFunc = function() {

	var c = global.classSelectController;
	c.hoverHeading = "Physics";
	c.hoverDescription = c.physicsTxt;
	
}