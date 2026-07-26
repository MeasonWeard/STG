function scr_movement(blockedByEnv) {

	var moveX = xspd;
	var moveY = yspd;

	var prevX = x;
	var prevY = y;
	
	movedThisStep = false;

	// Correct diagonal movement
	if (moveX != 0 and moveY != 0) {
	
		var factor = 0.70710678; // 1 / sqrt(2)
		
		moveX *= factor;
		moveY *= factor;
	
	}
	
	//hash
	if (blockedByEnv) {
		
		var nearby = scr_hash_getNearby(global.stageController.envHash, x, y);
		var len = array_length(nearby);
		
		//check X
		if (moveX != 0) {
			
			x += moveX;
			scr_movement_updateMovementHitBox(self);
		
			for (var i = 0; i < len; i++) {
			
				var env = nearby[i];
			
				if (!instance_exists(env)) continue;
				if (env.id == id) continue;
			
				if (scr_obj_movementCollision(self, env, true)) {
					
					var remainingX = moveX;
					var stepX = sign(remainingX);
					var testX = prevX;

					while (abs(remainingX) > 0.01) {

						var amount = min(1, abs(remainingX)) * stepX;
						var nextX = testX + amount;

						if (scr_obj_movementCollisionAt(self, env, nextX, prevY, true)) {
							break;
						}

						testX = nextX;
						remainingX -= amount;
					}

					moveX = testX - prevX;

					break;
					
				}
			
			}
		
			x = prevX;
		
		}
		
		//check Y
		if (moveY != 0) {
			
			y += moveY;
			scr_movement_updateMovementHitBox(self);
		
			for (var i = 0; i < len; i++) {
			
				var env = nearby[i];
			
				if (!instance_exists(env)) continue;
				if (env.id == id) continue;
			
				if (scr_obj_movementCollision(self, env, true)) {
					
					var remainingY = moveY;
					var stepY = sign(remainingY);
					var testY = prevY;

					while (abs(remainingY) > 0.01) {

						var amount = min(1, abs(remainingY)) * stepY;
						var nextY = testY + amount;

						if (scr_obj_movementCollisionAt(self, env, prevX, nextY, true)) {
							break;
						}

						testY = nextY;
						remainingY -= amount;
					}

					moveY = testY - prevY;

					break;

				}
			
			}
		
			y = prevY;
		
		}
		
	}

	if (confineToBounds) {
		
		x = clamp(x + moveX, global.roomLeft, global.roomRight);
		y = clamp(y + moveY, global.roomTop, global.roomBottom);
		
	} else {
		
		x += moveX;
		y += moveY;
		
	}
	
	if (x != prevX or y != prevY) movedThisStep = true;
	
	if (movedThisStep) {
	
		scr_movement_updateCollisionHitBox(self);
		scr_movement_updateMovementHitBox(self);
	
	}

}

function scr_movement_updateMovementHitBox(inst) {

	inst.movLeft = inst.bbox_left;
	inst.movRight = inst.bbox_right;
	inst.movBottom = inst.bbox_bottom;
	inst.movTop = inst.bbox_bottom - (inst.bbox_right - inst.bbox_left) * 0.5;

}

function scr_movement_updateCollisionHitBox(inst) {

	inst.colRight = inst.bbox_right - 1;
	inst.colLeft = inst.bbox_left;
	inst.colCentre = (inst.colLeft + inst.colRight) * 0.5;
		
	inst.colTop = inst.bbox_top + 1;
	inst.colBottom = inst.bbox_bottom - 1;
	inst.colMiddle = (inst.colTop + inst.colBottom) * 0.5;
	
}

function scr_movement_dash(char) {

    if (!instance_exists(char) or char.dashing or (char.xspd == 0 and char.yspd == 0) or char.dashes <= 0) exit;

    char.dash = char.dashTime;

    char.dashX = sign(char.xspd);
    char.dashY = sign(char.yspd);
	
	//if (char.dashes == char.finalStats.maxDashes) char.dashCool = char.finalStats.dashCoolTime * 60;
	char.dashes = max(0, char.dashes - 1);
	
}

function scr_movement_dashDir(char, dir) {

    if (!instance_exists(char) or char.dashing or char.dashes <= 0) exit;

    char.dash = char.dashTime;

    char.dashX = sign(lengthdir_x(1, dir));
    char.dashY = sign(lengthdir_y(1, dir));
	
	if (char.dashes == char.finalStats.maxDashes) char.dashCool = char.finalStats.dashCoolTime * 60;
	char.dashes = max(0, char.dashes - 1);

}