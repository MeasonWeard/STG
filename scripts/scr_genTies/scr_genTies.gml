function scr_genTies_generic(level, rarity) {

	var device = new deviceInst(level, rarity);
	var stats = device.stats;

	var type1 = choose("precise", "bright");
	var type2 = choose("hot", "ionizing", "malfunctioning", "", "", "")
	
	//type1
	var low = 2 + level * 2;
	var high = 4 + level * 3;

	stats.oa = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	low = 2 + level;
	high = 4 + level * 2;
	
	var statChange = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type1 == "precise") scr_loot_addStat(device, "oa", statChange);
	if (type2 == "bright") stats.da = statChange;
	
	//type2
	low = round(level + level * 1.5);
	high = round(level + 1 + level * 2.5);
		
	var dam = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	if (type2 == "hot") stats.fireDam = dam;
	if (type2 == "ionizing") stats.radDam = dam;
	if (type2 == "malfunctioning") stats.elecDam = dam;
	
	var name = "";
	
	name = append_string(name, type1, 2);
	name = append_string(name, type2, 2);
	name = append_string(name, "laser pointer", 2);
	
	device.name = name;
	
	return device;
	
}