txt = "Play Tutorial";

leftFunc = function() {
	
	var rc = global.runController;
	
	if (instance_exists(rc)) {
		scr_stages_goToStage(rc.currentCell);
	}
	
	//room_goto(room_startRun);
	
}