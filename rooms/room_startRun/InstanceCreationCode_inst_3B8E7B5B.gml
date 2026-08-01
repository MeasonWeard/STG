txt = ">";
sr = global.startRun;

leftFunc = function() {

	sr.intensityIndex ++;
	if (sr.intensityIndex >= sr.modValsLen) sr.intensityIndex = sr.modValsLen - 1;
	
	sr.intensityMod = sr.modVals[sr.intensityIndex];

}