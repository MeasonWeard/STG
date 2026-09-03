event_inherited();

//equip main weapon
if (equippedWeapon != prevWeapon) {
	setupStats = true;	
}

//set up
if (setup) {

	setup = false;
	
	if (!customGunOffset) {
		gunYoffset = -((sprite_get_height(sprites.down) * image_yscale) * 0.6);
		gunXoffset = 0;
	}

	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.charHash, id, hashCellX, hashCellY);
	
	nearbyEnv =	scr_hash_getNearbyCell(
		global.stageController.envHash,
		hashCellX,
		hashCellY
	);
	
	scr_hash_updateHashKeys(charHashKeys, hashCellX, hashCellY);
	
	avoidDist = ((sprite_width + sprite_height) * 0.5) * 1.2;
	
}

//set up stats and skills
if (setupStats) {
	
	setupStats = false;
	
	stats = {};
	finalStats = {};
	scr_data_copyInto(stats, baseStats);
	scr_data_copyInto(finalStats, baseStats);
	
	bulletFuncs = [];
	constantFuncs = [];
	
	//apply gear stats
	if (!is_undefined(gear.device1)) scr_gear_applyStatsToChar(self, gear.device1);
	if (!is_undefined(gear.device2)) scr_gear_applyStatsToChar(self, gear.device2);
	if (!is_undefined(gear.tie)) scr_gear_applyStatsToChar(self, gear.tie);
	if (!is_undefined(gear.headgear)) scr_gear_applyStatsToChar(self, gear.headgear);
	if (!is_undefined(gear.coat)) scr_gear_applyStatsToChar(self, gear.coat);

	if (!is_undefined(equippedWeapon)) scr_weapons_applyWeaponBonusesToChar(equippedWeapon, self);
	
	//apply class stats and passive skill stats
	if (is_struct(charData)) {
		
		//major
		scr_class_applyMajorStats(charData.class1, stats);
		//minor
		scr_class_applyMinorStats(charData.class1, stats);
		scr_class_applyMinorStats(charData.class2, stats);
		
		//set up skills, apply passives and effects
		scr_char_setupSkills(self, true, true);
			
		//load active skills
		var activeSkills = charData.skills;
		
		var skill1 = activeSkills.skill1;
		var skill2 = activeSkills.skill2;
		var skill3 = activeSkills.skill3;
		var skill4 = activeSkills.skill4;
		
		var skill1Key = is_struct(skill1) ? skill1.key : undefined;
		var skill2Key = is_struct(skill2) ? skill2.key : undefined;
		var skill3Key = is_struct(skill3) ? skill3.key : undefined;
		var skill4Key = is_struct(skill4) ? skill4.key : undefined;
		
		skills.skill1 = scr_skills_findCharSkill(skill1Key, self, true);
		skills.skill2 = scr_skills_findCharSkill(skill2Key, self, true);
		skills.skill3 = scr_skills_findCharSkill(skill3Key, self, true);
		skills.skill4 = scr_skills_findCharSkill(skill4Key, self, true);
		
	}
	
	if (pet and instance_exists(owner)) {
	
		if (getOwnerDamBonuses) scr_stats_copyDamageBonuses(owner.stats, stats);
		if (getOwnerDamMults) scr_stats_copyDamageMultipliers(owner.stats, stats);
		if (getOwnerResBonuses) scr_stats_copyResistanceBonuses(owner.stats, stats);
		if (getOwnerResMults) scr_stats_copyResistanceMultipliers(owner.stats, stats);
		if(getOwnerOA) stats.oa = owner.stats.oa;
		if(getOwnerDA) stats.da = owner.stats.da;
		if(getOwnerBulletFuncs) bulletFuncs = owner.bulletFuncs;
		if(getOwnerConstantFuncs) constantFuncs = owner.constantFuncs;

	}
	
	//char stats
	finalStats = scr_stats_calculateFinalStats(stats);
	
	maxHp = finalStats.maxHp;
	maxShield = finalStats.maxShield;
	maxEnergy = finalStats.maxEnergy;
	shieldRegenDelay = max(0.1, stats.shieldRegenDelay);
	
	//re-run setup funcs for all skills now that final stats have been calculated
	scr_char_setupSkills(self, false, false);
	
	if (setupBasics) {
	
		setupBasics = false;
	
		hp = maxHp;
		shield = maxShield;
		energy = maxEnergy;
	
		dashes = finalStats.maxDashes;
		stimPacks = stats.maxStimPacks;
		energyPacks = stats.maxEnergyPacks;
	
	}
	
	//calculate weapon stats
	scr_char_calculateWeaponStats(self, setAmmo);

	//equip
	scr_weapons_equipWeapon(self, weaponIndex);
	setAmmo = false;
	
}

if (firstEquip) {
	
	firstEquip = false;
	
	weaponIndex = 0;
	
	if (instance_exists(global.player) and id = global.player.id) {
		weaponIndex = clamp(global.lastWeaponIndex, 0, array_length(weapons) - 1);
	}
	
	scr_weapons_equipWeapon(self, weaponIndex);
	prevWeapon = equippedWeapon;
	
}

prevWeapon = equippedWeapon;