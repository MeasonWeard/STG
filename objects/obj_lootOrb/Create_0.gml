event_inherited();

key = "lootOrb";
type = "loot";
level = 0;
rarity = 0;
rarityKey = "";
raritySetup = true;
uniqueFunc = undefined;

collectFunc = function () {

	var loot = global.runController.loot;
	
	if (is_callable(uniqueFunc)) {
		array_push(global.runController.uniqueLoot, uniqueFunc);
		exit;
	}
	
	if (is_undefined(loot[$ rarityKey])) loot[$ rarityKey] = 0;

	loot[$ rarityKey] ++;
	
}