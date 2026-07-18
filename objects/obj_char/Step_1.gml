event_inherited();

//equip main weapon
if (firstEquip) {
	firstEquip = false;
	weaponIndex = 0;
	scr_weapons_equipWeapon(self, weaponIndex);
	prevWeapon = equippedWeapon;
}

if (equippedWeapon != prevWeapon) {
	setupStats = true;	
}

prevWeapon = equippedWeapon;

//set up basics
if (setup) {

	setup = false;
	
	if (!customGunOffset) gunYoffset = (sprite_get_height(sprites.down) * image_yscale) * 0.5;

	//thorns
	if (is_struct(thornsDamage)) {
		
		thornsTurnIndex = scr_timeSlicing_assignTurnIndex("thorns");
		thornsDamage = scr_stats_calculateDamageProfile(self, thornsDamage, false);
		
	}
	
	//activationTurnIndex = scr_timeSlicing_assignTurnIndex("activation");
	
	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.charHash, id, hashCellX, hashCellY);
	
	avoidDist = ((sprite_width + sprite_height) * 0.5) * 1.2;
	
}

//set up stats and skills
if (setupStats) {

	setupStats = false;
	
	scr_data_copyInto(stats, baseStats);

	//apply gear stats
	if (!is_undefined(gear.device1)) scr_gear_applyStatsToChar(self, gear.device1);
	if (!is_undefined(gear.device2)) scr_gear_applyStatsToChar(self, gear.device2);
	if (!is_undefined(gear.tie)) scr_gear_applyStatsToChar(self, gear.tie);
	if (!is_undefined(gear.headgear)) scr_gear_applyStatsToChar(self, gear.headgear);

	if (!is_undefined(equippedWeapon)) scr_weapons_applyWeaponBonusesToChar(equippedWeapon, self);

	//char stats
	finalStats = scr_stats_calculateFinalStats(stats);
	
	maxHp = finalStats.maxHp;
	hp = maxHp;
	maxShield = finalStats.maxShield;
	shield = maxShield;
	maxEnergy = finalStats.maxEnergy;
	energy = maxEnergy;
	dashes = finalStats.maxDashes;
	stimPacks = stats.maxStimPacks;
	energyPacks = stats.maxEnergyPacks;
	
	var weaponsLen = array_length(weapons);
	
	for (var i = 0 ; i < weaponsLen; i ++) {
	
		var slot = weapons[i];
		var thisWeapon = slot.weapon;

		if (is_instanceof(thisWeapon, gunInst)) {
	
			slot.stats = scr_guns_calculateGunStats(self, thisWeapon);
			thisWeapon.ammo = slot.stats.clipSize;
			
		}
		
		if (is_instanceof(thisWeapon, meleeInst)) {
		
			slot.stats = scr_melee_calculateMeleeStats(self, thisWeapon);
		
		}
		
	}
	
	//skills
	if (is_struct(skills.skill1)) {
		
		if (is_callable(skills.skill1.setupFunc)) skills.skill1.setupFunc(self);
	
	}
	
	if (is_struct(skills.skill2)) {
		
		if (is_callable(skills.skill2.setupFunc)) skills.skill2.setupFunc(self);
	
	}
	
	if (is_struct(skills.skill3)) {
		
		if (is_callable(skills.skill3.setupFunc)) skills.skill3.setupFunc(self);
	
	}
	
	if (is_struct(skills.skill4)) {
		
		if (is_callable(skills.skill4.setupFunc)) skills.skill4.setupFunc(self);
	
	}
		
}

prevHp = hp;