if (setup) {

	setup = false;

	if (instance_exists(owner) and variable_struct_exists(owner.finalStats, statKey)) {
	
		owner.finalStats[$ statKey] += amount;
		active = true;
		
		//check if this stat is a resistance
		switch (statKey) {
			
			case "kinRes":
			case "fireRes":
			case "chemRes":
			case "elecRes":
			case "radRes":
			case "meleeRes":
			case "projRes":
			
				isResistance = true;
				resMinKey = statKey + "Min";
				resMaxKey = statKey + "Max";
				
			break;
			
		}
		
		if (isResistance) {
		
			var range = scr_stats_calculateResistanceRange(owner.finalStats[$ statKey]);
		
			owner.finalStats[$ resMinKey] = range.minRes;
			owner.finalStats[$ resMaxKey] = range.maxRes;
		
		}
		
	}
	
}