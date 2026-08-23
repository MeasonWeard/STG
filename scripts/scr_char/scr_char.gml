function scr_char_isFriendly(source, target) {

	if (!instance_exists(source)) return false;
	if (!instance_exists(target)) return false;

	return source.faction == target.faction;
	
}

function scr_char_fleshExplosion(char){
	
	var spr = char.sprite_index;
	
	var w = sprite_get_width(spr) * 0.5;
	var h = sprite_get_height(spr) * 0.5;
	
	var xx = char.x;
	var yy = char.y;

	// diamond points (approx, centred on origin)
	var topX = xx;
	var topY = yy - h;

	var bottomX = xx;
	var bottomY = yy + h; //* 0.75;
	
	var midY = (bottomY + topY) * 0.5;

	var leftX = xx - w;
	var leftY = yy;

	var rightX = xx + w;
	var rightY = yy;
	
	var col = char.bloodCol;
	var force = variable_instance_exists(char, "fleshExplodeForce") ? char.fleshExplodeForce: 12;
	var particles = 10;
	var rad = 6;
	var splits = 2;
	var life = 8;
	
	var dels = [0, 1, 3, 5];
	dels = array_shuffle(dels);
	
	scr_effects_bloodSplatter(topX, midY, col, force, 15, 7, 0, life);
	
	var b1 = scr_effects_bloodSplatter(topX, topY, col, force, particles, rad, splits, life);
	var b2 = scr_effects_bloodSplatter(bottomX, bottomY, col, force, particles, rad, splits, life);
	var b3 = scr_effects_bloodSplatter(leftX, leftY, col, force, particles, rad, splits, life);
	var b4 = scr_effects_bloodSplatter(rightX, rightY, col, force, particles, rad, splits, life);

	b1.delay = dels[0];
	b2.delay = dels[1];
	b3.delay = dels[2];
	b4.delay = dels[3];

}

function scr_char_damage(char, damage, type, ignoreShield, hitOutcome = 1) {
	
	if (!instance_exists(char)) return 0;
	if (!is_struct(damage)) return 0;
	
	//randomise damage
	var kin = damage.kin > 0 ? irandom_range(damage.kinMin, damage.kinMax) : 0;
	var fire = damage.fire > 0 ? irandom_range(damage.fireMin, damage.fireMax) : 0;
	var chem = damage.chem > 0 ? irandom_range(damage.chemMin, damage.chemMax) : 0;
	var elec = damage.elec > 0 ? irandom_range(damage.elecMin, damage.elecMax) : 0;
	var rad = damage.rad > 0 ? irandom_range(damage.radMin, damage.radMax) : 0;
	
	//apply resistances
	kin = scr_char_applyResistance(kin, char.finalStats.kinRes, char.finalStats.kinResMin,
	char.finalStats.kinResMax);
	
	fire = scr_char_applyResistance(fire, char.finalStats.fireRes, char.finalStats.fireResMin,
	char.finalStats.fireResMax);
	
	chem = scr_char_applyResistance(chem, char.finalStats.chemRes, char.finalStats.chemResMin,
	char.finalStats.chemResMax);
	
	elec = scr_char_applyResistance(elec, char.finalStats.elecRes, char.finalStats.elecResMin,
	char.finalStats.elecResMax);
	
	rad = scr_char_applyResistance(rad, char.finalStats.radRes, char.finalStats.radResMin,
	char.finalStats.radResMax);
	
	//final
	var totalDam = kin + fire + chem + elec + rad;
	
	if (type == damageTypes.melee and char.finalStats.meleeRes > 0) {
		
		totalDam = scr_char_applyResistance(totalDam, char.finalStats.meleeRes, char.finalStats.meleeResMin,
		char.finalStats.meleeResMax);
		
	} else if (type == damageTypes.projectile and char.finalStats.projRes > 0) {

		totalDam = scr_char_applyResistance(totalDam, char.finalStats.projRes, char.finalStats.projResMin,
		char.finalStats.projResMax);
		
	}
	
	if (totalDam < 1) return 0;
	
	char.hurt = true;

	if (hitOutcome != 1) totalDam = max(floor(totalDam * hitOutcome), 1);
	
	if (!ignoreShield and char.shield > 0) {
		
		char.shield -= 1;
		return 0;
	
	}
	
	var lost = min(char.hp, totalDam);
	
	char.hp = max(char.hp - totalDam, 0);
		
	char.hurtTick = char.shieldRegenDelay * 60;
	
	char.mostRecentDamage = {
		kin: kin,
		fire: fire,
		chem: chem,
		elec: elec,
		rad: rad
	}
	
	//damage numbers
	scr_ui_damageNumbers(totalDam, char, hitOutcome);
	
	return lost;
	
}

