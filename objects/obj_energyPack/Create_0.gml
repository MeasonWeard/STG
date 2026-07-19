event_inherited();

collectRequirements = function(char) {
	
	return char.energy < char.maxEnergy;

}

collectFunc = function(char, item) {

	var amount = ceil(char.maxEnergy * 0.1);
	scr_char_rechargeEnergy(char, amount);
	
}