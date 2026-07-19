//base class
function skill() constructor {
	
	name = "None";
	icon = spr_icon_blank;
	level = 1;
	
	key = undefined;
	
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

    scr_data_structCopyInto(loadedSkill, savedSkill);

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

function scr_skills_findActiveSkill(key, playerData) {
	
	if (key == undefined) return undefined;
	
    var pClasses = [playerData.class1, playerData.class2];

    for (var i = 0; i < array_length(pClasses); i++) {

        var classData = pClasses[i];

        if (!is_struct(classData)) continue;
        if (!is_array(classData.unlockedSkills)) continue;

        var skills = classData.unlockedSkills;

        for (var j = 0; j < array_length(skills); j++) {

            var skill = skills[j];

            if (!is_struct(skill)) continue;
            if (!skill.active) continue;
            if (skill.key == key) return skill;

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
	
	static setupFunc = function(char) {
		
		energyCost = 30 + level * 5;
		
		chains = 1 + floor(level / 2);
		
		damage = new damageProfile();
		damage.elec = 25 + 10 * level;
		damage.elec = scr_stats_applyDamageBonuses(char, damage.elec, "elec"); 
		damage = scr_stats_calculateDamageProfile(char, damage, false);
		
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
	
	static setupFunc = function(char) {
		
		energyCost = 75 + level * 5;
		
		projectiles = 6 + 2 * level;
		explosionRadius = 50 + level * 5;
		
		damage = new damageProfile();
		
		damage.kin = 10 + 2 * level;
		damage.kin = scr_stats_applyDamageBonuses(char, damage.kin, "kin");
		
		damage.rad = 10 + 2 * level;
		damage.rad = scr_stats_applyDamageBonuses(char, damage.rad, "rad");
		
		damage = scr_stats_calculateDamageProfile(char, damage, false);
		
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