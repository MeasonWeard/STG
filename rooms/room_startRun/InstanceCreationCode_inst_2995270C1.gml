sr = global.startRun;
rc = global.runController;

textGetter = function() {
	
	var baseLevel = sr.baseLevel;
	var intensityMod = sr.intensityMod;
	
	var level = baseLevel + intensityMod;
	
	txt = "Level: ";
	txt += string(level);
	
	return txt;
	
}