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
	
	if (!instance_exists(char)) return false;
	
	var col = false;	
	var sourceGhost = char.ghost;

	with (obj_ghost) {
		
		if (id == sourceGhost.id) continue;
			
		col = scr_obj_movementCollision(sourceGhost, self, true);
		if (col) break;
			
	}
	
	return col;
	
}

function scr_ai_moveGhost(inst, xx, yy) {

	if(!instance_exists(inst)) exit;

	if(!instance_exists(inst.ghost)) exit;
		
	inst.ghost.x = xx;
	inst.ghost.y = yy;
	
	scr_movement_updateMovementHitBox(inst.ghost);
	scr_movement_updateCollisionHitBox(inst.ghost);
	
}