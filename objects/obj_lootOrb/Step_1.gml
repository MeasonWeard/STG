event_inherited();

if (raritySetup) {

	raritySetup = false;

	rarity = "crap";
	col = global.data.rarities.crap.col;
	
	if (level >= global.data.rarities.common.level) {
		
		rarity = "common";
		col = global.data.rarities.common.col;
		
	}
	
	if (level >= global.data.rarities.good.level) {
		rarity = "good";
		col = global.data.rarities.good.col;
	}
	
}