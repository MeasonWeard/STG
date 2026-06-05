event_inherited();

if (setup) {

	setup = false;
	
	hp = maxHp;
	armour = maxArmour;
	
	gunYoffset = 0;//(sprite_get_height(sprites.left) * image_yscale) * 0.66;
	
	var gunsLen = array_length(guns);
	
	for (var i = 0 ; i < gunsLen; i ++) {
	
		var thisGun = guns[i];
	
		if (is_struct(thisGun)) {
	
			thisGun.ammo = thisGun.clipSize;
	
		}
	
	}
	
	if (thornsDamage > 0) {
		thornsTurnIndex = scr_timeSlicing_assignTurnIndex("thorns");
	}
	
	activationTurnIndex = scr_timeSlicing_assignTurnIndex("activation");
	
	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.charHash, id, hashCellX, hashCellY);
	
}

prevHp = hp;