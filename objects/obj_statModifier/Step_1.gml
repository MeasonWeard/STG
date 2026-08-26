if (setup) {

	setup = false;

	if (instance_exists(owner) and variable_struct_exists(owner.finalStats, statKey)) {
	
		statBefore = owner.finalStats[$ statKey];
		statAfter = statBefore + amount;
		active = true;
		
	}
	
}