function meleeInst() : weaponInst() constructor {
	
	//appearance
	name = "Cleaver";
	swingSounds = global.data.soundProfiles.cleaverSwing;
	hitSounds = global.data.soundProfiles.cleaverHit;
	attackSprites = [spr_slashUp, spr_slashDown];
	spr = spr_melee;
		
	//combat
	attackRate = 2.8;
	maxCharges = 6;
	rechargeTime = 1.75;
		
	damage.kin = 35;
		
	killThreshold = 10;

	//runtime data
	charges = 4;
	recharge = 0;
	attackTick = 0;
	attackSpriteIndex = 0;
		
}

function scr_melee_attack(char) {

	if (!instance_exists(char)) return noone;
	if (!is_instanceof(char.equippedWeapon, meleeInst)) return noone;
	if (!is_struct(char.equippedWeaponStats)) return noone;
	
	var melee = char.equippedWeapon;
	var stats = char.equippedWeaponStats;
	
	var meleeX = char.gunX;
	var meleeY = char.gunY;
	var aimX = char.aimX;
	var aimY = char.aimY;
	
	var dir = point_direction(meleeX, meleeY, aimX, aimY);
	
	if (melee.attackTick > 0) return noone;
	if (melee.charges < 1) return noone;

	var att = instance_create_layer(char.gunX, char.gunY, "Instances", obj_meleeAttack);
	
	var snd = scr_audio_randomSoundFromProfile(melee.swingSounds);
	if (snd != undefined) if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);

	att.owner = char;
	att.damage = stats.damage;
	att.killThreshold = stats.killThreshold;
	att.hitSounds = melee.hitSounds;
	att.oa = char.stats.oa;
	
	att.sprite_index = melee.attackSprites[melee.attackSpriteIndex];
	melee.attackSpriteIndex = melee.attackSpriteIndex + 1;
	if (melee.attackSpriteIndex > array_length(melee.attackSprites) - 1) melee.attackSpriteIndex = 0;
	
	melee.attackTick = 60 / stats.attackRate;
	melee.charges --;
	melee.recharge = stats.rechargeTime * 60;
	
	char.meleeCooldown = round(60 / stats.attackRate) + 4;
	
	att.image_angle = dir;
	
	return att;

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

//function scr_melee_equipMelee(char, melee) {

//	if (!instance_exists(char)) return false;

//	var newStats = scr_melee_calculateMeleeStats(char, melee);

//    char.melee = {
//		melee: melee,
//		stats: newStats
//	}

//    return true;
	
//}

function scr_melee_calculateMeleeStats(char, melee) {

	if (!instance_exists(char)) return undefined;
	if (!is_struct(melee)) return undefined;

	var newStats = scr_stats_calculateDamageProfileWeapon(char, melee);

	return newStats;
	
}
