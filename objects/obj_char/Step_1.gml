event_inherited();

if (setup) {

	setup = false;
	
	if (!customGunOffset) gunYoffset = (sprite_get_height(sprites.down) * image_yscale) * 0.5;

	//thorns
	if (is_struct(thornsDamage)) {
		
		thornsTurnIndex = scr_timeSlicing_assignTurnIndex("thorns");
		thornsDamage = scr_stats_calculateDamageProfile(self, thornsDamage);
		
	}
	
	//activationTurnIndex = scr_timeSlicing_assignTurnIndex("activation");
	
	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.charHash, id, hashCellX, hashCellY);
	
	avoidDist = ((sprite_width + sprite_height) * 0.5) * 1.2;
	
}

if (setupStats) {

	setupStats = false;

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

//duhh
if (firstEquip) {
	firstEquip = false;
	weaponIndex = 0;
	scr_weapons_equipWeapon(self, weaponIndex);
}

prevHp = hp;