//base class
function skill() constructor {
	
	name = "None";
	key = undefined;
	icon = spr_icon_blank;
	level = 1;
	
	maxLevel = 12;
	
	active = true;
	passives = undefined;
	
	cooldown = 0;
	cooldownTime = 2;

	castCooldown = 0;
	castCooldownTime = 0.5;

	charges = 1;
	maxCharges = 1;
	
	energyCost = 0;
	
	static castFunc = undefined;
	
	static setupFunc = undefined;

	static cast = function(source) {

		if (!ready()) return false;
		
		if (!is_callable(castFunc)) return false;
		
		if (source.energy < energyCost) return false;

		var success = castFunc(source);

		if (success) {

			if (maxCharges > 1) {
				charges--;

				if (charges < maxCharges) {
					cooldown = cooldownTime * 60;
				}
			}
			
			else {
				cooldown = cooldownTime * 60;
			}
			
			if (maxCharges > 1) {
			
				castCooldown = castCooldownTime * 60;
			
			}
			
			source.energy -= energyCost;

			return true;
			
		}

		return false;

	}

	static tick = function() {

		if (maxCharges > 1) {

			if (charges < maxCharges) {

				cooldown = max(0, cooldown - 1);

				if (cooldown <= 0) {

					charges++;

					if (charges < maxCharges) {
						cooldown = cooldownTime * 60;
					}
				}
			}
			
			castCooldown = max(0, castCooldown - 1);

		}
		
		else {

			cooldown = max(0, cooldown - 1);

		}

	}

	static ready = function() {

		if (maxCharges > 1) {
			if (maxCharges > 1) return charges > 0 and castCooldown <= 0;
			else return charges > 0;
		}

		return cooldown <= 0;

	}
	
}

function scr_skills_load(savedSkill) {

    var const = variable_struct_get(
        global.data.skillConstructors,
        savedSkill.key
    );
	
	if (is_undefined(const)) return undefined;
	
	if (is_instanceof(savedSkill, const)) return savedSkill;

    var loadedSkill = new const();
	
	variable_struct_remove(savedSkill, "setupFunc");
	variable_struct_remove(savedSkill, "castFunc");
	variable_struct_remove(savedSkill, "cast");
	variable_struct_remove(savedSkill, "tick");
	variable_struct_remove(savedSkill, "ready");
	
	//for now we only need the skill level
	loadedSkill.level = savedSkill.level;

    //scr_data_structCopyInto(loadedSkill, savedSkill);

    return loadedSkill;
	
}

function scr_skills_loadArray(savedSkills) {

    var len = array_length(savedSkills);
    var loadedSkills = array_create(len);

    for (var i = 0; i < len; i++) {

        loadedSkills[i] = scr_skills_load(savedSkills[i]);

    }

    return loadedSkills;

}

function scr_skills_findPlayerSkill(key, mustBeActive = false) {
	
	if (key == undefined) return undefined;
	
	var playerData = global.gameData.playerData;
	
    var pClasses = [playerData.class1, playerData.class2];

    for (var i = 0; i < array_length(pClasses); i++) {

        var classData = pClasses[i];

        if (!is_struct(classData)) continue;
        if (!is_array(classData.unlockedSkills)) continue;

        var skills = classData.unlockedSkills;

        for (var j = 0; j < array_length(skills); j++) {

            var thisSkill = skills[j];

            if (!is_struct(thisSkill)) continue;
            if (mustBeActive and !thisSkill.active) continue;
            if (thisSkill.key == key) return thisSkill;

        }

    }

    return undefined;
	
}

function scr_skills_findCharSkill(key, char, mustBeActive = false) {
	
	if (key == undefined) return undefined;
	if (!instance_exists(char)) return undefined;
	if (!is_struct(char.charData)) return undefined; 
	
	var charData = char.charData;
	
	if (!variable_struct_exists(charData, "class1") or !variable_instance_exists(charData, "class2")) return undefined;
	

    var cClasses = [charData.class1, charData.class2];

    for (var i = 0; i < array_length(cClasses); i++) {

        var classData = cClasses[i];

        if (!is_struct(classData)) continue;
        if (!is_array(classData.unlockedSkills)) continue;

        var skills = classData.unlockedSkills;

        for (var j = 0; j < array_length(skills); j++) {
			
            var thisSkill = skills[j];
			
            if (!is_struct(thisSkill)) continue;
			
			show_debug_message(thisSkill.key);

            if (mustBeActive and !thisSkill.active) continue;
            if (thisSkill.key == key) return thisSkill;

        }

    }

    return undefined;
	
}


