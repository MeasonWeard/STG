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
	
	char.hurt = true;
	char.hurtTick = char.hurtCooldown;
	
	//randomise damage
	var kin = damage.kin > 0 ? irandom_range(damage.kinMin, damage.kinMax) : 0;
	var fire = damage.fire > 0 ? irandom_range(damage.fireMin, damage.fireMax) : 0;
	var chem = damage.chem > 0 ?irandom_range(damage.chemMin, damage.chemMax) : 0;
	var elec = damage.elec > 0 ?irandom_range(damage.elecMin, damage.elecMax) : 0;
	var rad = damage.rad > 0 ? irandom_range(damage.radMin, damage.radMax) : 0;
	
	//apply resistances
	if (kin > 0 and char.finalStats.kinRes > 0) {
		var res = irandom_range(char.finalStats.kinResMin, char.finalStats.kinResMax);
		kin = max(1, kin - res);
		totalRes += res;
	}
	
	if (fire > 0 and char.finalStats.fireRes > 0) {
		var res = irandom_range(char.finalStats.fireResMin, char.finalStats.fireResMax);
		fire = max(1, fire - res);
		totalRes += res;
	}
	
	if (chem > 0 and char.finalStats.chemRes > 0) {
		var res = irandom_range(char.finalStats.chemResMin, char.finalStats.chemResMax);
		chem = max(1, chem - res);
		totalRes += res;
	}
	
	if (elec > 0 and char.finalStats.elecRes > 0) {
		var res = irandom_range(char.finalStats.elecResMin, char.finalStats.elecResMax);
		elec = max(1, elec - res);
		totalRes += res;
	}
	
	if (rad > 0 and char.finalStats.radRes > 0) {
		var res = irandom_range(char.finalStats.radResMin, char.finalStats.radResMax);
		rad = max(1, rad - res);
		totalRes += res;
	}
	
	//final
	var totalDam = kin + fire + chem + elec + rad;
	if (hitOutcome != 1) totalDam = max(floor(totalDam * hitOutcome), 1);
	
	if (!ignoreShield and char.shield > 0) {
	
		char.shield -= 1;
		return 0;
	
	}
	
	var lost = min(char.hp, totalDam);
	
	char.hp = max(char.hp - totalDam, 0);
	
	//damage numbers
	scr_ui_damageNumbers(totalDam, char, hitOutcome);
	
	return lost;
	
}

function scr_char_heal(char, amount) {

	if (!instance_exists(char)) return 0;
	
	var missing = char.maxHp - char.hp;
	
	char.hp = min(char.hp + amount, char.maxHp);
	
	var healed = min(amount, missing);
	
	scr_ui_damageNumbers(-healed, char);
	
	return healed;
	
}

function scr_char_rechargeEnergy(char, amount) {

	if (!instance_exists(char)) return 0;
	
	var missing = char.maxEnergy - char.energy;
	
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

function scr_char_spawnPet(obj, source, life, xx, yy, maxSpawns, faction = undefined, cloneGear = true) {
	
	if (!asset_get_type(obj) == asset_object) return noone;
	
	var inst = instance_create_layer(xx, yy, "Instances", obj);
	
	//avoid spawning at envs
	var found = false;
	var inc = 0;

	while (!found and inc < 8) {

		var minDist = inc * 32 + 8;
		var maxDist = minDist + 40;

		for (var tries = 0; tries < 12; tries++) {

			var pt = scr_randomPointInCircleMinDist(
				xx,
				yy,
				maxDist,
				minDist
			);

			var blocked = false;

			var nearby = scr_hash_getNearby(
				global.stageController.envHash,
				pt.xx,
				pt.yy
			);

			var nearbyLen = array_length(nearby);

			for (var i = 0; i < nearbyLen; i++) {

				var env = nearby[i];

				if (!instance_exists(env)) continue;

				if (scr_obj_movementCollisionAt(
					inst,
					env,
					true,
					pt.xx,
					pt.yy
				)) {
					blocked = true;
					break;
				}

			}

			if (!blocked) {

				inst.x = pt.xx;
				inst.y = pt.yy;

				found = true;
				break;

			}

		}

		inc++;

	}

	if (!found) {
		instance_destroy(inst);
		return noone;
	}
	
	//set up
	if (instance_exists(source)) {
		
		inst.owner = source;
		//if (faction == undefined) faction = source.faction;
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
	
	scr_movement_updateCollisionHitBox(inst);
	scr_movement_updateMovementHitBox(inst);
	
	return inst;
	
}