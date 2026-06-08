event_inherited();

if (setup) {

	setup = false;
	
	finalStats = scr_char_calculateFinalStats(stats);
	
	maxHap = finalStats.maxHp;
	hp = maxHp;
	maxShield = finalStats.maxShield;
	shield = maxShield;
	
	if (!customGunOffset) gunYoffset = (sprite_get_height(sprites.down) * image_yscale) * 0.5;
	
	var gunsLen = array_length(guns);
	
	for (var i = 0 ; i < gunsLen; i ++) {
	
		var slot = guns[i];
		var thisGun = slot.gun;
		var gunStats = slot.stats;
	
		if (is_struct(thisGun)) {
	
			thisGun.ammo = gunStats.clipSize;
	
		}
	
	}
	
	gunIndex = 0;
	scr_guns_equipGun(self, gunIndex);
	
	if (thornsDamage > 0) {
		thornsTurnIndex = scr_timeSlicing_assignTurnIndex("thorns");
	}
	
	//activationTurnIndex = scr_timeSlicing_assignTurnIndex("activation");
	
	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.charHash, id, hashCellX, hashCellY);
	
}

prevHp = hp;