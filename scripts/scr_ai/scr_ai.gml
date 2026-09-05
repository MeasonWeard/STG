function scr_ai_moveTowardsPoint(targetX, targetY, moveSpd) {

	if (!is_real(targetX)) return false;
	if (!is_real(targetY)) return false;

	var dist = point_distance(x, y, targetX, targetY);

	if (dist <= moveSpd) {
		xspd = 0;
		yspd = 0;
		return true;
	}

	var dir = point_direction(x, y, targetX, targetY);

	xspd = lengthdir_x(moveSpd, dir);
	yspd = lengthdir_y(moveSpd, dir);

	return false;

}

function scr_ai_moveTowardsPointAvoid(targetX, targetY, moveSpd, avoidDist) {

	if (!is_real(targetX)) return false;
	if (!is_real(targetY)) return false;

	var dist = point_distance(x, y, targetX, targetY);

	if (dist <= moveSpd) {
		xspd = 0;
		yspd = 0;
		return true;
	}

	var dir = point_direction(x, y, targetX, targetY);

	var mx = lengthdir_x(moveSpd, dir);
	var my = lengthdir_y(moveSpd, dir);

	if (scr_timeSlicing_isMyTurn("avoid", avoidIndex)) {

		avoidX = 0;
		avoidY = 0;

		// avoid chars
		var hash = global.stageController.charHash;

		for (var k = 0; k < 9; k++) {

			var key = charHashKeys[k];

			if (!variable_struct_exists(hash, key)) continue;

			var nearby = hash[$ key];
			var len = array_length(nearby);

			for (var i = 0; i < len; i++) {

				var otherInst = nearby[i];

				if (!instance_exists(otherInst)) continue;
				if (otherInst.id == id) continue;
				if (otherInst.faction != faction) continue;

				var d = point_distance(x, y, otherInst.x, otherInst.y);

				if (d > 0 and d < avoidDist) {
					
					var away = point_direction(otherInst.x, otherInst.y, x, y);
					var strength = (avoidDist - d) / avoidDist;

					avoidX += lengthdir_x(strength, away);
					avoidY += lengthdir_y(strength, away);
					
				}
			}
		}
		
		// avoid environment
		var nearby = nearbyEnv;//scr_hash_getNearby(global.stageController.envHash, x, y);
		var len = array_length(nearby);

		for (var i = 0; i < len; i++) {

			var env = nearby[i];

			if (!instance_exists(env)) continue;

			// closest point on the env hitbox
			var closestX = clamp(x, env.colLeft, env.colRight);
			var closestY = clamp(y, env.colTop, env.colBottom);

			var d = point_distance(x, y, closestX, closestY);

			if (d < avoidDist) {

				var away = point_direction(closestX, closestY, x, y);

				var strength = (avoidDist - d) / avoidDist;

				avoidX += lengthdir_x(strength, away);
				avoidY += lengthdir_y(strength, away);

			}
		}
		
	}

	mx += avoidX * moveSpd;
	my += avoidY * moveSpd;

	var finalSpd = point_distance(0, 0, mx, my);

	if (finalSpd > moveSpd) {
		var finalDir = point_direction(0, 0, mx, my);
		mx = lengthdir_x(moveSpd, finalDir);
		my = lengthdir_y(moveSpd, finalDir);
	}

	xspd = mx;
	yspd = my;

	return false;

}

