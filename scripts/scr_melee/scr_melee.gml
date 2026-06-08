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
		
		damage: {
			kin: 50,
			fire: 0,
			chem: 0,
			elec: 0,
			rad: 0
		},
		
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
	if (!is_struct(char.melee.melee)) return noone;
	if (!is_struct(char.melee.stats)) return noone;
	
	var melee = char.melee.melee;
	var stats = char.melee.stats;
	
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
	
	att.sprite_index = melee.attackSprites[melee.attackSpriteIndex];
	melee.attackSpriteIndex = melee.attackSpriteIndex + 1;
	if (melee.attackSpriteIndex > array_length(melee.attackSprites) - 1) melee.attackSpriteIndex = 0;
	
	melee.attackTick = 60 / stats.attackRate;
	melee.charges --;
	melee.recharge = stats.rechargeTime * 60;
	
	char.meleeCooldown = round(60 / stats.attackRate) + 4;
	
	att.image_angle = dir;

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

function scr_melee_equipMelee(char, melee) {

	if (!instance_exists(char)) return false;

	var newStats = scr_melee_calculateMeleeStats(char, melee);

    char.melee = {
		melee: melee,
		stats: newStats
	}

    return true;
	
}

function scr_melee_calculateMeleeStats(char, melee) {

	if (!instance_exists(char)) return undefined;
	if (!is_struct(melee)) return undefined;

	var newStats = {};
	
	scr_data_structCopyInto(newStats, melee);
	
	newStats.damage.kin = scr_stats_calculateStat(newStats.damage.kin, char.stats.kinDamPerc) + char.finalStats.kinDam;
	newStats.damage.fire = scr_stats_calculateStat(newStats.damage.fire, char.stats.fireDamPerc) + char.finalStats.fireDam;
	newStats.damage.chem = scr_stats_calculateStat(newStats.damage.chem, char.stats.chemDamPerc) + char.finalStats.chemDam;
	newStats.damage.elec = scr_stats_calculateStat(newStats.damage.elec, char.stats.elecDamPerc) + char.finalStats.elecDam;
	newStats.damage.rad = scr_stats_calculateStat(newStats.damage.rad, char.stats.radDamPerc) + char.finalStats.radDam;
	
	var range = scr_stats_calculateDamageRange(newStats.damage.kin);
	newStats.damage.kinMin = range.minDam;
	newStats.damage.kinMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.fire);
	newStats.damage.fireMin = range.minDam;
	newStats.damage.fireMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.chem);
	newStats.damage.chemMin = range.minDam;
	newStats.damage.chemMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.elec);
	newStats.damage.elecMin = range.minDam;
	newStats.damage.elecMax = range.maxDam;
	
	range = scr_stats_calculateDamageRange(newStats.damage.rad);
	newStats.damage.radMin = range.minDam;
	newStats.damage.radMax = range.maxDam;
	
	return newStats;
	
}
