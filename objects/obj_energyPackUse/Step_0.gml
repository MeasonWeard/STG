if (!instance_exists(owner)) exit;

if (heal <= 0) instance_destroy();

if (tick > 0) {

	tick--;
	
} else {

	tick = 60;
	
	var amount = min(healPerSecond, heal);
	
	scr_char_rechargeEnergy(owner, amount);
	heal -= amount;
	
}