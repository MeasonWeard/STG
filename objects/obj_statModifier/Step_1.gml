if (setup) {

	setup = false;

	if (instance_exists(owner) and variable_struct_exists(owner.stats, statKey)) {
	
		statBefore = owner.stats[$ statKey];
		statAfter = statBefore + amount;
		active = true;
		
	}
	
}