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

//set up basics
if (setup) {

	setup = false;
	
	if (!customGunOffset) gunYoffset = (sprite_get_height(sprites.down) * image_yscale) * 0.5;

	//thorns
	if (is_struct(thornsDamage)) {
		
		thornsTurnIndex = scr_timeSlicing_assignTurnIndex("thorns");
		thornsDamage = scr_stats_calculateCharDamageProfile(self, thornsDamage, false);
		
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
	
	stats = {};
	scr_data_copyInto(stats, baseStats);
	
	//apply class stats and passive skill stats
	if (instance_exists(global.player) and self.id == global.player.id) {
		
		var playerData = global.gameData.playerData;
		
		//major
		scr_class_applyMajorStats(playerData.class1, stats);
		//minor
		scr_class_applyMinorStats(playerData.class1, stats);
		scr_class_applyMinorStats(playerData.class2, stats);
		
		//apply passive skills stats
		var class1Passives = [];
		var class2Passives = [];
		
		var class1 = playerData.class1;
		var class2 = playerData.class2;
		
		//convert skill save data into skill instances
		if (is_struct(class1)) class1.unlockedSkills = scr_skills_loadArray(class1.unlockedSkills);
		if (is_struct(class2)) class2.unlockedSkills = scr_skills_loadArray(class2.unlockedSkills);
		
		//class1, setup skills and apply passives
		if (is_struct(class1)) {
			
			var unlockedSkills = playerData.class1.unlockedSkills;
			var len = array_length(unlockedSkills);
		
			for (var i = 0; i < len; i ++) {
		
				var sk = unlockedSkills[i];
				
				if (!is_struct(sk)) continue;
			
				if (is_callable(sk.setupFunc)) sk.setupFunc(self);
				
				if (!is_struct(sk.passives)) continue;
				
				var keys = variable_struct_get_names(sk.passives);
				var keysLen = array_length(keys);
				
				for (var j = 0; j < keysLen; j ++) {
				
					var key = keys[j];
					var val = sk.passives[$ key];
					
					if (!variable_struct_exists(stats, key)) continue;
		
					stats[$ key] += val;
				
				}
			}
		}
		
		//class2, setup skills and apply passives
		if (is_struct(class2)) {
			
			var unlockedSkills = playerData.class2.unlockedSkills;
			var len = array_length(unlockedSkills);
		
			for (var i = 0; i < len; i ++) {
		
				var sk = unlockedSkills[i];
				
				if (!is_struct(sk)) continue;
				
				if (is_callable(sk.setupFunc)) sk.setupFunc(self);
				
				if (!is_struct(sk.passives)) continue;
				
				var keys = variable_struct_get_names(sk.passives);
				var keysLen = array_length(keys);
				
				for (var j = 0; j < keysLen; j ++) {
				
					var key = keys[j];
					var val = sk.passives[$ key];
					
					if (!variable_struct_exists(stats, key)) continue;
		
					stats[$ key] += val;
				
				}
			}
		}
		
		//load active skills
		var activeSkills = playerData.skills;
		
		var skill1 = activeSkills.skill1;
		var skill2 = activeSkills.skill2;
		var skill3 = activeSkills.skill3;
		var skill4 = activeSkills.skill4;
		
		var skill1Key = is_struct(skill1) ? skill1.key : undefined;
		var skill2Key = is_struct(skill2) ? skill2.key : undefined;
		var skill3Key = is_struct(skill3) ? skill3.key : undefined;
		var skill4Key = is_struct(skill4) ? skill4.key : undefined;
		
		skills.skill1 = scr_skills_findActiveSkill(skill1Key, playerData);
		skills.skill2 = scr_skills_findActiveSkill(skill2Key, playerData);
		skills.skill3 = scr_skills_findActiveSkill(skill3Key, playerData);
		skills.skill4 = scr_skills_findActiveSkill(skill4Key, playerData);
		
	}
	
	//apply gear stats
	if (!is_undefined(gear.device1)) scr_gear_applyStatsToChar(self, gear.device1);
	if (!is_undefined(gear.device2)) scr_gear_applyStatsToChar(self, gear.device2);
	if (!is_undefined(gear.tie)) scr_gear_applyStatsToChar(self, gear.tie);
	if (!is_undefined(gear.headgear)) scr_gear_applyStatsToChar(self, gear.headgear);

	if (!is_undefined(equippedWeapon)) scr_weapons_applyWeaponBonusesToChar(equippedWeapon, self);

	//char stats
	finalStats = scr_stats_calculateFinalStats(stats);
	
	maxHp = finalStats.maxHp;
	maxShield = finalStats.maxShield;
	maxEnergy = finalStats.maxEnergy;

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
		
}

prevHp = hp;
prevWeapon = equippedWeapon;