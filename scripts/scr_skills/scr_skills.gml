#region FUNCTIONS

//base class
function skill() constructor {
	
	name = "None";
	key = undefined;
	icon = spr_icon_blank;
	level = 1;
	description = "";
	statsDescription = "";
	
	maxLevel = 12;
	levelReq = 1;
	
	passives = undefined;
	
	cooldown = 0;
	cooldownTime = 2;

	castCooldown = 0;
	castCooldownTime = 0.5;

	charges = 1;
	maxCharges = 1;
	
	energyCost = 0;
	
	txtCol = c_white;

	static castFunc = undefined;
	
	static setupFunc = undefined;
	
	static formatStatsDescription = undefined;
	
	static extraEffects = undefined;

	static cast = function(source) {

		if (!canCast(source)) return false;
		
		if (!is_callable(castFunc)) return false;
		
		var success = castFunc(source);

		if (success) {

			if (maxCharges > 1) {
				
				charges--;
				
				if (cooldown == 0) cooldown = cooldownTime * 60;
				
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
	
	static canCast = function(source) {
	
		return ready() and source.energy >= energyCost;
		
	}

	
}

function scr_skills_setLevel(char, sk, level) {

	if (!instance_exists(char)) exit;
	
	sk = scr_char_getSkill(char, sk);
	
	if (is_undefined(sk)) exit;
	
	var prevLvl = sk.level;
	
	var effLevel = min(level, sk.maxLevel);
	
	sk.level = effLevel;
	
	//if (effLevel > prevLvl) sk.setupFunc(char);

}

function scr_skills_increaseLevel(char, sk) {

	if (!instance_exists(char)) exit;

	sk = scr_char_getSkill(char, sk);
	
	if (is_undefined(sk)) exit;
	
	if (sk.level < sk.maxLevel) {
	
		sk.level ++;
		//sk.setupFunc(char);
		
	}
	
}

function scr_skills_isActive(skillInst) {

	if (!is_instanceof(skillInst, skill)) return false;
	
	return is_callable(skillInst.castFunc);
	
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
            if (mustBeActive and !scr_skills_isActive(thisSkill)) continue;
            if (thisSkill.key == key) return thisSkill;

        }

    }

    return undefined;
	
}

function scr_skills_findCharSkill(key, char, mustBeActive = false) {
	
	if (key == undefined) return undefined;
	if (!instance_exists(char)) return undefined;
	
	if (char.pet) {
		if (instance_exists(char.owner)) {
			char = char.owner;	
		}
	}
	
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
			
            if (mustBeActive and !scr_skills_isActive(thisSkill)) continue;
            if (thisSkill.key == key) return thisSkill;

        }

    }

    return undefined;
	
}

function scr_skills_formatDescription(skillInst) {
	
	if (!is_instanceof(skillInst, skill)) return "";
	
	var passive = !scr_skills_isActive(skillInst);
	
	var txt = skillInst.name;
	
	if (passive) txt += "   (Passive)";
	
	txt += "    Level " + string(skillInst.level) + " / " + string(skillInst.maxLevel);
	
	if (skillInst.energyCost > 0) txt += "\n\nEnergy cost: " + string(skillInst.energyCost);
	
	if (!passive) {
		
		txt += "\nRecharge time: " + string(skillInst.cooldownTime) + " second";
		if (skillInst.cooldownTime > 1) txt += "s";
		
		if (skillInst.maxCharges > 1) {
			txt += "\nCharges: " + string(skillInst.maxCharges);	
		}
		
	}
	
	txt += "\n\n" + skillInst.description;
	
	if (skillInst.statsDescription != "") txt += "\n\n" + skillInst.statsDescription;
	
	var passives = skillInst.passives;
	var passivesTxt = "";
	
	if (is_struct(passives)) {
	
		var keys = variable_struct_get_names(passives);
		keys = scr_stats_orderStatKeys(keys);
		
		var keysLen = array_length(keys);
		
		for (var i = 0; i < keysLen; i ++) {
			
			var key = keys[i];
			var val = passives[$ key];
			
			var statTxt = scr_stats_getName(key);
			
			passivesTxt += "\n";
			passivesTxt += statTxt + ": " + string(val);
			
		}
	
	}
	
	if (passivesTxt != "") txt += "\n" + passivesTxt;
	
	return txt;
	
}
	
function scr_skills_applyBioBomb(inst, source, pools) {

	var sk = scr_skills_findCharSkill("bioBomb", source);
			
	if (is_struct(sk)) {
		
		//check for bio
		if (!scr_char_hasTag(inst, "bio")) {
		
			if (sk.level >= sk.maxLevel) {
				
				array_push(inst.tags, "bio");
				
			} else {
			
				exit;
			
			}
		
		}
		
		var damPerc = sk.damPerc;
		var poolDam = sk.poolDam;
		var poolLife = sk.poolLife;
		var poolRadius = sk.poolRadius;
				
		inst.bioBombData = {
			damPerc: damPerc,
			poolDam: poolDam,
			poolLife: poolLife,
			poolRadius: poolRadius,
			pools: pools
		}
		
		var dc = scr_skills_findCharSkill("decay", source);
			
		if (is_struct(dc)) {
			
			var radDamPerc = dc.damPerc;
			inst.bioBombData.radDamPerc = radDamPerc;
			
		}
				
		inst.deathFunc = scr_effects_bioBomb;
			
	}
	
}
	
#endregion

