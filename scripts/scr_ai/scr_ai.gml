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
	if (!is_struct(char.gun)) exit;
	
	if (char.shootDelayTick > 0) {
		
		char.shootDelayTick--;
		
	} else {

		var aim = false;
		var aimTurn = scr_timeSlicing_isMyTurn("aim", char.aimIndex);
		
		if (aimOnReload) {
			
			if (char.gun.reload > 0 and aimTurn) aim = true;
			
		} else {
			
			if (aimTurn) aim = true;
			
		}
		
		if (firstShot or aim) scr_ai_aimAtTarget(char, target, char.aimRadius, char.aimBias);
			
		var shot = scr_guns_shoot(char);
		
		if (firstShot and shot) firstShot = false;

	}
	
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