function scr_ai_choosePointAroundTarget(target, minDist, maxDist, moveGhost) {

	if (!instance_exists(target)) return undefined;
	
	var tries = 0;
	var inc = 0;
	var found = false;
	var fallback = false;
	
	var targetX = target.x;
	var targetY = target.y;
	
	var roomLeft = global.roomLeft;
	var roomRight = global.roomRight;
	var roomTop = global.roomTop;
	var roomBottom = global.roomBottom;
	
	var px = x;
	var py = y;
	
	while (!found and inc < 10) {
	
		var newMinDist = minDist + 64 * inc;
		var newMaxDist = maxDist + 64 * inc;
		
		var dir = random(360);
		var minSq = newMinDist * newMinDist;
		var maxSq = newMaxDist * newMaxDist;
		var dist = sqrt(random_range(minSq, maxSq));
		
		px = targetX + lengthdir_x(dist, dir);
		py = targetY + lengthdir_y(dist, dir);
		
		// Reject out-of-bounds points before doing the overlap check.
		if (
			px < roomLeft
			or px > roomRight
			or py < roomTop
			or py > roomBottom
		) {
			
			tries++;
			
			if (tries >= 16) {
				tries = 0;
				inc++;
			}
			
			continue;
		}
		
		if (!scr_ai_ghostOverlapAt(self, px, py)) {
			found = true;
			break;
		}
		
		tries++;
		
		if (tries >= 12) {
			tries = 0;
			inc++;
		}
		
	}
	
	if (!found) {
		
		fallback = true;
		
		var dir = point_direction(target.x, target.y, x, y);

		px = targetX + lengthdir_x(maxDist, dir);
		py = targetY + lengthdir_y(maxDist, dir);

		px = clamp(px, global.roomLeft, global.roomRight);
		py = clamp(py, global.roomTop, global.roomBottom);
		
	}
	
	if (moveGhost) {
		scr_ai_moveGhost(self, px, py);
	}

	return {
		xx: px,
		yy: py,
		fallback: fallback
	};

}

function scr_ai_ghostOverlap(char) {
	
	if (!instance_exists(char)) return false;
	if (!instance_exists(char.ghost)) return false;
	
	var sourceGhost = char.ghost;
	var hash = global.stageController.ghostHash;
	
	for (var k = 0; k < 9; k++) {
		
		var key = sourceGhost.ghostHashKeys[k];
		
		if (!variable_struct_exists(hash, key)) continue;
		
		var nearby = hash[$ key];
		var len = array_length(nearby);
		
		for (var i = 0; i < len; i++) {
		
			var targetGhost = nearby[i];
			
			if (!instance_exists(targetGhost)) continue;
			if (targetGhost.id == sourceGhost.id) continue;
			
			if (scr_obj_movementCollision(sourceGhost, targetGhost, true)) {
				return true;
			}
		
		}
	}

	return false;
	
}

function scr_ai_ghostOverlapAt(char, xx, yy, ignore = noone) {
	
	if (!instance_exists(char)) return false;
	if (!instance_exists(char.ghost)) return false;
	
	var g = char.ghost;
	
	var offsetX = xx - g.x;
	var offsetY = yy - g.y;
	
	var left   = g.colLeft   + offsetX;
	var right  = g.colRight  + offsetX;
	var top    = g.colTop    + offsetY;
	var bottom = g.colBottom + offsetY;
	
	var cellX = floor(xx / HASH_CELL_SIZE);
	var cellY = floor(yy / HASH_CELL_SIZE);
	
	var hash = global.stageController.ghostHash;
	var keys;
	
	// Candidate point is in the ghost's current hash cell.
	if (cellX == g.hashCellX and cellY == g.hashCellY) {
		
		keys = g.ghostHashKeys;
		
	} else {
		
		// Only rebuild test keys if this candidate is in a new cell
		if (cellX != g.testHashCellX or cellY != g.testHashCellY) {
		
			g.testHashCellX = cellX;
			g.testHashCellY = cellY;
		
			scr_hash_updateHashKeys(
				g.testHashKeys,
				cellX,
				cellY
			);
		
		}
	
		keys = g.testHashKeys;
		
		//keys = array_create(9);
		//scr_hash_updateHashKeys(keys, cellX, cellY);
		
	}
	
	for (var k = 0; k < 9; k++) {
		
		var key = keys[k];
		
		if (!variable_struct_exists(hash, key)) continue;
		
		var nearby = hash[$ key];
		var len = array_length(nearby);
		
		for (var i = 0; i < len; i++) {
			
			var otherGhost = nearby[i];
			
			if (!instance_exists(otherGhost)) continue;
			if (otherGhost.id == g.id) continue;
			if (instance_exists(ignore) and otherGhost.id == ignore.id) continue;
			
			if (
				right > otherGhost.colLeft
				and left < otherGhost.colRight
				and bottom > otherGhost.colTop
				and top < otherGhost.colBottom
			) {
				return true;
			}
			
		}
	}
	
	return false;
	
}

