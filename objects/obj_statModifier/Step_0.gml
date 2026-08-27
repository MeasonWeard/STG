if (active and instance_exists(owner)) {
	
	owner.finalStats[$ statKey] = statAfter;
	
	if (isResistance) {
		
		var range = scr_stats_calculateResistanceRange(statAfter);
		
		owner.finalStats[$ resMinKey] = range.minRes;
		owner.finalStats[$ resMaxKey] = range.maxRes;
		
	}
	
}

if (is_real(timer)) {

	if (timer <= 0) instance_destroy();
	
	timer --;
	
}