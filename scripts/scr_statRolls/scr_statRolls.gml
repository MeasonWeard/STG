function scr_statRolls_damage(level, modVal = 1) {

	var low = max(1, round(level * 0.3));
	var high = low + 4;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_damagePerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}


function scr_statRolls_resistance(level, modVal = 1) {

	var low = max(1, round(level * 0.6));
	var high = low + 4;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_resistancePerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_regen(level, modVal = 1) {

	var low = max(1, level) * 0.1;
	var high = low + 0.2;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return amount * modVal;
	
}

function scr_statRolls_regenPerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_shieldRegen(level, modVal = 1) {

	var low = max(1, level) * 0.05;
	var high = low + 0.1;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return amount * modVal;
	
}

function scr_statRolls_shieldRegenDelay(level, modVal = 1) {

	var high = max(1, level) * -0.015;
	var low = high - 0.1;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return amount * modVal;
	
}

function scr_statRolls_combatAbility(level, modVal = 1) {

	var low = 2 + level * 2;
	var high = low + 10;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_healingPerc(level, modVal = 1) {

	var low = max(1, level * 0.5);
	var high = low + 4;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_speed(level, modVal = 1) {

	var low = max(1, level) * 0.01;
	var high = low + 0.05;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return amount * modVal;
	
}

function scr_statRolls_maxHp(level, modVal = 1) {

	var low = max(1, level * 5);
	var high = low + 10;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_maxHpPerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_maxEnergy(level, modVal = 1) {

	var low = max(1, level * 5);
	var high = low + 10;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_maxEnergyPerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_packRegen(level, modVal = 1) {

	var low = max(1, level) * 0.01;
	var high = low + 0.05;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return amount * modVal;
	
}

function scr_statRolls_dashRegen(level, modVal = 1) {

	var low = level * 0.0075;
	var high = low + 0.03;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return amount * modVal;
	
}