function scr_char_applyResistance(amount, res, resMin, resMax) {

	if (amount <= 0 or res == 0) return amount;

	if (res > 0) {

		var reduction = irandom_range(resMin, resMax);
		amount = max(1, amount - reduction);
			
	} else {

		var increase = round(amount * (abs(res) * 0.01));
		amount += increase;

	}

	return amount;

}

function scr_char_heal(char, amount) {

	if (!instance_exists(char)) return 0;
	
	var extra = amount * (char.stats.healingPerc * 0.01);
	
	var newAmount = round(amount + extra);
	
	var missing = char.maxHp - char.hp;
	
	if (missing < 1) return 0;
	
	char.hp = min(char.hp + newAmount, char.maxHp);
	
	var healed = min(newAmount, missing);
	
	scr_ui_damageNumbers(-healed, char);
	
	return healed;
	
}

function scr_char_rechargeEnergy(char, amount) {

	if (!instance_exists(char)) return 0;
	
	var missing = char.maxEnergy - char.energy;
	
	if (missing < 1) return 0;
	
	char.energy = min(char.energy + amount, char.maxEnergy);
	
	var restored = min(amount, missing);
	
	var yy = char.y - char.sprite_height * 0.5;
	scr_ui_risingNumbers(char.x, yy, restored, c_aqua);
	
	return restored;
	
}

function scr_char_chooseSpawnPoint(inst, xx, yy, minDist, maxDist) {

	if (!instance_exists(inst)) return undefined;

	var oldX = inst.x;
	var oldY = inst.y;

	var tries = 0;
	var inc = 0;
	var found = false;

	var px = oldX;
	var py = oldY;

	while (!found and inc < 24) {

		var newMinDist = minDist + 32 * inc;
		var newMaxDist = maxDist + 32 * inc;

		var dir = random(360);
		var minSq = newMinDist * newMinDist;
		var maxSq = newMaxDist * newMaxDist;
		var dist = sqrt(random_range(minSq, maxSq));

		px = xx + lengthdir_x(dist, dir);
		py = yy + lengthdir_y(dist, dir);

		inst.x = px;
		inst.y = py;
		
		var col = false;

		if (px < global.roomLeft or px > global.roomRight ||
			py < global.roomTop  or py > global.roomBottom) {
			col = true;
		}

		if (!col) {
			
			with (obj_enemy) {
			
				col = place_meeting(x, y, inst);
				if (col) break;
				
			}
			
		}

		if (!col) {
			found = true;
			break;
		}

		tries++;

		if (tries >= 16) {
			tries = 0;
			inc++;
		}
	}

	if (!found) {

		var dir = point_direction(xx, yy, oldX, oldY);
		var dist = maxDist;

		px = xx + lengthdir_x(dist, dir);
		py = yy + lengthdir_y(dist, dir);

		px = clamp(px, global.roomLeft, global.roomRight);
		py = clamp(py, global.roomTop, global.roomBottom);

		inst.x = px;
		inst.y = py;

		return {
			xx: px,
			yy: py,
		};
		
	}

	return {
		xx: px,
		yy: py,
	};
	
}

function scr_char_spawnChar(obj, xx, yy) {

	var inst = instance_create_layer(xx, yy, "Instances", obj);
	
	scr_movement_updateCollisionHitBox(inst);
	scr_movement_updateMovementHitBox(inst);
	
	return inst;
	
}

function scr_char_getNearest(xx, yy, needsLos = false) {

	var found = noone;
	var closest = 999999999999;

	for (var range = 0; range <= 3; range++) {

		var nearby = scr_hash_getNearbyRange(global.stageController.charHash, xx, yy, range);

		var len = array_length(nearby);

		for (var i = 0; i < len; i++) {

			var char = nearby[i];

			if (!instance_exists(char)) continue;
			
			if (needsLos) {
				if (!scr_physics_hasLineOfSight(xx, yy, char.x, char.y)) continue;	
			}

			var dist = point_distance(xx, yy, char.x, char.y);

			if (dist < closest) {
				closest = dist;
				found = char;
			}
			
		}

		if (found != noone) return found;

	}

	// last resort
	with (obj_char) {

		var dist = point_distance(xx, yy, x, y);

		if (dist < closest) {
			closest = dist;
			found = id;
		}

	}

	return found;
	
}

