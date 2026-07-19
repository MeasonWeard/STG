event_inherited();

//equippedWeapon = weapons[weaponIndex].weapon;
//equippedWeaponStats = weapons[weaponIndex].stats;

//gun
if (is_instanceof(equippedWeapon, gunInst)) {

	var gun = equippedWeapon;
	
    gun.fireTick--;

    if (gun.fireTick < 0) gun.fireTick = 0;

    gun.aimOff = max(equippedWeaponStats.minAimOff, gun.aimOff - equippedWeaponStats.stability);

    //reload
    if (gun.reload > 0) {
		
        gun.reload--;

        if (gun.reload == 0) {
			
            gun.ammo = equippedWeaponStats.clipSize;
			shootDelayTick = irandom_range(shootDelayMin, shootDelayMax);
			
        }
		
    }
	
}

//melee weapon
if (is_instanceof(equippedWeapon, meleeInst)) {

	var melee = equippedWeapon;

	melee.attackTick --;
	
	if (melee.attackTick < 0) melee.attackTick = 0;
	if (melee.recharge > 0) melee.recharge --;
	
	if (melee.recharge <= 0) {
		melee.recharge = 0;
		melee.charges = equippedWeaponStats.maxCharges;
	}
	
}

meleeCooldown = max(0, meleeCooldown - 1);

//skills
if (is_struct(skills.skill1)) skills.skill1.tick();
if (is_struct(skills.skill2)) skills.skill2.tick();
if (is_struct(skills.skill3)) skills.skill3.tick();
if (is_struct(skills.skill4)) skills.skill4.tick();

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
var len = array_length(meleeHitList) - 1;

for (var i = len; i >= 0; i--) {

    var entry = meleeHitList[i];

    if (!instance_exists(entry)) {
        array_delete(meleeHitList, i, 1);
        continue;
    }

}

//thorns damage
if (is_struct(thornsDamage)) {
	
	if (scr_timeSlicing_isMyTurn("thorns", thornsTurnIndex)) {
	
		var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
		var nearbyLen = array_length(nearby);
		
		for (var i = 0; i < nearbyLen; i ++) {
		
			var char = nearby[i];
			
			if (!instance_exists(char)) continue;
			if (char.id = id) continue;
			if (char.thornsImmunity > 0) continue;
			if (scr_char_isFriendly(self, char)) continue;
			
			var col = scr_obj_collision(char, self, true);
			
			if (col) {
				scr_char_damage(char, thornsDamage, undefined, true);
				char.thornsImmunity = round(60 * THORNS_IMMUNITY_TIME);
				var snd = scr_audio_randomSoundFromProfile(thornsSounds);
				if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
			}
		
		}

	}

}

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
		gib.disappear = gibDisappears;
		
	}
	
	var snd = scr_audio_randomSoundFromProfile(deathSounds);
	if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);
	
	instance_destroy();
	
}

//health and energy regen

if (hp > 0) {

	var amount;

	if (finalStats.hpRegen > 0) {
		
		hpRegenCounter += finalStats.hpRegen / 60;
	

		amount = floor(hpRegenCounter);

		hp += amount;
		hpRegenCounter -= amount;
	
	}

	if (finalStats.energyRegen > 0) {

		energyRegenCounter += finalStats.energyRegen / 60;

		amount = floor(energyRegenCounter);

		energy += amount;
		energyRegenCounter -= amount;
	
	}
	
}

//packs regen
if (stats.maxStimPacks > 0 and stats.stimPackRegen > 0 and stimPacks < stats.maxStimPacks) {

	stimPackRecharge += stats.stimPackRegen;
	
	if (stimPackRecharge >= 3600) {
		stimPackRecharge = 0;
		stimPacks++;
	}
	
}

if (stimPacks == stats.maxStimPacks) stimPackRecharge = 0;

if (stats.maxEnergyPacks > 0 and stats.energyPackRegen > 0 and energyPacks < stats.maxEnergyPacks) {

	energyPackRecharge += stats.energyPackRegen;
	
	if (energyPackRecharge >= 3600) {
		energyPackRecharge = 0;
		energyPacks++;
	}
	
}

if (energyPacks == stats.maxEnergyPacks) energyPackRecharge = 0;

//cap health and energy
if (hp > maxHp) hp = maxHp;
if (energy > maxEnergy) energy = maxEnergy;