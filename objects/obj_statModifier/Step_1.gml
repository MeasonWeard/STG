if (setup) {

	setup = false;

	if (instance_exists(owner) and variable_struct_exists(owner.finalStats, statKey)) {
	
		statBefore = owner.finalStats[$ statKey];
		statAfter = statBefore + amount;
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
		
	}
	
}