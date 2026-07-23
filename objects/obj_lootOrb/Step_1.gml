event_inherited();

if (raritySetup) {

	raritySetup = false;
	
	if (rarity < -1) rarity = -1;
	if (rarity > 6) rarity = 6;

	var info = scr_loot_getRarityInfo(rarity);

	rarityKey = info.key;
	col = info.col;
		
}