txt = "<";
sr = global.startRun;

leftFunc = function() {

	sr.intensityIndex --;
	if (sr.intensityIndex < 0) sr.intensityIndex = 0;
	
	sr.intensityMod = sr.modVals[sr.intensityIndex];
	
}