function scr_ai_moveGhost(inst, xx, yy) {

	if (!instance_exists(inst)) exit;
	if (!instance_exists(inst.ghost)) exit;
	
	var thisGhost = inst.ghost;

	var oldCellX = thisGhost.hashCellX;
	var oldCellY = thisGhost.hashCellY;

	var newCellX = floor(xx / HASH_CELL_SIZE);
	var newCellY = floor(yy / HASH_CELL_SIZE);

	var changedCell = (
		newCellX != oldCellX
		or newCellY != oldCellY
	);

	if (changedCell) {
		scr_hash_remove(
			global.stageController.ghostHash,
			thisGhost.id,
			oldCellX,
			oldCellY
		);
	}
	
	thisGhost.x = xx;
	thisGhost.y = yy;
	
	scr_movement_updateMovementHitBox(thisGhost);
	scr_movement_updateCollisionHitBox(thisGhost);

	if (changedCell) {

		thisGhost.hashCellX = newCellX;
		thisGhost.hashCellY = newCellY;

		scr_hash_add(
			global.stageController.ghostHash,
			thisGhost.id,
			newCellX,
			newCellY
		);

		scr_hash_updateHashKeys(
			thisGhost.ghostHashKeys,
			newCellX,
			newCellY
		);
	}
	
}

function scr_ai_shootAtTarget(char, target, aimOnReload) {
	
	if (!instance_exists(char)) exit;
	if (!instance_exists(target)) exit;
	if (!is_instanceof(char.equippedWeapon, gunInst)) exit;
	
	var shot = noone;
	
	if (char.shootDelayTick > 0) {
		
		char.shootDelayTick--;
		
	} else {

		var aim = false;
		var aimTurn = scr_timeSlicing_isMyTurn("aim", char.aimIndex);
		
		if (aimOnReload) {
			
			if (char.equippedWeapon.reload > 0 and aimTurn) aim = true;
			
		} else {
			
			if (aimTurn) aim = true;
			
		}
		
		if (firstShot or aim) scr_ai_aimAtTarget(char, target, char.aimAngle, char.aimBias);
			
		shot = scr_guns_shoot(char);
		
		if (firstShot and shot) firstShot = false;

	}
	
	return shot;
	
}

function scr_ai_meleeAttackTarget(char, target) {

	if (!instance_exists(char)) exit;
	if (!instance_exists(target)) exit;
	if (!is_instanceof(char.equippedWeapon, meleeInst)) exit;
	
	var att = noone;
	
	if (char.shootDelayTick > 0) {
		
		char.shootDelayTick--;
		
	} else {

		var dist = point_distance(char.x, char.y, target.x, target.y);
		aimX = target.x;
		aimY = target.y;
			
		if (dist <= meleeRange) att = scr_melee_attack(char);

	}
	
	return att;
	
}

function scr_ai_attackTarget(char, target, aimOnReload) {

	if (is_instanceof(char.equippedWeapon, gunInst)) scr_ai_shootAtTarget(char, target, aimOnReload);
	if (is_instanceof(char.equippedWeapon, meleeInst)) scr_ai_meleeAttackTarget(char, target);
	
}

