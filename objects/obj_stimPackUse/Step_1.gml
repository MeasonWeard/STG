if (!instance_exists(owner)) exit;

if (firstStep) {

	firstStep = false;

	var half = floor(heal * 0.5);
	scr_char_heal(owner, half);
	heal -= half;
	
	healPerSecond = max(1, floor(heal / 5));

}