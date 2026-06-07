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
			scr_movement_updateMovementHitBox();
		
			for (var i = 0; i < len; i++) {
			
				var env = nearby[i];
			
				if (!instance_exists(env)) continue;
				if (env.id == id) continue;
			
				if (scr_obj_movementCollision(self, env, true)) {
					
					x = prevX;

					var stepX = sign(moveX);

					while (moveX != 0) {

						x += stepX;
						scr_movement_updateMovementHitBox();

						if (scr_obj_movementCollision(self, env, true)) {
							x -= stepX;
							scr_movement_updateMovementHitBox();
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
			scr_movement_updateMovementHitBox();
		
			for (var i = 0; i < len; i++) {
			
				var env = nearby[i];
			
				if (!instance_exists(env)) continue;
				if (env.id == id) continue;
			
				if (scr_obj_movementCollision(self, env, true)) {
					
					y = prevY;

					var stepY = sign(moveY);

					while (moveY != 0) {

						y += stepY;
						scr_movement_updateMovementHitBox();

						if (scr_obj_movementCollision(self, env, true)) {
							y -= stepY;
							scr_movement_updateMovementHitBox();
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
		
		scr_movement_updateMovementHitBox();
		
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
	
		scr_movement_updateCollisionHitBox();
		scr_movement_updateMovementHitBox();
	
	}

}

function scr_movement_updateMovementHitBox() {

	movLeft = bbox_left;
	movRight = bbox_right;
	movBottom = bbox_bottom;
	movTop = bbox_bottom - (bbox_right - bbox_left) * 0.5;

}

function scr_movement_updateCollisionHitBox() {

	colRight = bbox_right - 1;
	colLeft = bbox_left;
	colCentre = (colLeft + colRight) * 0.5;
		
	colTop = bbox_top + 1;
	colBottom = bbox_bottom - 1;
	colMiddle = (colTop + colBottom) * 0.5;
	
}