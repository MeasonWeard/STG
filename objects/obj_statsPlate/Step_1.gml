if (formatTick > 0) {
	
	formatTick --;
	
} else {

	formatTick = 12;

	if (instance_exists(owner)) {
	
		var finalStats = owner.finalStats;
		
		txtCore = scr_stats_formatCharCore(finalStats);
		txtDef = scr_stats_formatCharDefence(finalStats);
		txtOff = scr_stats_formatCharOffence(finalStats);
		
	}
	
}