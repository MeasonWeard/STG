txt = "<";
sr = global.startRun;

leftFunc = function() {

	var prevInt = sr.intensityMod;
	
	sr.intensityIndex --;
	if (sr.intensityIndex < 0) sr.intensityIndex = 0;
	
	sr.intensityMod = sr.modVals[sr.intensityIndex];
	
	if (sr.intensityMod != prevInt) scr_zones_startZone(global.selectedZone, sr.intensityMod);
	
}