function scr_skills_getTotalSkillPoints() {

	var points = global.gameData.playerData.level;
	return points;
	
}

function scr_skills_countSpentSkillPoints() {
	
	var playerData = global.gameData.playerData;
	var points = 0;
	
	var class1 = playerData.class1;
	var class2 = playerData.class2;
	
	if (is_struct(class1)) {
	
		var unlockedSkills = class1.unlockedSkills;
		var len = array_length(unlockedSkills);
		
		for (var i = 0; i < len; i++) {
		
			var sk = unlockedSkills[i];
			if (!is_struct(sk)) continue;
			
			var level = sk.level;
			points += max(0, level);
		
		}
	
	}
	
	if (is_struct(class2)) {
	
		var unlockedSkills = class2.unlockedSkills;
		var len = array_length(unlockedSkills);
		
		for (var i = 0; i < len; i++) {
		
			var sk = unlockedSkills[i];
			if (!is_struct(sk)) continue;
			
			var level = sk.level;
			points += max(0, level);
		
		}
	
	}
	
	return points;
	
}

//ACTIVES

function skill_test() : skill() constructor {

	name = "Test";
	key = "test";
	icon = spr_icon_rubberBoots;
	maxCharges = 2;
	charges = 1;
	energyCost = 0;
	castCooldownTime = 0.65;
	
	static castFunc = function(source) {
		
		with (obj_enemy) {
		
			hp = 0;
		
		}
		
		return true;
		
	}
	
}

function skill_chainLightning() : skill() constructor {

	name = "Chain Lightning";
	key = "chainLightning";
	icon = spr_icon_chainLightning;
	maxCharges = 2;
	charges = 2;
	cooldownTime = 6;
	energyCost = 30;
	range = 900;
	chains = 1;
	
	damage = undefined;
	
	static setupFunc = function(source) {
		
		energyCost = 30 + level * 5;
		
		chains = 1 + floor(level / 2);
		
		damage = new damageProfile();
		damage.elec = 25 + 10 * level;
		damage.elec = scr_stats_applyDamageBonuses(source, damage.elec, "elec"); 
		damage = scr_stats_calculateCharDamageProfile(source, damage, false);
		
	}
	
	static castFunc = function(source) {

		if (!instance_exists(source)) return false;

		var xx = source.aimX;
		var yy = source.aimY;
		
		var nearest = scr_char_targetNearest(source, xx, yy, 2, true);
		
		if (!instance_exists(nearest)) return false;
		if (nearest.id == source.id) return false;
		
		var dist = point_distance(source.x, source.y, nearest.x, nearest.y);
		if (dist > range) return false;
		
		var cx = nearest.x;
		var cy = nearest.y;
		
		var cl = instance_create_layer(cx, cy, "Instances", obj_chainLightning);
		cl.owner = source;
		cl.chainList = [nearest];
		cl.chains = chains;
		cl.damage = damage;
		
		return true;
		
	}
	
}

function skill_antimatterBlast() : skill() constructor {
	
	name = "Antimatter Blast";
	key = "antimatterBlast";
	icon = spr_icon_antimatter;
	maxCharges = 1;
	charges = 1;
	energyCost = 75;
	projectiles = 8;
	cooldownTime = 11;
	explosionRadius = 50;
	
	damage = undefined;
	
	static setupFunc = function(source) {
		
		energyCost = 75 + level * 5;
		
		projectiles = 6 + 2 * level;
		explosionRadius = 50 + level * 5;
		
		damage = new damageProfile();
		
		damage.kin = 10 + 2 * level;
		damage.kin = scr_stats_applyDamageBonuses(source, damage.kin, "kin");
		
		damage.rad = 10 + 2 * level;
		damage.rad = scr_stats_applyDamageBonuses(source, damage.rad, "rad");
		
		damage = scr_stats_calculateCharDamageProfile(source, damage, false);
		
	}
	
	static castFunc = function(source) {
		
		var aimX = source.aimX;
		var aimY = source.aimY;
		
		var gunX = source.gunX;
		var gunY = source.gunY;
		
		var dir = point_direction(gunX, gunY, aimX, aimY);
		
		var launcher = instance_create_layer(gunX, gunY, "Instances", obj_antimatterBlast);
		
		if (instance_exists(launcher)) {
			
			launcher.damage = damage;
			launcher.dir = dir;
			launcher.owner = source;
			launcher.projectiles = projectiles;
			launcher.explosionRadius = explosionRadius;
			
			return true;
			
		}
		
	}
	
}