function scr_ai_aimAtTarget(char, target, aimRadius, aimBias) {
	
	if (!instance_exists(char)) exit;
	if (!instance_exists(target)) exit;
	
	var targetX = target.x;
	var targetY = target.colMiddle;
	
	var targetDir = point_direction(
		char.x,
		char.y,
		targetX,
		targetY
	);
	
	var targetDist = point_distance(
		char.x,
		char.y,
		targetX,
		targetY
	);
	
	// Random angular error between -aimAngle and +aimAngle
	var angleOffset = random_range(-aimAngle, aimAngle);
	
	// Bias toward the centre.
	// Higher aimBias means more accurate shots.
	if (aimBias > 0) {
		angleOffset *= power(random(1), aimBias);
	}
	
	var aimDir = targetDir + angleOffset;
	
	char.aimX = char.x + lengthdir_x(targetDist, aimDir);
	char.aimY = char.y + lengthdir_y(targetDist, aimDir);
	
}

function scr_ai_alertAllies(char, radius) {

	//show_debug_message("alerting: " + string(global.debugFrame));
	//global.aiAlertCalls ++;

	var xx = char.x;
	var yy = char.y;
	
	var nearby = scr_hash_getNearby(global.stageController.charHash, xx, yy);
	var len = array_length(nearby);
	
	for (var i = 0; i < len; i ++) {
	
		var ally = nearby[i];
		
		if (!instance_exists(ally)) continue;
		
		if (ally.faction != char.faction) continue;
		
		if (ally.alert) continue;
		
		var dist = point_distance(xx, yy, ally.x, ally.y);
		
		if (dist > radius) continue;
		
		ally.alert = true;
		
		scr_ai_alertAllies(ally, radius);
	
	}
	
}

function scr_ai_standardAIBehaviour() {

	if (!instance_exists(target)) {

		xspd = 0;
		yspd = 0;
		exit;

	}

	// First destination pick
	if (firstGhostCheck) {

		firstGhostCheck = false;

		scr_ai_choosePointAroundTarget(
			target,
			targetMinDist,
			targetMaxDist,
			true
		);

	}
	
	var choosePoint = false;

	if (scr_timeSlicing_isMyTurn("ghostDistanceCheck", ghostDistanceIndex)) {

		var dx = ghost.x - target.x;
		var dy = ghost.y - target.y;

		var tooFar =
			dx * dx + dy * dy
			> targetReaquireDist * targetReaquireDist;

		if (tooFar) choosePoint = true;


	}

	if (!choosePoint and scr_timeSlicing_isMyTurn("ghostOverlapCheck", ghostOverlapIndex)) {

		if (scr_ai_ghostOverlap(self)) choosePoint = true;


	}

	if (choosePoint) {

		scr_ai_choosePointAroundTarget(
			target,
			targetMinDist,
			targetMaxDist,
			true
		);
		
	}

	scr_ai_moveTowardsPointAvoid(
		ghost.x,
		ghost.y,
		spd,
		avoidDist
	);

	scr_ai_attackTarget(
		self,
		target,
		aimOnReload
	);
	
}

function scr_ai_standardPetBehaviour() {

	if (scr_timeSlicing_isMyTurn("findTarget", findTargetIndex)) {
	
		if (instance_exists(target)) {
	
			var dist = point_distance(x, y, target.x, target.y);
			if (dist > reTargetDist) target = noone;
	
		}
	
		if (!instance_exists(target)) target = scr_char_getNearestToSource(self, true);
	
	}

	scr_ai_shootAtTarget(self, target, true);
	
	//
	if (instance_exists(target)) {
		scr_ai_standardAIBehaviour();
	} else {
		scr_ai_moveTowardsOwner();
	}
	
}

