function scr_statRolls_rollDamage(level, modVal = 1) {

	var low = max(1, round(level * 0.3));
	var high = low + 4;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollDamagePerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}


function scr_statRolls_rollResistance(level, modVal = 1) {

	var low = max(1, round(level * 0.6));
	var high = low + 4;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollResistancePerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollRegen(level, modVal = 1) {

	var low = max(1, level) * 0.1;
	var high = low + 0.2;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return string_trimDecimals(amount * modVal, 3);
	
}

function scr_statRolls_rollRegenPerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollShieldRegen(level, modVal = 1) {

	var low = max(1, level) * 0.05;
	var high = low + 0.1;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return string_trimDecimals(amount * modVal, 3);
	
}

function scr_statRolls_rollShieldRegenDelay(level, modVal = 1) {

	var high = max(1, level) * -0.015;
	var low = high - 0.1;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return string_trimDecimals(amount * modVal, 3);
	
}

function scr_statRolls_rollCombatAbility(level, modVal = 1) {

	var low = 2 + level * 3;
	var high = low + 10;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollHealingPerc(level, modVal = 1) {

	var low = max(1, level * 0.5);
	var high = low + 4;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollSpeed(level, modVal = 1) {

	var low = max(1, level) * 0.01;
	var high = low + 0.05;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return string_trimDecimals(amount * modVal, 3);
	
}

function scr_statRolls_rollMaxHp(level, modVal = 1) {

	var low = max(1, level * 5);
	var high = low + 10;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollMaxHpPerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollMaxEnergy(level, modVal = 1) {

	var low = max(1, level * 5);
	var high = low + 10;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollMaxEnergyPerc(level, modVal = 1) {

	var low = max(1, level);
	var high = low + 8;
	
	var amount = irandom_range_biased(low, high, LOOT_BIAS, true);
	
	return round(amount * modVal);
	
}

function scr_statRolls_rollPackRegen(level, modVal = 1) {

	var low = max(1, level) * 0.01;
	var high = low + 0.05;
	
	var amount = random_range_biased(
		low,
		high,
		LOOT_BIAS,
		true,
		3
	);
	
	return real_trimDecimals(amount * modVal, 3);
	
}