if (instance_exists(owner) and variable_struct_exists(owner.finalStats, statKey)) {
	
	if (variable_instance_exists(owner, modName)) {
		variable_instance_set(owner, modName, noone);
	}
	
	owner.finalStats[$ statKey] = statBefore;

}