function scr_ai_moveTowardsOwner() {

	if (!instance_exists(owner)) exit;
	
	if (!instance_exists(ghost)) {
		ghost = instance_create_layer(x, y, "Instances", obj_ghost);	
	}

	// First destination pick
	if (firstGhostCheck) {

		firstGhostCheck = false;
		scr_ai_choosePointAroundTarget(
			owner,
			targetMinDist,
			targetMaxDist,
			true
		);

	}

	var choosePoint = false;

	// Periodically check if destination is still okay
	if (scr_timeSlicing_isMyTurn("ghostDistanceCheck", ghostDistanceIndex)) {

		var dx = ghost.x - owner.x;
		var dy = ghost.y - owner.y;

		var tooFar =
			dx * dx + dy * dy
			> targetReaquireDist * targetReaquireDist;

		if (tooFar) choosePoint = true;


	}

	if (!choosePoint and scr_timeSlicing_isMyTurn("ghostOverlapCheck", ghostOverlapIndex)) {

			if (scr_ai_ghostOverlap(self)) choosePoint = true;


	}
	
	if (choosePoint) {

		scr_ai_choosePointAroundTarget(
			owner,
			targetMinDist,
			targetMaxDist,
			true
		);
		
	}

	// Move toward ghost
	aimX = owner.x;
	aimY = owner.y;

	scr_ai_moveTowardsPointAvoid(
		ghost.x,
		ghost.y,
		spd,
		avoidDist
	);

}

function scr_ai_setup() {

	// General AI
	if (!variable_instance_exists(self, "alert")) alert = false;
	if (!variable_instance_exists(self, "firstGhostCheck")) firstGhostCheck = true;

	// Time-slicing indices
	if (!variable_instance_exists(self, "detectionIndex")) detectionIndex = -1;
	if (!variable_instance_exists(self, "ghostCheckIndex")) ghostCheckIndex = -1;
	if (!variable_instance_exists(self, "avoidIndex")) avoidIndex = -1;
	if (!variable_instance_exists(self, "aimIndex")) aimIndex = -1;

	// Targeting distances
	if (!variable_instance_exists(self, "targetMinDist")) targetMinDist = 180;
	if (!variable_instance_exists(self, "targetMaxDist")) targetMaxDist = 360;
	if (!variable_instance_exists(self, "targetReaquireDist")) targetReaquireDist = 450;

	// Detection
	if (!variable_instance_exists(self, "detectionDist")) detectionDist = 800;

	// Avoidance
	if (!variable_instance_exists(self, "avoidDist")) avoidDist = 48;
	if (!variable_instance_exists(self, "avoidX")) avoidX = 0;
	if (!variable_instance_exists(self, "avoidY")) avoidY = 0;

	// Melee
	if (!variable_instance_exists(self, "meleeRange")) meleeRange = 240;

	// Shooting
	if (!variable_instance_exists(self, "shootDelayMin")) shootDelayMin = 8;
	if (!variable_instance_exists(self, "shootDelayMax")) shootDelayMax = 16;
	if (!variable_instance_exists(self, "shootDelayTick")) shootDelayTick = 0;

	// Aiming
	if (!variable_instance_exists(self, "aimAngle")) aimAngle = 30;
	if (!variable_instance_exists(self, "aimBias")) aimBias = 1.5;
	if (!variable_instance_exists(self, "firstShot")) firstShot = true;
	if (!variable_instance_exists(self, "aimOnReload")) aimOnReload = false;
	
	if (!variable_instance_exists(self, "alertAllies")) alertAllies = true;
	
	// Assign time-slicing indices
	ghostDistanceIndex = scr_timeSlicing_assignTurnIndex("ghostDistanceCheck");
	ghostOverlapIndex = scr_timeSlicing_assignTurnIndex("ghostOverlapCheck");
	aimIndex = scr_timeSlicing_assignTurnIndex("aim");
	detectionIndex = scr_timeSlicing_assignTurnIndex("detection");
	avoidIndex = scr_timeSlicing_assignTurnIndex("avoid");

	// Randomise initial shooting delay
	shootDelayTick = irandom_range(shootDelayMin * 2, shootDelayMax * 2);
	
}