function scr_char_getNearestToSource(source, needsLos = false, opposingFaction = true,) {

	if (!instance_exists(source)) return noone;

	var xx = source.x;
	var yy = source.y;

	var found = noone;
	var closest = 999999999999;

	for (var range = 0; range <= 3; range++) {

		var nearby = scr_hash_getNearbyRange(global.stageController.charHash, xx, yy, range);

		var len = array_length(nearby);

		for (var i = 0; i < len; i++) {

			var char = nearby[i];

			if (!instance_exists(char)) continue;
			
			if (opposingFaction and char.faction == source.faction) continue;
			
			if (needsLos) {
				if (!scr_physics_hasLineOfSight(xx, yy, char.x, char.y)) continue;	
			}

			var dist = point_distance(xx, yy, char.x, char.y);

			if (dist < closest) {
				closest = dist;
				found = char;
			}
			
		}

		if (found != noone) return found;

	}

	// last resort
	with (obj_char) {

		var dist = point_distance(xx, yy, x, y);

		if (dist < closest) {
			closest = dist;
			found = self;
		}

	}
	
	if (found.id == source.id) return noone;
	
	if (opposingFaction and found.faction == source.faction) return noone;
			
	if (needsLos) {
		if (!scr_physics_hasLineOfSight(xx, yy, found.x, found.y)) return noone;	
	}

	return found;
	
}

function scr_char_targetNearest(source, xx, yy, cellsWidth, needsLos = false, opposingFaction = true) {

	if (!instance_exists(source)) return noone;

	var coneHalf = 45
	var found = noone;
	var closest = 999999999999;

	var dir = point_direction(source.x, source.y, xx, yy);

	var nearby = scr_hash_getInDirection(
		global.stageController.charHash,
		source.x,
		source.y,
		dir,
		cellsWidth  // width around each checked cell
	);

	var len = array_length(nearby);

	for (var i = 0; i < len; i++) {

		var char = nearby[i];

		if (!instance_exists(char)) continue;
		if (char.id == source.id) continue;
		
		if (opposingFaction and char.faction == source.faction) continue;

		if (needsLos) {
			if (!scr_physics_hasLineOfSight(source.x, source.y, char.x, char.y)) continue;	
		}

		var charDir = point_direction(source.x, source.y, char.x, char.y);
		var diff = abs(angle_difference(dir, charDir));

		if (diff > coneHalf) continue;

		var dist = point_distance(source.x, source.y, char.x, char.y);

		if (dist < closest) {
			closest = dist;
			found = char;
		}
	}
	
	return found;
	
}

function scr_char_useStimPack(char) {
	
	if (!instance_exists(char)) return 0;
	
	if (char.stimPacks <= 0) return 0;
	if (char.hp >= char.maxHp) return 0;
	
	char.stimPacks--;
	
	var amount = ceil(char.maxHp * 0.5);
	
	var sp = instance_create_layer(x, y, "Instances", obj_stimPackUse);
	sp.owner = char;
	sp.heal = amount;
	
	return amount;
	
}

function scr_char_useEnergyPack(char) {
	
	if (!instance_exists(char)) return 0;
	
	if (char.energyPacks <= 0) return 0;
	if (char.energyPacks <= 0) return 0;
	if (char.energy >= char.maxEnergy) return 0;
	
	char.energyPacks--;
	
	var amount = ceil(char.maxEnergy * 0.5);
	
	var sp = instance_create_layer(x, y, "Instances", obj_energyPackUse);
	sp.owner = char;
	sp.heal = amount;
	
	return amount;
	
}

