event_inherited();

collectRequirements = function(char) {
	
	return char.hp < char.maxHp;

}

collectFunc = function(char, item) {
	scr_testSound();
	var amount = ceil(char.maxHp * 0.1);
	scr_char_heal(char, amount);
	
}