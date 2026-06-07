event_inherited();

//gun
if (is_struct(gun)) {

    var slot = guns[gunIndex];
    var gunStats = slot.stats;

    gun.fireTick--;

    if (gun.fireTick < 0) gun.fireTick = 0;

    gun.aimOff = max(gunStats.minAimOff, gun.aimOff - gunStats.stability);

    //reload
    if (gun.reload > 0) {
		
        gun.reload--;

        if (gun.reload == 0) {
            gun.ammo = gunStats.clipSize;
        }
		
    }

	//gun.fireTick --; //max(0, gun.fireTick - 1);
	
	//if (gun.fireTick < 0) gun.fireTick = 0;
	
	//gun.aimOff = max(gun.minAimOff, gun.aimOff - gun.stability);
	
	////reload
	//if (gun.reload > 0) {
	//	gun.reload --;
	//	if (gun.reload == 0) gun.ammo = gun.clipSize;
	//}
	
}

//melee weapon
if (is_struct(melee)) {

	melee.attackTick --;
	
	if (melee.attackTick < 0) melee.attackTick = 0;
	if (melee.recharge > 0) melee.recharge --;
	
	if (melee.recharge <= 0) {
		melee.recharge = 0;
		melee.charges = melee.maxCharges;
	}
	
}

meleeCooldown = max(0, meleeCooldown - 1);

//hash cell
if (movedThisStep) {

	var cell = scr_hash_getCellAt(x, y);

	var newCellX = cell.xx;
	var newCellY = cell.yy;

	if (newCellX != hashCellX or newCellY != hashCellY) {
	
		scr_hash_remove(global.stageController.charHash, id, hashCellX, hashCellY);
	
		hashCellX = newCellX;
		hashCellY = newCellY;
	
		scr_hash_add(global.stageController.charHash, id, hashCellX, hashCellY);
	
	}
	
}

//depopulate melee hit immunity
var len = array_length(meleeHitList) - 1

for (var i = len; i >= 0; i--) {

    var entry = meleeHitList[i];

    if (!instance_exists(entry)) {
        array_delete(meleeHitList, i, 1);
        continue;
    }

}

//thorns damage
if (thornsDamage > 0) {
	
	if (scr_timeSlicing_isMyTurn("thorns", thornsTurnIndex)) {
	
		var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
		var nearbyLen = array_length(nearby);
		
		for (var i = 0; i < nearbyLen; i ++) {
		
			var char = nearby[i];
			
			if (char.id = id) continue;
			if (char.thornsImmunity > 0) continue;
			if (scr_char_isFriendly(self, char)) continue;
			
			var col = scr_obj_collision(char, self, true);
			
			if (col) {
				scr_char_damage(char, thornsDamage, undefined, true);
				//char.hp -= thornsDamage;
				char.thornsImmunity = round(60 * THORNS_IMMUNITY_TIME);
				var snd = scr_audio_randomSoundFromProfile(thornsSounds);
				if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
			}
		
		}

	}

}

//liquids
//var liquid = scr_tiles_getLiquidAt(x, y - 8);

//if (is_struct(liquid)) {

//	if (liquidDamageImmunity > 0) {
	
//		liquidDamageImmunity --;
	
//	} else {
	
//		if (variable_struct_exists(liquid, "damage")) {
	
//			var damage = liquid.damage;
//			scr_char_damage(self, damage, undefined, true);
//			//hp -= damage;
//			liquidDamageImmunity = 30;
			
//			var profile = [];
//			if (variable_struct_exists(liquid, "damageSounds")) profile = liquid.damageSounds;
			
//			var snd = scr_audio_randomSoundFromProfile(profile);
//			if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
	
//		}
//	}

//}

if (thornsImmunity > 0) thornsImmunity --;

//damage and death
if (hp < prevHp) {

	damageFlash = 2;
	
} else {

	damageFlash = max(0, damageFlash - 1);
	
}

if (hp <= 0) {

	if(is_callable(deathFunc)) {
		
		deathFunc(self);
		
	} else {
		
		var gib = instance_create_layer(x, y-10, "Instances", obj_gib);
		gib.sprite_index = sprites.death;
		
	}
	
	var snd = scr_audio_randomSoundFromProfile(deathSounds);
	if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
	
	instance_destroy();
	
}

if (hp > maxHp) hp = maxHp;