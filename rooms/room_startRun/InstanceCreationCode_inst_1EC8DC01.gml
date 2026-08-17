font = fnt_large;

hAlign = fa_middle;

sr = global.startRun;
rc = global.runController;

textGetter = function() {
	
	var baseLevel = sr.baseLevel;
	var intensityMod = sr.intensityMod;
	
	var level = baseLevel + intensityMod;
	
	//txt = "Recommended minimum level: ";
	txt = string(level);
	
	return txt;
	
}