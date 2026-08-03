function meleeInst(level, rarity) : weaponInst(level, rarity) constructor {
	
	type = itemTypes.melee;
	
	//appearance
	name = "Cleaver";
	swingSounds = global.data.soundProfiles.cleaverSwing;
	hitSounds = global.data.soundProfiles.cleaverHit;
	attackSprites = [spr_slashUp, spr_slashDown];
	spr = spr_cleaver;
	description = undefined;
		
	//combat
	attackRate = 2.8;
	maxCharges = 6;
	rechargeTime = 1.75;
	hitDelay = 0;
	stopOnHit = false;
	range = 0;
	size = 1;
		
	damage.kin = 35;
	baseDamage = 35;
		
	killThreshold = 10;
	damageInRadius = false;
	damageInLine = false;

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
	
	if (melee.attackTick > 0) return noone;
	if (melee.charges < 1) return noone;
	
	var meleeX = char.gunX;
	var meleeY = char.gunY;
	var aimX = char.aimX;
	var aimY = char.aimY;
	var offset = char.meleeRangeOffset + melee.range;
	var lifeSteal = char.stats.meleeLifeSteal;

	var dir = point_direction(meleeX, meleeY, aimX, aimY);
	
	var attackX = meleeX + lengthdir_x(offset, dir);
	var attackY = meleeY + lengthdir_y(offset, dir);
	
	var att = instance_create_layer(attackX, attackY, "Instances", obj_meleeAttack);
	
	var snd = scr_audio_randomSoundFromProfile(melee.swingSounds);
	if (snd != undefined) if (snd != undefined) audio_play_sound_at(snd, x, y, 0, MIN_FALLOFF, MAX_FALLOFF, FALLOFF_FACTOR, false, 0);

	att.owner = char;
	att.damage = stats.damage;
	att.killThreshold = stats.killThreshold;
	att.hitSounds = melee.hitSounds;
	att.oa = char.stats.oa;
	att.damageDestructibles = char.damageDestructibles;
	att.hitDelay = melee.hitDelay;
	att.stopOnHit = melee.stopOnHit;
	att.range = melee.range;
	att.damageInRadius = melee.damageInRadius;
	att.damageInLine = melee.damageInLine;
	att.lifeSteal = lifeSteal;
	att.size = melee.size;
	
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
	
	var bonusStats  = melee.bonusStats;
	var keys = variable_struct_get_names(bonusStats);
	var keysLen = array_length(keys);
	
	for (var i = 0; i < keysLen; i ++) {
		
		var key = keys[i];
		var amount = bonusStats[$ key];
		
		scr_stats_alterStat(newStats, key, amount);
		
	}
	
	if (char.stats.meleeDamPerc > 0) {
		var dec = 1 + char.stats.meleeDamPerc * 0.01;
		newStats.damage = scr_stats_multiplyDamageProfile(newStats.damage, dec);
	}

	return newStats;
	
}

function scr_melee_formatDescription(melee) {

	if (!is_instanceof(melee, meleeInst)) return undefined;

	var stats = melee.bonusStats;
	var damage = melee.damage;
	
	var txt = melee.name + "     " + "lvl " + string(melee.lvl);
	var damageTxt = scr_stats_formatDamage(damage);
	
	var attackRate = string_trimDecimals(melee.attackRate, 2);
	var charges = melee.maxCharges;
	var rechargeTime = string_trimDecimals(melee.rechargeTime, 2);
	var killThreshold = melee.killThreshold;
	var size = melee.size;

	txt += "\n\nAttack Rate: " + string(attackRate) + " p/s";
	txt += "\nCharges: " + string(charges);
	txt += "\nRecharge Time: " + string(rechargeTime) + " seconds";
	txt += "\nKill Threshold: " + string(killThreshold);
	
	if (size != 1) {
		txt += "\nAttack Area: " + " x" + string(size);	
	}

	txt += "\n\nDamage\n----------------\n";
	
	txt += damageTxt;
	
	var keys = variable_struct_get_names(stats);
	
	keys = scr_stats_orderStatKeys(keys);
	
	var keysLen = array_length(keys);
	
	if (keysLen > 0) txt += "\n\nBonus\n----------------";
	
	for (var i = 0; i < keysLen; i ++) {
	
		var stat = keys[i];
		var val = stats[$ stat];
	
		if (val == 0) continue;
	
		var newText = scr_stats_getName(stat);
		newText += ": " + string(val);
		
		txt += "\n";

		txt += newText;
	
	}
	
	return txt;
	
}