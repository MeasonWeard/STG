equippedGear = {

	device1: undefined,
	device2: undefined,
	tie: undefined,
	headgear: undefined
	
}

equippedWeapons = {
	
	weapon1: undefined,
	weapon2: undefined
	
}

playerData = undefined;

if (instance_exists(global.gameData)) {

	playerData = scr_data_safeStructGet(global.gameData, "playerData", scr_file_createBlankSave());
	
	equippedGear = playerData.gear;
	equippedWeapons = playerData.weapons;
	
}