function scr_char_spawnPet(obj, source, life, xx, yy, maxSpawns, makePersistent = false, faction = undefined, cloneGear = true) {
	
	if (!asset_get_type(obj) == asset_object) return noone;
	
	var inst = instance_create_layer(xx, yy, "Instances", obj);
	
	var pt = scr_obj_findValidPlace(inst, xx, yy);
	
	if (pt == undefined) {
		instance_destroy(inst);
		return noone;
	}
	
	inst.x = pt.px;
	inst.y = pt.py;
	
	//set up
	if (instance_exists(source)) {
		
		inst.owner = source;
		faction = faction ?? source.faction;
		
	}
	
	//destroy oldest if max spawn limit is reached
	if (is_real(maxSpawns)) {
	
		var count = 0;
		var oldestSpawnTime = 999999999999999;
		var oldest = noone;
	
		with(obj) {
		
			if (self.faction == faction) {
			
				count++;
				
				if (spawnTime < oldestSpawnTime) {
				
					oldestSpawnTime = spawnTime;
					oldest = self;
				
				}
			
			}
		
		}
		
		if (count >= maxSpawns and instance_exists(oldest)) {

			oldest.hp = 0;
		
		}
	
	}
	
	inst.pet = true;
	inst.life = life;
	inst.faction = faction;
	inst.spawning = true;
	
	inst.setup = true;
	inst.setupStats = true;
	inst.setupBasics = true;
	inst.alertAllies = false;
	
	if (makePersistent) inst.persistent = true;
	
	scr_movement_updateCollisionHitBox(inst);
	scr_movement_updateMovementHitBox(inst);
	
	return inst;
	
}

function scr_char_animateLRMirror(alwaysAnimate) {

	sprite_index = sprites.right;

	if (aimX < x) image_xscale = -1;
	if (aimX > x) image_xscale = 1;
	
	if (movedThisStep or alwaysAnimate) {
		image_speed = 1	
	} else {
		image_speed = 0;
		image_index = 0;
	}
	
}


function scr_char_animateLR(alwaysAnimate) {

	if (aimX < x) sprite_index = sprites.left;
	if (aimX > x) sprite_index = sprites.right;
	
	if (movedThisStep or alwaysAnimate) {
		image_speed = 1	
	} else {
		image_speed = 0;
		image_index = 0;
	}
	
}

function scr_char_animateUPDL(alwaysAnimate) {

	var dir = point_direction(gunX, gunY, aimX, aimY);

	if (dir >= 45 and dir < 135) {
		sprite_index = sprites.up;
	}
	else if (dir >= 135 and dir < 225) {
		sprite_index = sprites.left;
	}
	else if (dir >= 225 and dir < 315) {
		sprite_index = sprites.down;
	}
	else {
		sprite_index = sprites.right;
	}
	
	if (movedThisStep or alwaysAnimate) {
		image_speed = 1	
	} else {
		image_speed = 0;
		image_index = 0;
	}
	
}

function scr_char_addBulletFunc(char, func) {

	if(!instance_exists(char)) exit;
	if(!is_callable(func)) exit;
	
	array_push(char.bulletFuncs, func);

	
}

function scr_char_addConstantFunc(char, func) {

	if(!instance_exists(char)) exit;
	if(!is_callable(func)) exit;
	
	array_push(char.constantFuncs, func);
	
}

function scr_char_hasTag(char, tag) {

	if(!instance_exists(char)) return false;
	
	var len = array_length(char.tags);
	
	if (len < 1) return false;
	
	var found = false;
	
	for (var i = 0; i < len; i++) {
		
		var thisTag = char.tags[i];
		
		if (thisTag == tag) {
			found = true;
			break;
		}
		
	}
	
	return found;
	
}

function scr_char_addStatMod(char, statKey, amount, timer, modName) {

		if (!instance_exists(char)) exit;

		if (!variable_instance_exists(char, modName)) variable_instance_set(char, modName, noone);
		
		var modVar = variable_instance_get(char, modName);
		
		if (!instance_exists(modVar)) {
			
			var statMod = instance_create_layer(x, y, "Instances", obj_statModifier);
			
			statMod.owner = char;
			statMod.statKey = statKey;
			statMod.modName = modName;
			statMod.amount = amount;
			statMod.timer = timer;

			variable_instance_set(char, modName, statMod);

		} else {
		
			modVar.timer = timer;
		
		}
			
}

function scr_char_removeAllPets() {

	with(obj_char) {

		if (!pet) continue;
		instance_destroy();
	
	}
	
}

