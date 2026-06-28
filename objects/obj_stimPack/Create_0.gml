event_inherited();

collectRequirements = function(char) {
	
	return char.stimPacks < char.stats.maxStimPacks;

}

collectFunc = function(char, item) {

	char.stimPacks ++;
	
}