font = fnt_large;
hAlign = fa_middle;

textGetter = function() {

	var int =  global.startRun.intensityIndex;
	
	if (int == 0) return "Off";
	
	return int;
	
}