function scr_char_levelUp(char, targetLevel) {

	if (!instance_exists(char)) exit;
	if (!is_callable(char.levelUpFunc)) exit;

	if (targetLevel > char.level) {
	
		char.setupStats = true;
		char.setAmmo = true;
		char.setupBasics = true;
		
	}

	while (char.level < targetLevel) {

		char.level++;
		char.levelUpFunc();
	
	}
	
	var skills = char.skills;
	
	if (is_instanceof(skills.skill1, skill) and is_callable(skills.skill1.setupFunc)) skills.skill1.setupFunc(char);
	if (is_instanceof(skills.skill2, skill) and is_callable(skills.skill2.setupFunc)) skills.skill2.setupFunc(char);
	if (is_instanceof(skills.skill3, skill) and is_callable(skills.skill3.setupFunc)) skills.skill3.setupFunc(char);
	if (is_instanceof(skills.skill4, skill) and is_callable(skills.skill4.setupFunc)) skills.skill4.setupFunc(char);
	
}

function scr_char_rollLevel() {
	
	var rc = global.runController;
	
	if (!instance_exists(rc)) return 10;
	
	var level = 0;
	
	if (is_array(rc.levelWeights) and array_length(rc.levelWeights) > 0) {
		
		level = scr_random_weightedPick(rc.levelWeights);
		
	} else {
	
		level = 10;
	
	}
	
	return level;
	
}

/// @function scr_char_castSkill(char, skill)
/// @description Attempts to cast one of a character's skills.
/// @param {Id.Instance} char The character casting the skill.
/// @param {Real|Struct} sk Either a skill index from 1-4, or the skill struct directly.
/// @returns {Bool} True if the skill was successfully cast, otherwise false.
function scr_char_castSkill(char, sk) {

	if (!instance_exists(char)) return false;

	sk = scr_char_getSkill(char, sk);
	
	if (is_undefined(sk)) return false;

	return sk.cast(char);
	
}

/// @function scr_char_castSkillWithWarning(char, skill, warning)
/// @description Attempts to cast one of a character's skills. Optionally delays the cast using a warning object.
/// @param {Id.Instance} char The character casting the skill.
/// @param {Real|Struct} sk Either a skill index from 1-4, or the skill struct directly.
/// @param {Id.Instance} warning Warning object used to delay the cast.
/// @returns {Bool} True if the skill was successfully cast, otherwise false.
function scr_char_castSkillWithWarning(char, sk, warning) {

	if (!instance_exists(char)) return false;

	sk = scr_char_getSkill(char, sk);
	
	if (is_undefined(sk)) return false;

	if (instance_exists(warning)) {

		// Already committed to casting.
		if (warning.active) {

			if (warning.timer > 0) {
				return false;
			}

			warning.active = false;

			return sk.cast(char);
		}

		// Don't start the warning unless the skill can actually cast.
		if (!sk.canCast(char)) return false;

		warning.active = true;
		warning.timer = warning.timerMax;

		return false;
	}

	return sk.cast(char);
	
}

function scr_char_castSkillAtDist(char, sk, targetDist, below = true, warning = noone) {

	if (!instance_exists(char)) return false;
	if (!instance_exists(char.target)) return false;
	
	sk = scr_char_getSkill(char, sk);
	
	if (is_undefined(sk)) return false;

	if (instance_exists(warning) and warning.active) {

		if (warning.timer > 0) {
			return false;
		}

		warning.active = false;

		return scr_char_castSkill(char, sk);
	}

	if (!sk.canCast(char)) return false;

	var dist = point_distance(char.x, char.y, char.target.x, char.target.y);

	var cast = false;

	if (below) {
		if (dist <= targetDist) cast = true;
	} else {
		if (dist >= targetDist) cast = true;
	}

	if (!cast) return false;

	if (instance_exists(warning)) {

		warning.active = true;
		warning.timer = warning.timerMax;

		return false;
	}

	return scr_char_castSkill(char, sk);
	
}

function scr_char_getSkill(char, sk) {

	if (!instance_exists(char)) return undefined;

	if (is_real(sk)) {

		switch(sk) {

			case 1 : sk = char.skills.skill1; break;
			case 2 : sk = char.skills.skill2; break;
			case 3 : sk = char.skills.skill3; break;
			case 4 : sk = char.skills.skill4; break;

			default : return undefined;

		}

	}

	if (!is_instanceof(sk, skill)) return undefined;
	
	return sk;
	
}