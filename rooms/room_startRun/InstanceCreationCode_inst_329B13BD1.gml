txt = "Start";
sr = global.startRun;

leftFunc = function() {
	
	scr_zones_startZone(global.selectedZone, sr.intensityMod);
	
	if (instance_exists(global.runController)) {
		
		var rc = global.runController;
		sr.start = true;
		
	}
	
}