#region ACTIVES

	#region physics

	function skill_antimatterBlast() : skill() constructor {
	
		name = "Antimatter Blast";
		key = "antimatterBlast";
		icon = spr_icon_antimatter;
		maxCharges = 1;
		charges = 1;
		energyCost = 75;
		projectiles = 8;
		cooldownTime = 12;
		explosionRadius = 50;
		
		levelReq = 5;
	
		damage = undefined;
	
		description = "Unleash a barrage of magnetically suspended antimatter capsules."
		description += "\nOn impact the capsules shatter, causing the antimatter to annihilate\nin a devastating explosion.";
	
		static formatStatsDescription = function() {
	
			statsDescription = "Projectiles: " + string(projectiles);
			statsDescription += "\nExplosion Radius: " + string(explosionRadius);
			statsDescription += "\n\nDamage: " + string(damage.kin) +" kinetic, " + string(damage.rad) + " radiation";
	
		}
	
		static setupFunc = function(source) {
		
			energyCost = 75 + level * 5;
		
			projectiles = 6 + 2 * level;
			explosionRadius = 50 + level * 5;
		
			damage = new damageProfile();
		
			damage.kin = 8 + (level - 1) * 2;
			damage.rad = 8 + (level - 1) * 2;
			
			damage = scr_stats_calculateSkillDamage(source, damage, ["kin", "rad"]);	
		
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
	
	function skill_teleport() : skill() constructor {
	
		name = "Flash Teleport";
		key = "teleport";
		icon = spr_icon_wormhole;
		maxCharges = 1;
		energyCost = 25;
		cooldownTime = 10;
		maxLevel = 6;
		range = 940;
		txtCol = c_black;

		description = "Instantly teleport to where you aim."
	
		static setupFunc = function(source) {
		
			cooldownTime = 10 - (level - 1);
		
		}
	
		static castFunc = function(source) {
		
			var aimX = source.aimX;
			var aimY = source.aimY;
		
			var gunX = source.gunX;
			var gunY = source.gunY;
		
			var dir = point_direction(gunX, gunY, aimX, aimY);
		
			var aimDist = point_distance(gunX, gunY, aimX, aimY);
			var dist = min(range, aimDist);
		
			var xx = gunX + lengthdir_x(dist, dir);
			var yy = gunY + lengthdir_y(dist, dir);
			
			var pt = scr_obj_findValidPlace(source, xx, yy);
			
			if (pt == undefined) return false;
			
			scr_audio_playSoundAt(snd_teleport, pt.px, pt.py);
			
			var m = instance_create_layer(source.x, source.y, "Instances", obj_teleportMirage);
			m.sprite_index = source.sprite_index;
			m.image_index = source.image_index;
			
			source.x = pt.px;
			source.y = pt.py;
			
			var m2 = instance_create_layer(source.x, source.y + 8, "Instances", obj_teleportMirage);
			m2.sprite_index = source.sprite_index;
			m2.image_index = source.image_index;
			m2.alpha -= 0.1;
			
			return true;
			
		}
	
	}
	
	function skill_singularity() : skill() constructor {
	
		name = "Singularity";
		key = "singularity";
		icon = spr_icon_singularity;
		maxCharges = 1;
		energyCost = 80;
		cooldownTime = 12;
		maxLevel = 9;
		range = 380;
		pullRange = 600;
		txtCol = c_white;
		
		levelReq = 5;

		description = "Create a miniature black hole which pulls in enemies and then";
		description += "\nexplodes, dealing kinetic damage in an area.";
	
		static formatStatsDescription = function() {
			
			statsDescription = "Pull Range: " + string(pullRange);
			statsDescription += "\nDamage: " + string(damage.kin) + " kinetic";
			
		}
	
		static setupFunc = function(source) {
		
			energyCost = 75 + level * 5;
		
			pullRange = 630 + (level - 1) * 15;
			
			damage = new damageProfile();

			damage.kin = 40 + (level - 1) * 18;
			
			var damKeys = ["kin"];
			
			var sk = scr_skills_findCharSkill("decay", source);
			
			if (is_struct(sk)) {
			
				var damPerc = sk.damPerc;
				var dec = damPerc * 0.01;
				damage.rad = ceil(damage.kin * dec);
				
				array_push(damKeys, "rad");
			
			}
			
			damage = scr_stats_calculateSkillDamage(source, damage, ["kin"]);
		
		}
	
		static castFunc = function(source) {
		
			var aimX = source.aimX;
			var aimY = source.aimY;
		
			var gunX = source.gunX;
			var gunY = source.gunY;
		
			var dir = point_direction(gunX, gunY, aimX, aimY);
		
			var aimDist = point_distance(gunX, gunY, aimX, aimY);
			var dist = min(range, aimDist);
		
			var xx = gunX + lengthdir_x(dist, dir);
			var yy = gunY + lengthdir_y(dist, dir);
			
			var los = scr_physics_hasLineOfSight(source.x, source.y, xx, yy);
			
			if (!los) return false;
			
			var s = instance_create_layer(xx, yy, "Instances", obj_singularity);
			
			var pt = scr_obj_findValidPlace(s, xx, yy);
			
			if (pt != undefined) {
				s.x = pt.px;
				s.y = pt.py;
			}
			
			s.pullRange = pullRange;
			s.damage = damage;
			s.faction = source.faction;

			return true;
			
		}
	
	}
	
	function skill_particleShower() : skill() constructor {
	
		name = "Particle Shower";
		key = "particleShower";
		icon = spr_icon_particleShower;
		maxCharges = 1;
		energyCost = 50;
		cooldownTime = 8;
		maxLevel = 9;
		
		levelReq = 1;
		
		range = 600;
		radius = 180;
		duration = 6;
		txtCol = c_white;
		flashpointDam = undefined;
		areaDamage = undefined;

		description = "Create a shower of subatomic particles that rains down from above.";
		description += "\nEnemies within the area take radiation damage and have their\ndefensive ability reduced.";
	
		static formatStatsDescription = function() {
			
			statsDescription = "Enemy Defensive Ability: " + string(daReduction);
			statsDescription += "\nParticles: " + string(particles) + " p/s ";
			statsDescription += "\nDuration: " + string(duration) + " seconds";
			statsDescription += "\n\nParticle Damage: " + string(damage.rad) + " radiation";
			statsDescription += "\nArea Damage: " + string(areaDamage.rad) + " radiation p/s";
		}
	
		static setupFunc = function(source) {
		
			energyCost = 50 + (level - 1) * 5;
		
			particles = 8 + (level - 1) * 2;
			daReduction = -(10 + (level - 1) * 5);
			
			damage = new damageProfile();
			damage.rad = 10 + (level - 1) * 2;
			damage = scr_stats_calculateSkillDamage(source, damage, ["rad"]);
			
			areaDamage = new damageProfile();
			areaDamage.rad = 6 + (level - 1) * 1;
			areaDamage = scr_stats_calculateSkillDamage(source, areaDamage, ["rad"]);
			
			var sk = scr_skills_findCharSkill("flashpoint", source);
			if (sk != undefined) flashpointDam = sk.damage;
		
		}
	
		static castFunc = function(source) {
		
			var aimX = source.aimX;
			var aimY = source.aimY;
		
			var gunX = source.gunX;
			var gunY = source.gunY;
		
			var dir = point_direction(gunX, gunY, aimX, aimY);
		
			var aimDist = point_distance(gunX, gunY, aimX, aimY);
			var dist = min(range, aimDist);
		
			var xx = gunX + lengthdir_x(dist, dir);
			var yy = gunY + lengthdir_y(dist, dir);
			
			var ps = instance_create_layer(xx, yy, "Instances", obj_particleShower);
			
			ps.damage = damage;
			ps.areaDamage = areaDamage;
			ps.faction = source.faction;
			ps.daReduction = daReduction;
			ps.particles = particles;
			ps.duration = duration;
			ps.radius = radius;
			
			//flashpoint
			if (is_struct(flashpointDam)) {
				//scr_testSound();
				var bg = instance_create_layer(xx, yy, "Instances", obj_burningGround);
				bg.damage = flashpointDam;
				bg.radius = radius;
				bg.faction = source.faction;
				bg.life = 4;
			
			}

			return true;
			
		}
	
	}
	
	function skill_forceField() : skill() constructor {
	
		name = "Force Field";
		key = "forceField";
		icon = spr_icon_forceField;
		maxCharges = 1;
		energyCost = 80;
		cooldownTime = 14;
		maxLevel = 6;
		duration = 5;
		
		txtCol = c_white;
		
		da = 10;
		projRes = 5;
		meleeRes = 5;

		description = "Create a temporary barrier that deflects attacks.";
	
		static formatStatsDescription = function() {
			
			statsDescription = "Duration: " + string(duration) + " seconds";
			statsDescription += "\nDefensive Ability: " + string(da);
			statsDescription += "\nProjectile Resistance: " + string(projRes);
			statsDescription += "\nMelee Resistance: " + string(meleeRes);
			
		}
	
		static setupFunc = function(source) {
			
			duration = 5 + (level - 1) * 0.4;
			
			da = 6 + level * 6;
			projRes = 4 + level * 4;
			meleeRes = 4 + level * 4;
		
		}
	
		static castFunc = function(source) {
		
			var ff = instance_create_layer(source.x, source.y, "Instances", obj_forceField);
			
			ff.owner = source;
			ff.life = duration * 60;
			ff.da = da;
			ff.projRes = projRes;
			ff.meleeRes = meleeRes;

			return true;
			
		}
	
	}

	#endregion

	#region chemistry

	function skill_flamethrower() : skill() constructor {
	
		name = "Flamethrower";
		key = "flamethrower";
		icon = spr_icon_flamethrower;
		maxLevel = 12;
		maxCharges = 1;
		charges = 1;
		energyCost = 100;
		jetCount = 4;
		cooldownTime = 16;
		life = 8;
		damTime = 0.5;
	
		damage = undefined;
	
		description = "Spinning fire!";
	
		static formatStatsDescription = function() {
	
			statsDescription = "Jets: " + string(jetCount);
			statsDescription += "\n\nDuration: " + string(life) +" seconds";
			statsDescription += "\n\nJet Damage: " + string(damage.fire / damTime) +" fire p/s";
			
		}
	
		static setupFunc = function(source) {
		
			jetCount = 4 + (level - 1) div 4;
			life = 7.5 + 0.5 * level;
		
			damage = new damageProfile();
		
			damage.fire = 8 + 2 * level;
			
			var damKeys = ["fire"];
			
			var sk = scr_skills_findCharSkill("decay", source);
			
			if (is_struct(sk)) {
				
				var damPerc = sk.damPerc;
				var dec = damPerc * 0.01;
				damage.rad = ceil(damage.fire * dec);
				array_push(damKeys, "rad");
			
			}	
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
			
		}
	
		static castFunc = function(source) {
		
			var ff = instance_create_layer(source.x, source.y, "Instances", obj_flamethrower);
	
			ff.owner = source;
			ff.damage = damage;
			ff.jetCount = jetCount;
			ff.faction = source.faction;
			ff.life = life;
			ff.damTime = damTime;
			
			return true;
			
		}
	
	}

	function skill_acidFlasks() : skill() constructor {
	
		name = "Acid Flasks";
		key = "acidFlasks";
		icon = spr_icon_acidFlasks;
		maxLevel = 12;
		maxCharges = 1;
		charges = 1;
		energyCost = 55;
		projectiles = 6;
		cooldownTime = 8;
		radius = 50;
		life = 4;
		spr = spr_acidFlask;
	
		damage = undefined;
	
		description = "Throw glass acid flasks that shatter on impact, creating pools of acid\n";
		description += "that deal chemical damage to enemies standing in them.";
	
		static formatStatsDescription = function() {
	
			statsDescription = "Projectiles: " + string(projectiles);
			statsDescription += "\nPool Radius: " + string(radius);
			statsDescription += "\nPool Duration: " + string(life) + " seconds";
			statsDescription += "\n\nDamage: " + string(damage.chem) + " chemical p/s";
			
		}
	
		static setupFunc = function(source) {
		
			energyCost = 40 + level * 5;
		
			projectiles = 5 + level div 2;
			radius = 40 + level * 2;
			life = 4.5 + level * 0.5;
		
			damage = new damageProfile();
		
			damage.chem = 8 + 2 * level;

			var damKeys = ["chem"];
			
			var napalm = scr_skills_findCharSkill("napalm", source);
			
			if (napalm != undefined) {
				
				damage.fire = napalm.fireDam;
				array_push(damKeys, "fire");
				
			}
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
		
		}
	
		static castFunc = function(source) {
		
			var aimX = source.aimX;
			var aimY = source.aimY;
		
			var gunX = source.gunX;
			var gunY = source.gunY;
		
			var dir = point_direction(gunX, gunY, aimX, aimY);
		
			var launcher = instance_create_layer(gunX, gunY, "Instances", obj_acidFlaskLauncher);
		
			if (instance_exists(launcher)) {
			
				launcher.owner = source;
				launcher.damage = damage;
				launcher.dir = dir;
				launcher.totalProjectiles = projectiles;
				launcher.radius = radius;
				launcher.faction = source.faction;
				launcher.poolLife = life;
				launcher.spr = spr;
			
				return true;
			
			}
		
		}
	
	}
	
	function skill_gas() : skill() constructor {
	
		name = "Noxious Gas";
		key = "gas";
		icon = spr_icon_gas;
		maxLevel = 9;
		maxCharges = 4;
		energyCost = 20;
		maxProjectiles = 6;
		cooldownTime = 2;
		castCooldownTime = 0.75;
		bioBonus = 10;
		life = 420;
		
		levelReq = 5;
	
		damage = undefined;
	
		description = "Spray clouds of corrosive gas ahead of you. Gas clouds do";
		description += "\nextra damage to biological enemies and ignore shields.";
	
		//TO DO: use extraEffects to give source a gas object pool
	
		static formatStatsDescription = function() {
	
			statsDescription = "Projectiles: " + string(maxProjectiles);
			statsDescription += "\nBonus against bio: " + string(bioBonus) + "%";
			statsDescription += "\n\nDamage: " + string(damage.chem * 2) + " chemical p/s";
			
		}
	
		static setupFunc = function(source) {
		
			cooldownTime = 3 - (level - 1) * 0.08;
			energyCost = 18 + (level - 1) * 2;
			maxProjectiles = 6 + (level - 1);

			damage = new damageProfile();
			
			bioBonus = 8 + (level - 1) * 3;
		
			damage.chem = 4 + (level - 1) * 2;
			
			var damKeys = ["chem"];
			
			var sk = scr_skills_findCharSkill("decay", source);
			
			if (is_struct(sk)) {
			
				var damPerc = sk.damPerc;
				var dec = damPerc * 0.01;
				damage.rad = ceil(damage.chem * dec);
				array_push(damKeys, "rad");
			
			}	
		
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
		
		}
	
		static castFunc = function(source) {
		
			var gunX = source.gunX;
			var gunY = source.gunY;

			var launcher = instance_create_layer(gunX, gunY, "Instances", obj_gasLauncher);
		
			if (instance_exists(launcher)) {
			
				launcher.owner = source;
				launcher.faction = source.faction;
				launcher.damage = damage;
				launcher.maxProjectiles = maxProjectiles;
				launcher.life = life;
				launcher.bioBonus = bioBonus;
			
				return true;
			
			}
		
		}
	
	}

	function skill_thermiteCharge() : skill() constructor {
		
		name = "Thermit Charge";
		key = "thermiteCharge";
		icon = spr_icon_thermite;
		maxLevel = 12;
		maxCharges = 4;
		energyCost = 35;
		cooldownTime = 3;
		castCooldownTime = 0.5;
		flameLife = 4;
		burnRadius = 120;
		
		levelReq = 5;

		damage = undefined;
		flameDamage = undefined;
	
		description = "Deploy thermite charges that detonate and set the ground on fire.";
		description += "\nCharges detonate after a 5 second countdown. Press C to detonate charges early.";
		
		static formatStatsDescription = function() {
			
			statsDescription = "Burning Ground Duration: 4 seconds"
			statsDescription += "\n\nExplosion Damage: " + string(damage.kin) + " kinetic, " + string(damage.fire) + " fire";
			statsDescription += "\nBurning Ground Damage: " + string(flameDamage.fire * 2) + " fire p/s";

		}
	
		static setupFunc = function(source) {
		
			maxCharges = 2 + level div 3;
			
			damage = new damageProfile();
			flameDamage = new damageProfile();
			
			damage.kin = 20 + (level - 1) * 5;
			damage.fire = 20 + (level - 1) * 5;
			
			var damKeys = ["kin","fire"];
			var sk = scr_skills_findCharSkill("decay", source);
			
			if (is_struct(sk)) {
			
				var damPerc = sk.damPerc;
				var dec = damPerc * 0.01;
				damage.rad = ceil(damage.kin * dec) * 2;
				array_push(damKeys, "rad");
			
			}	
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
			
			flameDamage.fire = 8 + (level - 1) * 4;

			damKeys = ["fire"];
			
			var napalm = scr_skills_findCharSkill("napalm", source);
			
			if (napalm != undefined) {

				flameDamage.chem = napalm.chemDam;
				array_push(damKeys, "chem");
				
			}
			
			flameDamage = scr_stats_calculateSkillDamage(source, flameDamage, damKeys);
			
		}
	
		static castFunc = function(source) {
		
			var tc = instance_create_layer(source.x, source.y, "Instances", obj_thermiteCharge);

			tc.owner = source;
			tc.damage = damage;
			tc.flameDamage = flameDamage;
			tc.faction = source.faction;
			tc.life = flameLife;
			tc.burnRadius = burnRadius;
			
			return true;
			
		}
		
	}

	#endregion

	#region biology

	function skill_blob() : skill() constructor {
	
		name = "Blob";
		key = "blob";
		icon = spr_icon_blob;
	
		maxLevel = 9;
		maxCharges = 2;
		energyCost = 20;
		cooldownTime = 1;
		castCooldownTime = 0.25;
		maxSpawns = 2;
		life = 5;
		maxHp = 50;
		shields = 0;
		kinDam = 5;
		chemDam = 5;
	
		description = "Spawn blobular organisms that fight by your side.\nThough it appears to be a single creature, it is actually\na coordinated mass of microscopic lifeforms."

		static formatStatsDescription = function() {
		
			statsDescription = "Max Spawns: " + string(maxSpawns);
			statsDescription += "\nLife: " + string(life) + " seconds";
			statsDescription += "\nHP: " + string(maxHp);
			statsDescription += "\n\nDamage: " + string(kinDam) +" kinetic, " + string(chemDam) + " chemical";
		
		}

		static setupFunc = function(source) {
		
			kinDam = 5 + (level - 1);
			chemDam = 5 + (level - 1);
		
			life = 6 + (level - 1) * 0.5;
			maxSpawns = 2 + (level - 1);
			maxCharges = maxSpawns;
			maxHp = 40 + (level - 1) * 5;
		
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
		
			var inst = scr_char_spawnPet(obj_blob, source, life, xx, yy, maxSpawns, true);
			
			if (!instance_exists(inst)) return false;
			
			inst.life = life;
			inst.level = level;
			inst.kinDam = kinDam;
			inst.chemDam = chemDam;
			inst.baseStats.maxHp = maxHp;
			inst.baseStats.maxShield = shields;

			scr_audio_playSoundAt(snd_alienShoot2, xx, yy);
			
			//bio bomb
			scr_skills_applyBioBomb(inst, source, 2);

			if (instance_exists(inst)) return true;

		}
	
	}
	
	function skill_fungalTurret() : skill() constructor {
	
		name = "Fungal Turret";
		key = "fungalTurret";
		icon = spr_icon_fungalTurret;
		
		levelReq = 5;
	
		maxLevel = 9;
		maxCharges = 1;
		charges = 1;
		energyCost = 20;
		cooldownTime = 4;
		castCooldownTime = 0.25;
		maxSpawns = 1;
		life = 6;
		maxHp = 100;
		kinDam = 3;
		chemDam = 4;
		shields = 0;
		flashpointDam = undefined;
	
		description = "Spawn giant mushrooms that spew acid at your enemies";
	
		static formatStatsDescription = function() {
	
			statsDescription = "Max Spawns: " + string(maxSpawns);
			statsDescription += "\nLife: " + string(life) + " seconds";
			statsDescription += "\nHP: " + string(maxHp);
			statsDescription += "\nProjectiles: 12";
			statsDescription += "\n\nDamage: " + string(kinDam) + " kinetic, " + string(chemDam) + " chemical";
		
		}

		static setupFunc = function(source) {
		
			kinDam = 3 + (level - 1);
			chemDam = 4 + (level - 1) * 2;
		
			energyCost = 30 + (level - 1) * 2;
			life = 6 + (level - 1) * 0.75;
			maxSpawns = 1 + level div 3;
			maxCharges = maxSpawns;
			maxHp = 100 + (level - 1) * 15;
			gunDamMult = 1 + (level - 1) * 0.2;
		
			var ga = scr_skills_findCharSkill("guardianArray", source, false);
		
			if (is_struct(ga)) {
				shields = ga.petShields;
			}
			
			var sk = scr_skills_findCharSkill("flashpoint", source);
			if (sk != undefined) flashpointDam = sk.damage;
	
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
			
			if (!instance_exists(inst)) return false;
			
			inst.life = life;
			inst.level = level;
			inst.baseStats.maxHp = maxHp;
			inst.kinDam = kinDam;
			inst.chemDam = chemDam;
			inst.baseStats.maxShield = shields;
			
			//flashpoint
			if (is_struct(flashpointDam)) {
				//scr_testSound();
				var bg = instance_create_layer(inst.x, inst.y, "Instances", obj_burningGround);
				bg.damage = flashpointDam;
				bg.radius = 120;
				bg.faction = source.faction;
				bg.life = 4;
			
			}
			
			//bioBomb
			scr_skills_applyBioBomb(inst, source, 3);

			scr_audio_playSoundAt(snd_alienShoot2, xx, yy);

			if (instance_exists(inst)) return true;

		}
	
	}
	
	function skill_symbiont() : skill() constructor {
	
		name = "Symbiont";
		key = "symbiont";
		icon = spr_icon_symbiont;
		
		levelReq = 10;
	
		maxLevel = 12;
		maxCharges = 1;
		charges = 1;
		energyCost = 20;
		cooldownTime = 4;
		castCooldownTime = 0.25;
		maxSpawns = 1;
		maxHp = 150;
		shields = 0;
		lifeSteal = 5;
		kinDam = 10;
	
		description = "Spawn a genetically modified human-lamprey hybrid\nthat heals you when it attacks enemies.";
		description += "\nSymbiont fights until it dies.";
		
		static formatStatsDescription = function() {
	
			statsDescription = "HP: " + string(maxHp);
			statsDescription += "\nLife Steal: " + string(lifeSteal) + "%";
			statsDescription += "\n\nDamage: " + string(kinDam) + " kinetic";
		
		}

		static setupFunc = function(source) {
		
			kinDam = 10 + (level - 1) * 2;
			energyCost = 60 + (level - 1) * 2;
			maxHp = 125 + (level - 1) * 15;
			lifeSteal = 7 + (level - 1) * 3;
		
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

			var inst = scr_char_spawnPet(obj_symbiont, source, undefined, xx, yy, maxSpawns, true);
			
			if (!instance_exists(inst)) return false;
			
			inst.level = level;
			inst.baseStats.maxHp = maxHp;
			inst.baseStats.maxShield = shields;
			inst.baseStats.meleeLifeSteal = lifeSteal;
			inst.kinDam = kinDam;
			
			//bioBomb
			scr_skills_applyBioBomb(inst, source, 4);

			if (instance_exists(inst)) return true;

		}
	
	}
	
	function skill_medicalExosomes() : skill() constructor {
	
		name = "Medical Exosomes";
		key = "medicalExosomes";
		icon = spr_icon_exosomes;
		txtCol = c_black;
	
		maxLevel = 9;
		maxCharges = 1;
		energyCost = 60;
		
		cooldownTime = 24;
		castCooldownTime = 0.25;
		
		heal = 4;
		allyHeal = 4;
		ticks = 10;
		range = 100;

		description = "Release engineered vesicles that restore health over time\nfor you and nearby biological allies."

		static formatStatsDescription = function() {
		
			var totalHeal = heal * ticks;
			statsDescription = "Heals: " + string(totalHeal) + "HP over 10 seconds";
			statsDescription += "\nRange: " + string(range);
			
		}

		static setupFunc = function(source) {
		
			energyCost = 55 + level * 5;
			heal = 4 + 2 * (level - 1);
			
			var dec = 1 + source.stats.healingPerc * 0.01;

			allyHeal = ceil(heal * dec);
			
			range = 250 + (level - 1) * 25;
			
		}
	
		static castFunc = function(source) {
		
			var inst = instance_create_layer(source.x, source.y, "Instances", obj_exosomes);
			inst.owner = source;
			inst.heal = heal;
			inst.ticks = ticks;
			inst.range = range;
			inst.faction = source.faction;
			inst.allyHeal = allyHeal;
		
			if (instance_exists(inst)) return true;

		}
	
	}
	
	function skill_bioBomb() : skill() constructor {
	
		name = "Bio-Bomb";
		key = "bioBomb";
		icon = spr_icon_exosomes;
		txtCol = c_black;
	
		maxLevel = 6;

		damPerc = 5;
		poolDam = 5;

		description = "When a biological summon dies, it explodes with chemical damage proportional to its maximum health\nand leaves behind acid pools."
		description += " When fully upgraded, non-biological summons count as biological.";
		
		static formatStatsDescription = function() {
		
			statsDescription = "Explosion damage: " + string(damPerc) + "% of maximum health";
			statsDescription += "\nAcid pool damage: " + string(poolDam.chem) + " chemical p/s";
			
			if (level >= maxLevel) statsDescription += "\n\nAll summons are biological.";
			
		}

		static setupFunc = function(source) {
		
			damPerc = 5 + (level - 1) * 3;
			
			poolRadius = 40 + level * 2;
		    poolLife = 4.5 + level * 0.5;
			
			poolDam = new damageProfile();
			poolDam.chem = 6 + 2 * level;
			
			var damKeys = ["chem"];
			
			var sk = scr_skills_findCharSkill("napalm", source);
			
			if (is_struct(sk)) {
			
				poolDam.fire = sk.fireDam;
				array_push(damKeys, "fire");
			
			}
			
			poolDam = scr_stats_calculateSkillDamage(source, poolDam, damKeys);
			
		}
	
	}

	#endregion

	#region engineering

	function skill_chainLightning() : skill() constructor {

		name = "Chain Lightning";
		key = "chainLightning";
		icon = spr_icon_chainLightning;
		maxCharges = 2;
		charges = 2;
		cooldownTime = 5.5;
		energyCost = 30;
		range = 900;
		chains = 1;
	
		damage = undefined;
	
		description = "Electricity bounces from target to target\ndealing decreased damage with every jump.";
	
		static formatStatsDescription = function() {
		
			statsDescription = "Targets: " + string(chains + 1);
			statsDescription += "\n\nDamage: " + string(damage.elec) + " electric";
		
		}
	
		static setupFunc = function(source) {
		
			energyCost = 30 + level * 5;
		
			chains = 1 + floor(level / 2);
		
			damage = new damageProfile();
			damage.elec = 25 + 10 * level;
			
			var damKeys = ["elec"];
			var sk = scr_skills_findCharSkill("decay", source);
			
			if (is_struct(sk)) {
			
				var damPerc = sk.damPerc;
				var dec = damPerc * 0.01;
				damage.rad = ceil(damage.elec * dec);
				array_push(damKeys, "rad");
			
			}	
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
		
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
			cl.faction = source.faction;
		
			return true;
		
		}
	
	}
	
	function skill_EMP() : skill() constructor {

		name = "EMP";
		key = "emp";
		icon = spr_icon_EMP;
		maxLevel = 12;
		
		levelReq = 5;
		
		maxCharges = 1;
		cooldownTime = 4.5;
		energyCost = 60;
		radius = 400;
		muchBonus = 10;
		flashpointDam = undefined;

		damage = undefined;
	
		description = "Trigger an electromagnetic pulse which deals electric damage in a circle";
		description += "\naround you. Deals increased damage to mechanical enemies.";
		
		static formatStatsDescription = function() {
		
			statsDescription = "Radius: " + string(radius);
			statsDescription += "\nBonus against mech: " + string(mechBonus) + "%";
			statsDescription += "\n\nDamage: " + string(damage.elec) + " electric";
		
		}
	
		static setupFunc = function(source) {
		
			energyCost = 45 + (level - 1) * 5;
			radius = 155 + (level - 1) * 5;
			mechBonus = 10 + (level - 1) * 2;
			
			damage = new damageProfile();
			damage.elec = 27 + (level - 1) * 8;
			
			var damKeys = ["elec"];
			var sk = scr_skills_findCharSkill("decay", source);
			
			if (is_struct(sk)) {
			
				var damPerc = sk.damPerc;
				var dec = damPerc * 0.01;
				damage.rad = ceil(damage.elec * dec);
				array_push(damKeys, "rad");
			
			}	
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
			
			var sk = scr_skills_findCharSkill("flashpoint", source);
			if (sk != undefined) flashpointDam = sk.damage;
		
		}
	
		static castFunc = function(source) {

			if (!instance_exists(source)) return false;

			var emp = instance_create_layer(source.x, source.y, "Instances", obj_EMP);
			emp.owner = source;
			emp.damage = damage;
			emp.radius = radius;
			emp.mechBonus = mechBonus;
			
			//flashpoint
			if (is_struct(flashpointDam)) {
				//scr_testSound();
				var bg = instance_create_layer(source.x, source.y, "Instances", obj_burningGround);
				bg.damage = flashpointDam;
				bg.radius = radius;
				bg.faction = source.faction;
				bg.life = 4;
			}
		
			return true;
		
		}
	
	}

	function skill_turret() : skill() constructor {
	
		name = "Auto-Turret";
		key = "turret";
		icon = spr_icon_turret;
		maxLevel = 10;
		maxCharges = 1;
		charges = 1;
		energyCost = 50;
		cooldownTime = 18;
		castCooldownTime = 0.2;
		maxSpawns = 2;
		clips = 2;
		ammoPerClip = 18;
		maxHp = 150;
		shields = 0;
		kinDam = 8;
		flashpointDam = undefined;
	
		description = "Deploy an automated stationary gun that fires until its ammo runs out.\n"
		description += "Flat damage bonuses and effects that apply to your weapons also apply\nto the turret's bullets.";
	
		static formatStatsDescription = function() {
	
			var ammo = clips * ammoPerClip;
		
			statsDescription = "HP: " + string(maxHp);
			statsDescription += "\nAmmo: " + string(ammo) + " (" + string(clips) + " clips X " + string(ammoPerClip) + " ammo per clip)";
			statsDescription += "\nDamage: " + string(kinDam) + " kinetic";
	
		}

		static setupFunc = function(source) {
		
			energyCost = 50 + (level - 1) * 5;
			maxHp = 200 + (level - 1) * 20;
			kinDam = 8 + (level - 1) + level div 5;
			shields = 0;
		
			clips = 2;
			ammoPerClip = 18;

			for (var i = 1; i <= level; i++) {

			    if (i mod 3 == 0) {
			        clips++;
			    } else {
			        ammoPerClip += 2;
			    }

			}
	
			var ga = scr_skills_findCharSkill("guardianArray", source, false);
		
			if (is_struct(ga)) {
				shields = ga.petShields;
			}
			
			var sk = scr_skills_findCharSkill("flashpoint", source);
			if (sk != undefined) flashpointDam = sk.damage;
	
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
			inst.ammoPerClip = ammoPerClip;
			inst.level = level;
			inst.baseStats.maxHp = maxHp;
			inst.kinDam = kinDam;
			inst.baseStats.maxShield = shields;
			
			//flashpoint
			if (is_struct(flashpointDam)) {
				//scr_testSound();
				var bg = instance_create_layer(inst.x, inst.y, "Instances", obj_burningGround);
				bg.damage = flashpointDam;
				bg.radius = 120;
				bg.faction = source.faction;
				bg.life = 4;
			
			}
			
			//bioBomb
			scr_skills_applyBioBomb(inst, source, 3);

			if (instance_exists(inst)) return true;

		}
	
	}
	
	function skill_mech() : skill() constructor {
	
		name = "M.E.K";
		key = "mech";
		icon = spr_icon_mech;
		maxLevel = 12;
		levelReq = 10;
		
		
		maxCharges = 1;
		energyCost = 90;
		cooldownTime = 30;
		castCooldownTime = 0.2;
		maxSpawns = 1;
		maxHp = 300;
		kinDam = 22;
		shields = 0;
		txtCol = c_white;
	
		description = "Deploy a Mobile Electronic Killer to fight by your side."
		description += " Flat damage bonuses\nand effects that apply to your weapons also apply to the M.E.K's bullets.";
		description += "\nM.E.K fights until it dies and then explodes.";
		
		static formatStatsDescription = function() {
	
			statsDescription = "HP: " + string(maxHp);
			statsDescription += "\nDamage: " + string(kinDam) + " kinetic";
	
		}

		static setupFunc = function(source) {
		
			energyCost = 90;
			maxHp = 300 + (level - 1) * 25;
			
			kinDam = 22 + (level - 1) * 2;
			shields = 0;
		
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
		
			var inst = scr_char_spawnPet(obj_mechPet, source, undefined, xx, yy, maxSpawns, true);
			inst.level = level;
			inst.baseStats.maxHp = maxHp;
			inst.kinDam = kinDam;
			inst.baseStats.maxShield = shields;
			
			//bioBomb
			scr_skills_applyBioBomb(inst, source, 5);

			if (instance_exists(inst)) return true;

		}
	
	}

	#endregion

#endregion

#region PASSIVES

	#region physics

	function skill_joltzmanShield() : skill() constructor {

		name = "Joltzman Shield";
		key = "joltzmanShield";
		icon = spr_icon_joltzmanShield;
		txtCol = c_black;
		maxLevel = 3;
		
		levelReq = 5;
	
		description = "Grants you shield points.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				maxShield: level
	
			};
	
		}
	
	}
	
	function skill_leadCoat() : skill() constructor {

		name = "Lead Coat";
		key = "leadCoat";
		icon = spr_icon_leadCoat;
		txtCol = c_white;
		maxLevel = 4;
		
		description = "Increases your radiation resistance.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				radRes: 4 * level
	
			};
	
		}
	
	}
	
	function skill_vacuumEnergy() : skill() constructor {

		name = "Vacuum Energy";
		key = "vacuumEnergy";
		icon = spr_icon_vacuumEnergy;
		txtCol = c_white;
		maxLevel = 9;
		
		levelReq = 5;
		
		description = "Harness the energy of virtual particles as they emerge from the quantum vacuum.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				energyRegen: 0.25 * level
	
			};
	
		}
	
	}
	
	function skill_predictiveModelling() : skill() constructor {

		name = "Predictive Modelling";
		key = "predictiveModelling";
		icon = spr_icon_predictiveModelling;
		txtCol = c_white;
		maxLevel = 8;
		
		description = "Advanced predictive models continuously calculate incoming trajectories,"
		description += "\nallowing you to avoid the most dangerous impacts.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				da: 5 + (level - 1) * 5
	
			};
	
		}
	
	}
	
	function skill_decay() : skill() constructor {

		name = "Decay";
		key = "decay";
		icon = spr_icon_decay;
		txtCol = c_white;
		maxLevel = 8;
		damPerc = 4;
		
		description = "Adds radiation damage to certain abilites.\The extra damage is proportional to the ability's primary damage element.";
		description += "\n\nEffected abilites: ";
		description += "\n- Singularity\n- Bio Bomb\n- Noxious Gas\n- Flamethrower\n- Thermite Charge\n- Chain Lightning\n- EMP";
		//
		static formatStatsDescription = function() {
		
			statsDescription = "Damage: " + string(damPerc) + "% of primary damage";
		
		}
	
		static setupFunc = function(source) {
	
			damPerc = 8 + (level - 1) * 6;
	
		}
	
	}
	
	function skill_radioactiveBullets() :skill() constructor {
	
		name = "Radioactive Weapons";
		key = "radioactiveBullets";
		icon = spr_icon_radioactiveBullets;
		maxLevel = 6;
		
		chance = 3;
		damage = undefined;
		radius = 50;
	
		description = "Your projectiles and melee attakcs deal extra radiation damage and\n";
		description += "have a chance to detonate, dealing additonal area\nradiation damage.";
		
		static formatStatsDescription = function() {

			statsDescription = "Detonation Chance: " + string(chance) + "%";
			statsDescription += "\nDamage Radius: " + string(radius);
			statsDescription += "\nArea Damage: " + string(damage.rad) + " radiation";
		
		}
		
		static extraEffects = function(source) {
			
			var func = scr_effects_radioactiveBullet;
			scr_char_addBulletFunc(source, func);
			scr_char_addMeleeFunc(source, func);
			
		}
		
		static setupFunc = function(source) {
	
			chance = level * 2;
	
			radius = 75 + (level - 1) * 5;

			damage = new damageProfile();
		
			damage.rad = 22 + (level - 1) * 4;
			damage = scr_stats_calculateSkillDamage(source, damage, ["rad"]);
			
			passives = {
		
				radDam: level
		
			}
	
		}
	
	}
	
	#endregion

	#region chemistry

	function skill_flashpoint() : skill() constructor {

		name = "Flashpoint";
		key = "flashpoint";
		icon = spr_icon_flashpoint;
		maxLevel = 8;
		damage = undefined;
		
		levelReq = 10;
	
		description = "Certain abilities create burning ground where they are cast.";
		description += "\n\nEffected abilites: ";
		description += "\n- Particle Shower\n- Fungal Turret\n- Auto-Turret\n- EMP";
		
		static formatStatsDescription = function() {
		
			statsDescription = "Bunring Ground Damage: " + string(damage.fire * 2) + " fire p/s";
		
		}
		
		static setupFunc = function(source) {
	
			damage = new damageProfile();
	
			damage.fire = 6 + (level - 1) * 2;

			var damKeys = ["fire"];
			
			var napalm = scr_skills_findCharSkill("napalm", source);
			
			if (napalm != undefined) {

				damage.chem = napalm.chemDam;
				array_push(damKeys, "chem");
				
			}
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
	
		}
		
	}

	function skill_napalm() : skill() constructor {

		name = "Napalm";
		key = "napalm";
		icon = spr_icon_napalm;
		maxLevel = 9;
		fireDam = 4;
		chemDam = 4;
		
		levelReq = 5;
	
		description = "Your acid pools deal fire damage in addition to chemical damage.";
		description += "\nBurning ground deals chemical damage in addition to fire damage.";
		
		static formatStatsDescription = function() {
		
			statsDescription = "Acid Pool Fire Damage: " + string(fireDam) + " p/s";
			statsDescription += "\nBurning Ground Chemical Damage: " + string(chemDam * 2) + " p/s";
			
		}
		
		static setupFunc = function(source) {
	
			fireDam = 4 + (level - 1);
			chemDam = 4 + (level - 1) * 2;
	
		}
	
	}

	function skill_PPE() : skill() constructor {

		name = "PPE";
		key = "PPE";
		icon = spr_icon_PPE;
		maxLevel = 6;
	
		description = "Increases your chemical and fire resistances.";
	
		passives = {
	
			chemRes: 3,
			fireRes: 3
	
		};
	
		static setupFunc = function(source) {
	
			passives = {
	
				chemRes: 3 * level,
				fireRes: 3 * level
	
			};
	
		}
	
	}
	
	function skill_medicalSynthesis() : skill() constructor {

		name = "Pharmaceutical Synthesis";
		key = "medicalSynthesis";
		icon = spr_icon_medicalSynthesis;
		txtCol = c_black;
		maxLevel = 4;
		
		levelReq = 5;
	
		description = "The first point increases your maximum stim packs by 1.\nEach point increases stim pack regeneration rate.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				maxStimPacks: 1,
				stimPackRegen: level * 0.1
	
			};
	
		}
	
	}
	
	function skill_acidicBullets() : skill() constructor {

		name = "Acidic Weapons";
		key = "acidicBullets";
		icon = spr_icon_acidicBullets;
		maxLevel = 6;
		
		chance = 3;
		damage = undefined;
		radius = 40;
		life = 5;
		chemDam = 1;
	
		description = "Your projectiles and melee attacks deal extra chemical damage and\n";
		description += "have a chance of creating acid pools where they collide.";
		
		static formatStatsDescription = function() {

			statsDescription = "Acid Pool Chance: " + string(chance) + "%";
			statsDescription += "\nAcid Pool Radius: " + string(radius);
			statsDescription += "\nAcid Pool Duration: " + string(life) +" seconds";
			statsDescription += "\nAcid Pool Damage: " + string(damage.chem) + " chemical p/s";
		
		}
		
		static extraEffects = function(source) {
			
			var func = scr_effects_acidicBullet;
			
			scr_char_addBulletFunc(source, func);
			scr_char_addMeleeFunc(source, func);
			
		}
		
		static setupFunc = function(source) {
	
			chance = level * 2;
	
			radius = 40 + level * 2;
			life = 4.5 + level * 0.5;
		
			damage = new damageProfile();
		
			damage.chem = 6 + 2 * level;
			
			var damKeys = ["chem"];
			
			var napalm = scr_skills_findCharSkill("napalm", source);
			
			if (napalm != undefined) {
				
				damage.fire = napalm.fireDam;
				array_push(damKeys, "fire");
				
			}
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
			
			passives = {
		
				chemDam: level
		
			}
	
		}
	
	}
	
	

	#endregion

	#region biology

	function skill_muscleGrowth() : skill() constructor {

		name = "Myostatin Inhibitor";
		key = "muscleGrowth";
		icon = spr_icon_myostatinInhibitor;
		maxLevel = 6;
		
		levelReq = 5;
	
		description = "Block the body's natural limit on muscle growth, increasing your melee damage.";
	
		passives = {
	
			meleeDamPerc: 5
	
		};
	
		static setupFunc = function(source) {
	
			passives = {
	
				meleeDamPerc: 5 + (level -1) * 4
	
			};
	
		}
	
	}
	
	function skill_chitin() : skill() constructor {

		name = "Chitin";
		key = "chitin";
		icon = spr_icon_chitin;
		maxLevel = 8;
		
		levelReq = 5;
	
		description = "You grow a chitinous exoskeleton, increasing your maximum health and all resistances.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				maxHp: 10 * level,
				kinRes: level,
				fireRes: level,
				chemRes: level,
				elecRes: level,
				radRes: level
	
			};
	
		}
	
	}
	
	function skill_collagenReinforcement() : skill() constructor {

		name = "Collagen Reinforcement";
		key = "collagenReinforcement";
		icon = spr_icon_collagen;
		maxLevel = 5;
		
		levelReq = 10;
	
		description = "Modify collagen fibres to increase tissue strength.\nIncreases melee resistance.";
	
		static setupFunc = function(source) {
	
			passives = {
	
				meleeRes: level * 4
	
			};
	
		}
	
	}
	
	function skill_adrenalGlands() : skill() constructor {

		name = "Enlarged Adrenal Glands";
		key = "adrenalGlands";
		icon = spr_icon_adrenalGlands;
		maxLevel = 8;
	
		description = "Your adrenal glands produce more adrenaline and cortisole.";
		description += "\nThe first point gives you +1 dash charge. Each subsequent";
		description += "\npoint increases dash recharge speed.";
		
		static setupFunc = function(source) {
	
			passives = {
	
				maxDashes: 1,
				//dashRegen: 0.02 + 0.02 * level
	
			};
	
			if (level > 1) passives.dashRegen = 0.03 * (level - 1);
	
		}
	
	}
	
	function skill_homeostasis() : skill() constructor {

		name = "Enhanced Homeostasis";
		key = "homeostasis";
		icon = spr_icon_enhancedHomeostasis;
		maxLevel = 10;
	
		description = "Implanted bioengineered cells improve your maximum health\nand health regeneration";
	
		static setupFunc = function(source) {
	
			passives = {
	
				maxHpPerc : 5 * level,
				hpRegen: 0.25 * level
	
			};
	
		}
	
	}
	
	function skill_radiotrophy() : skill() constructor {

		name = "Radiotrophic Cells";
		key = "radiotrophy";
		icon = spr_icon_radiotrophy;
		maxLevel = 6;
		
		levelReq = 5;
		
		recharge = 4;
		
		description = "Your cells absorb ionizing radiation and convert it into energy.";
		description += "\nYou gain radiation resistance, and when you take radiation damage";
		description += "\nyou recharge energy points.";
		
		
		static formatStatsDescription = function() {
		
			statsDescription = "Recharge Maximum: " + string(recharge);
		
		}
		
		static setupFunc = function(source) {
	
			recharge = level;
			
			passives = {
			
				radRes: 2 + level
			
			}
	
		}
		
		static extraEffects = function(source) {
		
			var func = function(char) {
				
				if (char.hp < char.prevHp) {
					
					if (!is_struct(char.mostRecentDamage)) exit;
					
					var radDam = char.mostRecentDamage.rad;
					
					if (radDam < 1) exit;
					
					var sk = scr_skills_findCharSkill("radiotrophy", char);
					
					if (!is_struct(sk)) exit;
					
					var rechargeAmount = min(sk.recharge, radDam);
					
					scr_char_rechargeEnergy(char, rechargeAmount);
					
				}
				
			}
			
			scr_char_addConstantFunc(source, func);
		
		}
	
	}

	#endregion

	#region engineering

	function skill_targetingMonocle() : skill() constructor {

		name = "Targeting Monocle";
		key = "targetingMonocle";

		icon = spr_icon_targetingMonocle;
		txtCol = c_white;
		maxLevel = 8;
		
		description = "An augmented reality monocle highlights enemy weak points";
		description += "\nimproving the precision of your attacks."
	
		static setupFunc = function(source) {
	
			passives = {
	
				oa: 4 + (level - 1) * 3
	
			};
	
		}
	
	}

	function skill_rubberBoots() : skill() constructor {

		name = "Rubber Boots";
		key = "rubberBoots";
		icon = spr_icon_rubberBoots;
		maxLevel = 4;
		txtCol = c_black;
	
		description = "Increases your electric resistance.";
	
		passives = {
	
			elecRes: 4
	
		};
	
		static setupFunc = function(source) {
	
			passives = {
	
				elecRes: 4 * level
	
			};
	
		}
	
	}

	function skill_kevlar() : skill() constructor {

		name = "Kevlar";
		key = "kevlar";
		icon = spr_icon_kevlar;
		maxLevel = 5;
	
		description = "Increases your kinetic resistance.\nWhen fully upgraded, increases your projectile resistance";
	
		passives = {
	
			kinRes: 4 * level
	
		};
	
		static setupFunc = function(source) {
	
			passives = {
	
				kinRes: min(4 * level, 16)
	
			};
			
			if (level == maxLevel) passives.projRes = 15;
	
		}
	
	}

	function skill_gunsmith() : skill() constructor {

		name = "Gunsmith";
		key = "gunsmith";
		icon = spr_icon_gunsmith;
		maxLevel = 6;
		
		levelReq = 5;
	
		description = "Modify your guns so that they deal more damage.";
	
		passives = {
	
			gunDamPerc: 5
	
		};
	
		static setupFunc = function(source) {
	
			passives = {
	
				gunDamPerc: 5 + (level -1) * 4
	
			};
	
		}
	
	}

	function skill_guardianArray() : skill() constructor {

		name = "Guardian Array";
		key = "guardianArray";
		icon = spr_icon_guardianArray;
		petShields = 1;
		maxLevel = 3;
		levelReq = 5;

		description = "Your summons get a shield.";
	
		static formatStatsDescription = function() {
	
			statsDescription = "Summon Shield Points: " + string(petShields);
	
		}
	
		static setupFunc = function(source) {
	
			petShields = level;
	
		}
	
	}
	
	function skill_shieldBattery() : skill() constructor {

		name = "Shield Battery";
		key = "shieldBattery";
		icon = spr_icon_shieldBattery;
		maxLevel = 6;
		levelReq = 5;


		description = "The first point grants you +1 shield point.";
		description += "\nEach subsequent point decreases shield regen delay\nand increases shield regen rate.";
	
		static setupFunc = function(source) {
	
			passives = {
			
				maxShield: 1,


			};
	
			if (level > 1) {
			
				passives.shieldRegenDelay = -0.1 * (level - 1);
				passives.shieldRegen = 0.05 * (level -1);
			
			}
	
		}
	
	}
		
	function skill_incendiaryBullets() : skill() constructor {

		name = "Incendiary Weapons";
		key = "incendiaryBullets";
		icon = spr_icon_incendiaryBullets;
		maxLevel = 6;
		levelReq = 10;
		
		chance = 3;
		damage = undefined;
		radius = 100;
		life = 4;
		fireDam = 1;
	
		description = "Your projectiles and melee attacks deal extra fire damage and\n";
		description += "have a chance of creating burning ground where they collide.";
		
		static formatStatsDescription = function() {

			statsDescription = "Burning Ground Chance: " + string(chance) + "%";
			statsDescription += "\nBurning Ground Radius: " + string(radius);
			statsDescription += "\nBurning Ground Duration: " + string(life) +" seconds";
			statsDescription += "\nBurning Ground Damage: " + string(damage.fire * 2) + " fire p/s";
		
		}
		
		static extraEffects = function(source) {
			
			var func = scr_effects_incendiaryBullet;
			
			scr_char_addBulletFunc(source, func);
			scr_char_addMeleeFunc(source, func);
			
		}
		
		static setupFunc = function(source) {
	
			chance = level * 2;
	
			radius = 80 + level * 4;
			life = 4;
		
			damage = new damageProfile();
		
			damage.fire = 8 + (level - 1) * 4;
			
			var damKeys = ["fire"];
			
			var napalm = scr_skills_findCharSkill("napalm", source);
			
			if (napalm != undefined) {
				
				damage.chem = napalm.chemDam;
				array_push(damKeys, "chem");
				
			}
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
			
			passives = {
		
				fireDam: level
		
			}
	
		}
	
	}
	
	function skill_electricBullets() : skill() constructor {

		name = "Electric Weapons";
		key = "electricBullets";
		icon = spr_icon_electricBullets;
		maxLevel = 6;
		levelReq = 10;
		
		chance = 3;
		damage = undefined;
		targets = 3;
	
		description = "Your projectiles and melee attacks deal extra electric damage and\n";
		description += "have a chance of shocking nearby enemies.";
		
		static formatStatsDescription = function() {

			statsDescription = "Shock Chance: " + string(chance) + "%";
			statsDescription += "\nShock Damage: " + string(damage.elec * 2) + " electrical";
			statsDescription += "\nTargets: " + string(targets);
			
		}
		
		static extraEffects = function(source) {
			
			var func = scr_effects_electricBullet;
			
			scr_char_addBulletFunc(source, func);
			scr_char_addMeleeFunc(source, func);
			
		}
		
		static setupFunc = function(source) {
	
			chance = level * 2;
			targets = 2 + level;
		
			damage = new damageProfile();
		
			damage.elec = 6 + (level - 1) * 3;
			
			var damKeys = ["elec"];
			
			damage = scr_stats_calculateSkillDamage(source, damage, damKeys);
			
			passives = {
		
				elecDam: level
		
			}
	
		}
	
	}
	
	#endregion

#endregion