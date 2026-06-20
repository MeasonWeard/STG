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
	
	var offX = 0;
	var offY = 0;
	var px = x;
	var py = y;
	
	var oldX = ghost.x;
	var oldY = ghost.y;
	
	while (!found and inc < 24) {
	
		var newMinDist = minDist + 32 * inc;
		var newMaxDist = maxDist + 32 * inc;
		
		var dir = random(360);
		var minSq = newMinDist * newMinDist;
		var maxSq = newMaxDist * newMaxDist;
		var dist = sqrt(random_range(minSq, maxSq));
		
		offX = lengthdir_x(dist, dir);
		offY = lengthdir_y(dist, dir);
		
		px = target.x + offX;
		py = target.y + offY;
		
		scr_ai_moveGhost(self, px, py);

		var col = scr_ai_ghostOverlap(self);
		
		if (px < global.roomLeft or px > global.roomRight or py < global.roomTop or py > global.roomBottom) {
			col = true;
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
		
		scr_testSound();
		
		var dir = point_direction(target.x, target.y, x, y);
		var dist = maxDist;

		px = target.x + lengthdir_x(dist, dir);
		py = target.y + lengthdir_y(dist, dir);

		px = clamp(px, global.roomLeft, global.roomRight);
		py = clamp(py, global.roomTop, global.roomBottom);

		if (moveGhost) {
			scr_ai_moveGhost(self, px, py);
		} else {
			scr_ai_moveGhost(self, oldX, oldY);
		}

		return {
			xx: px,
			yy: py,
			fallback: true
		};
		
	}
	
	if (moveGhost) {
		scr_ai_moveGhost(self, px, py);
	} else {
		scr_ai_moveGhost(self, oldX, oldY);
	}
	
	return {
		xx: px,
		yy: py,
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
		
		if (firstShot or aim) scr_ai_aimAtTarget(char, target, char.aimRadius, char.aimBias);
			
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
	
	var pt = scr_randomPointInCircleBiased(target.x, target.colMiddle, aimRadius, aimBias);
	var xx = pt.xx;
	var yy = pt.yy;

	char.aimX = xx;
	char.aimY = yy;
	
}

function scr_ai_alertAllies(char, radius) {

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