function skill_fungalTurret() : skill() constructor {
	
	name = "Fungal Turret";
	key = "fungalTurret";
	icon = spr_icon_fungalTurret;
	
	maxLevel = 9;
	maxCharges = 1;
	charges = 1;
	energyCost = 20;
	cooldownTime = 4;
	castCooldownTime = 0.25;
	maxSpawns = 1;
	life = 6;
	maxHp = 100;
	gunDamMult = 1;
	shields = 0;

	static setupFunc = function(source) {
		
		energyCost = 20 + (level - 1) * 2;
		life = 6 + (level - 1) * 0.5;
		maxSpawns = 1 + level div 3;
		maxCharges = maxSpawns;
		maxHp = 100 + (level - 1) * 20;
		gunDamMult = 1 + (level - 1) * 0.2;
		
		var ga = scr_skills_findCharSkill("guardianArray", source, false);
		
		if (is_struct(ga)) {
			shields = ga.petShields;
		}
	
	}
	
	static castFunc = function(source) {
		
		var aimX = source.aimX;
		var aimY = source.aimY;
		
		var gunX = source.gunX;
		var gunY = source.gunY;
		
		var dir = point_direction(gunX, gunY, aimX, aimY);
		
		var aimDist = point_distance(gunX, gunY, aimX, aimY);
		var dist = min(200, aimDist);
		
		var xx = gunX + lengthdir_x(dist, dir);
		var yy = gunY + lengthdir_y(dist, dir);
		
		var existing = 0;
		
		var inst = scr_char_spawnPet(obj_fungalTurret, source, life, xx, yy, maxSpawns);
		inst.life = life;
		inst.level = level;
		inst.baseStats.maxHp = maxHp;
		inst.gunDamMult = gunDamMult;
		inst.baseStats.maxShield = shields;

		scr_audio_playSoundAt(snd_alienShoot2, xx, yy);

		if (instance_exists(inst)) return true;

	}
	
}

function skill_turret() : skill() constructor {
	
	name = "Turret";
	key = "turret";
	icon = spr_icon_turret;
	maxLevel = 12;
	maxCharges = 1;
	charges = 1;
	energyCost = 50;
	cooldownTime = 20;
	castCooldownTime = 0.2;
	maxSpawns = 1;
	clips = 2;
	maxHp = 150;
	gunDamMult = 1;
	shields = 0;

	static setupFunc = function(source) {
		
		energyCost = 50 + (level - 1) * 5;
		maxHp = 200 + (level - 1) * 25;
		gunDamMult = 1 + (level - 1) * 0.2;
		shields = 0;
		
		var extraClips = level div 2;
		clips = 2 + extraClips;
	
		var ga = scr_skills_findCharSkill("guardianArray", source, false);
		
		if (is_struct(ga)) {
			shields = ga.petShields;
		}
	
	}
	
	static castFunc = function(source) {
		
		var aimX = source.aimX;
		var aimY = source.aimY;
		
		var gunX = source.gunX;
		var gunY = source.gunY;
		
		var dir = point_direction(gunX, gunY, aimX, aimY);
		
		var aimDist = point_distance(gunX, gunY, aimX, aimY);
		var dist = min(200, aimDist);
		
		var xx = gunX + lengthdir_x(dist, dir);
		var yy = gunY + lengthdir_y(dist, dir);
		
		var existing = 0;
		
		var inst = scr_char_spawnPet(obj_turret, source, undefined, xx, yy, maxSpawns);
		inst.clips = clips;
		inst.level = level;
		inst.baseStats.maxHp = maxHp;
		inst.gunDamMult = gunDamMult;
		inst.baseStats.maxShield = shields;

		if (instance_exists(inst)) return true;

	}
	
}

//PASSIVES

function skill_rubberBoots() : skill() constructor {

	name = "Rubber Boots";
	key = "rubberBoots";
	active = false;
	icon = spr_icon_rubberBoots;
	
	passives = {
	
		elecRes: 10
	
	};
	
	static setupFunc = function(source) {
	
		passives = {
	
			elecRes: 5 * level
	
		};
	
	}
	
}

function skill_guardianArray() : skill() constructor {

	name = "Guardian Array";
	key = "guardianArray";
	active = false;
	icon = spr_icon_blank;
	petShields = 1;
	maxLevel = 3;
	
	static setupFunc = function(source) {
	
		petShields = level;
	
	}
	
}