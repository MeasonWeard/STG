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
					
					x = prevX;

					var stepX = sign(moveX);

					while (moveX != 0) {

						x += stepX;
						scr_movement_updateMovementHitBox(self);

						if (scr_obj_movementCollision(self, env, true)) {
							x -= stepX;
							scr_movement_updateMovementHitBox(self);
							break;
						}

						moveX -= stepX;

					}

					moveX = x - prevX;
					x = prevX;

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
					
					y = prevY;

					var stepY = sign(moveY);

					while (moveY != 0) {

						y += stepY;
						scr_movement_updateMovementHitBox(self);

						if (scr_obj_movementCollision(self, env, true)) {
							y -= stepY;
							scr_movement_updateMovementHitBox(self);
							break;
						}

						moveY -= stepY;

					}

					moveY = y - prevY;
					y = prevY;

					break;
					
				}
			
			}
		
			y = prevY;
		
		}
		
		//scr_movement_updateMovementHitBox();
		
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