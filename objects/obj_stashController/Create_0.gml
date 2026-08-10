global.stashController = self;

if (instance_exists(global.player)) instance_destroy(global.player);
scr_char_removeAllPets();


//data
equippedGear = {

	device1: undefined,
	device2: undefined,
	tie: undefined,
	headgear: undefined,
	coat: undefined
	
}

equippedWeapons = {
	
	weapon1: undefined,
	weapon2: undefined
	
}

playerData = undefined;
inventory = {};

if (is_struct(global.gameData)) {

	equippedGear = scr_data_loadEquippedGear();
	equippedWeapons = scr_data_loadEquippedWeapons();
	
	inventory = scr_data_loadInventory();

}

//functions
