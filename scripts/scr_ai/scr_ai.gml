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

		//avoid chars
		var nearby = scr_hash_getNearby(global.stageController.charHash, x, y);
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
		
		// avoid environment
		nearby = scr_hash_getNearby(global.stageController.envHash, x, y);
		len = array_length(nearby);

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
	
	while (!found and inc < 18) {
	
		var newMinDist = minDist + 32 * inc;
		var newMaxDist = maxDist + 32 * inc;
		
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
	
	//global.aiPointCalls++;
	//global.aiPointAttempts += inc * 16 + tries + 1;
	//global.aiPointMaxInc = max(global.aiPointMaxInc, inc);
	
	return {
		xx: px,
		yy: py,
		fallback: fallback
	};

}

function scr_ai_ghostOverlap(char) {
	
	//validate
	if (!instance_exists(char)) return false;
	if (!instance_exists(char.ghost)) return false;
	
	var col = false;	
	
	var sourceGhost = char.ghost;
	var xx = sourceGhost.x;
	var yy = sourceGhost.y;

	//hash
	//TO DO: get nearby range = 2?
	var nearby = scr_hash_getNearby(global.stageController.ghostHash, xx, yy);
	var len = array_length(nearby);
	
	for (var i = 0; i < len; i ++) {
	
		var targetGhost = nearby[i];
		
		if (!instance_exists(targetGhost)) continue;
		if (targetGhost.id == sourceGhost.id) continue;
		
		col = scr_obj_movementCollision(sourceGhost, targetGhost, true);
		if (col) break;
	
	}

	return col;
	
}

function scr_ai_ghostOverlapAt(char, xx, yy) {
	
	var g = char.ghost;
	
	var offsetX = xx - g.x;
	var offsetY = yy - g.y;
	
	var left   = g.colLeft   + offsetX;
	var right  = g.colRight  + offsetX;
	var top    = g.colTop    + offsetY;
	var bottom = g.colBottom + offsetY;
	
	//TO DO: get nearby range = 2?
	var nearby = scr_hash_getNearby(global.stageController.ghostHash, xx, yy);
	var len = array_length(nearby);
	
	for (var i = 0; i < len; i++) {
		
		var otherGhost = nearby[i];
		
		if (!instance_exists(otherGhost) or otherGhost.id == g.id) {
			continue;
		}
		
		if (
			right > otherGhost.colLeft
			and left < otherGhost.colRight
			and bottom > otherGhost.colTop
			and top < otherGhost.colBottom
		) {
			return true;
		}
	}
	
	return false;
}

function scr_ai_moveGhost(inst, xx, yy) {

	//validate
	if(!instance_exists(inst)) exit;
	if(!instance_exists(inst.ghost)) exit;
	
	var thisGhost = inst.ghost;
	
	//hash remove
	scr_hash_remove(global.stageController.ghostHash, thisGhost.id, thisGhost.hashCellX, thisGhost.hashCellY);
	
	//update position
	thisGhost.x = xx;
	thisGhost.y = yy;
	
	scr_movement_updateMovementHitBox(thisGhost);
	scr_movement_updateCollisionHitBox(thisGhost);
	
	//has add
	var cell = scr_hash_getCellAt(xx, yy);
	thisGhost.hashCellX = cell.xx;
	thisGhost.hashCellY = cell.yy;

	scr_hash_add(global.stageController.ghostHash, thisGhost.id, thisGhost.hashCellX, thisGhost.hashCellY);
	
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
		
		if (ally.alert) continue;
		
		if (ally.faction != char.faction) continue;
		
		var dist = point_distance(xx, yy, ally.x, ally.y);
		
		if (dist > radius) continue;
		
		ally.alert = true;
		
		scr_ai_alertAllies(ally, radius);
	
	}
	
}

function scr_ai_standardAIBehaviour() {

	//first destination pick
	if (firstGhostCheck) {
		
		firstGhostCheck = false;
		
		var pt = scr_ai_choosePointAroundTarget(target, targetMinDist, targetMaxDist, true);

	}

	//periodically check if destination is still okay
	if (scr_timeSlicing_isMyTurn("ghostCheck", ghostCheckIndex)) {

		var col = scr_ai_ghostOverlap(self);
		var tooFar = false;
	
		if (instance_exists(target)) {
			tooFar = point_distance(ghost.x, ghost.y, target.x, target.y) > targetReaquireDist;
		}
	
		if (col or tooFar) {
		
			var pt = scr_ai_choosePointAroundTarget(target, targetMinDist, targetMaxDist, true);
				
		}

	}

	//move toward ghost
	if (instance_exists(target)) {

		scr_ai_moveTowardsPointAvoid(ghost.x, ghost.y, spd, avoidDist);
		scr_ai_attackTarget(self, target, aimOnReload);
		//scr_ai_shootAtTarget(self, target, aimOnReload);

	} else {

		xspd = 0;
		yspd = 0;

	}
	
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

	if (aimX < x) image_xscale = -1;
	if (aimX > x) image_xscale = 1;
	
}

function scr_ai_moveTowardsOwner() {

	if (!instance_exists(owner)) exit;

	//first destination pick
	if (firstGhostCheck) {
		
		firstGhostCheck = false;
		
		var pt = scr_ai_choosePointAroundTarget(owner, targetMinDist, targetMaxDist, true);

	}

	//periodically check if destination is still okay
	if (scr_timeSlicing_isMyTurn("ghostCheck", ghostCheckIndex)) {

		var col = scr_ai_ghostOverlap(self);
		var tooFar = false;
	
		if (instance_exists(owner)) {
			tooFar = point_distance(ghost.x, ghost.y, owner.x, owner.y) > targetReaquireDist;
		}
	
		if (col or tooFar) {
		
			var pt = scr_ai_choosePointAroundTarget(owner, targetMinDist, targetMaxDist, true);
				
		}

	}

	//move toward ghost
	if (instance_exists(owner)) {

		aimX = owner.x;
		aimY = owner.y;
		scr_ai_moveTowardsPointAvoid(ghost.x, ghost.y, spd, avoidDist);

	} else {

		xspd = 0;
		yspd = 0;

	}
	
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
	
	// Assign time-slicing indices
	ghostCheckIndex = scr_timeSlicing_assignTurnIndex("ghostCheck");
	aimIndex = scr_timeSlicing_assignTurnIndex("aim");
	detectionIndex = scr_timeSlicing_assignTurnIndex("detection");
	avoidIndex = scr_timeSlicing_assignTurnIndex("avoid");

	// Randomise initial shooting delay
	shootDelayTick = irandom_range(shootDelayMin * 2, shootDelayMax * 2);
	
}