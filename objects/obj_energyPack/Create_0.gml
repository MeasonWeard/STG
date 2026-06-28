event_inherited();

collectRequirements = function(char) {
	
	return char.energyPacks < char.stats.maxEnergyPacks;

}

collectFunc = function(char, item) {

	char.energyPacks ++;
	
}