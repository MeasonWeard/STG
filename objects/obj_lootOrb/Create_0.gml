event_inherited();

key = "lootOrb";
type = "loot";
level = 0;
rarity = 0;
rarityKey = "";
raritySetup = true;

collectFunc = function () {

	var loot = global.runController.loot;
	
	if (is_undefined(loot[$ rarityKey])) loot[$ rarityKey] = 0;

	loot[$ rarityKey] ++;
	
}