if (start) {

	rc = global.runController;
	if (instance_exists(rc)) scr_stages_goToStage(rc.currentCell);
	
}