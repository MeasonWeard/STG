global.debugSteps ++;

if (checkIfCleared and !hub) {

	checkIfCleared = false;
	
	if (rc.currentCell.cleared) {

		stageInProgress = false;

		with(obj_enemy) {
			dropOnDestroy = false;
			instance_destroy();
		}
		
		with(obj_destructible) {
			dropOnDestroy = false;
			instance_destroy();
		}
	
		with(obj_door) {
			
			open = true;
			var arrow = instance_create_layer(x, y, "Instances", obj_arrow);
			arrow.target = self;
			arrow.source = global.player;
			arrow.text = "EXIT";
			arrow.col = c_lime;
			
		}
	
		with(obj_spawner) {
			active = false;
		}
	
	}
	
}

if (hub and setupHub) {

	setupHub = false;
	
	with (obj_portalPad) {
	
		other.portalX = x;
		other.portalY = y + 12;
	
	}
	
	if (instance_exists(player)) {
	
		if (global.hubPosX < 0 or global.hubPosY < 0) {
			
			with (obj_portalPad) {
				powerDown = true;	
			}
			
			instance_create_layer(portalX, portalY - 12, "Instances", obj_closingPortal);
			player.x = portalX;
			player.y = portalY;
			
		} else {
			
			player.x = global.hubPosX;
			player.y = global.hubPosY;
			
		}
		
	}
	
}