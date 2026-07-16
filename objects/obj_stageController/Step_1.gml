if (checkIfCleared and !hub) {

	checkIfCleared = false;
	
	if (rc.currentCell.cleared) {

		stageInProgress = false;

		with(obj_enemy) {
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
	
	if (instance_exists(player)) {
	
		player.x = global.hubPosX;
		player.y = global.hubPosY;
		
	}
	
}