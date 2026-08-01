txt = "Start";
rc = global.runController;

constantFunc = function() {

	rc = global.runController;
	if (instance_exists(rc)) active = true;
	else active = false;
	
}

leftFunc = function() {
	
	rc = global.runController;
	if (instance_exists(rc)) scr_stages_goToStage(rc.currentCell);
	
}