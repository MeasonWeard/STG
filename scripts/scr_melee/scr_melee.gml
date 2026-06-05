function scr_melee_createWeapon(name) {

	var melee = {

		//appearance and sound
		name: name,
		swingSounds: global.data.soundProfiles.cleaverSwing,
		hitSounds: global.data.soundProfiles.cleaverHit,
		attackSprites: [spr_slashUp, spr_slashDown],
		
		//combat
		attackRate: 3.6,
		maxCharges: 4,
		rechargeTime: 1.75,
		damage: 40,
		killThreshold: 10,

		//runtime data
		charges: 4,
		recharge: 0,
		attackTick: 0,
		attackSpriteIndex: 0
	
	}
	
	return melee;
	
}

function scr_melee_attack(char) {

	if (!instance_exists(char)) return noone;
	if (!is_struct(char.melee)) return noone;
	
	var melee = char.melee;
	
	var gunX = char.gunX;
	var gunY = char.gunY;
	var aimX = char.aimX;
	var aimY = char.aimY;
	
	var dir = point_direction(gunX, gunY, aimX, aimY);
	
	if (melee.attackTick > 0) return noone;
	if (melee.charges < 1) return noone;

	var att = instance_create_layer(char.gunX, char.gunY, "Instances", obj_meleeAttack);
	
	var snd = scr_audio_randomSoundFromProfile(melee.swingSounds);
	if (snd != undefined) if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);

	att.owner = char;
	att.damage = melee.damage;
	att.killThreshold = melee.killThreshold;
	att.hitSounds = melee.hitSounds;
	
	att.sprite_index = melee.attackSprites[melee.attackSpriteIndex];
	melee.attackSpriteIndex = melee.attackSpriteIndex + 1;
	if (melee.attackSpriteIndex > array_length(melee.attackSprites) - 1) melee.attackSpriteIndex = 0;
	
	melee.attackTick = 60 / melee.attackRate;
	melee.charges --;
	melee.recharge = melee.rechargeTime * 60;
	
	char.meleeCooldown = round(60 / melee.attackRate) + 4;
	
	att.image_angle = dir;
	
	//if (char.dir == -1) att.image_xscale = -1;

}

function scr_melee_alreadyHit(enemy, attack) {
	
    var list = enemy.meleeHitList;
	var len = array_length(list);

    for (var i = 0; i < len; i++) {
        if (list[i] == attack) {
            return true;
        }
    }

    return false;
	
}