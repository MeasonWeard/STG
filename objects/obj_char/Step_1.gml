event_inherited();

if (setup) {

	setup = false;
	
	if (!customGunOffset) gunYoffset = (sprite_get_height(sprites.down) * image_yscale) * 0.5;
	gunIndex = 0;
	scr_guns_equipGun(self, gunIndex);
	
	//thorns
	if (thornsDamage > 0) {
		thornsTurnIndex = scr_timeSlicing_assignTurnIndex("thorns");
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
	
	var gunsLen = array_length(guns);
	
	for (var i = 0 ; i < gunsLen; i ++) {
	
		var slot = guns[i];
		var thisGun = slot.gun;

		if (is_struct(thisGun)) {
	
			slot.stats = scr_guns_calculateGunStats(self, thisGun);
			thisGun.ammo = slot.stats.clipSize;
			
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