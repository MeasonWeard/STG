event_inherited();

if (setup) {

	setup = false;
	
	//hash
	if (solid) {
		
		var xx = (bbox_left + bbox_right) * 0.5;
		var yy = (bbox_top + bbox_bottom) * 0.5;
	
		var cell = scr_hash_getCellAt(xx, yy);
	
		hashCellX = cell.xx;
		hashCellY = cell.yy;

		scr_hash_add(global.stageController.envHash, id, hashCellX, hashCellY);
	
	}
	
	//smashable
	if (!global.stageController.hub and smashable) {
	
		var smashables = global.runController.currentCell.smashables;
		var len = array_length(smashables);
		
		for (var i = 0; i < len; i++) {
		
			var entry = smashables[i];
			
			if (!is_struct(entry)) continue;
			
			var obj = entry.obj;
			
			if (!obj == object_index) continue;
			
			var xx = entry.xx;
			var yy = entry.yy;
			
			if (xx == x and yy = y) {
				smashed = entry.smashed;
				prevSmashed = true;
			}
		
		}
	
	}
	
	if (onGround) {
		depth = layers.ground;
		projCollision = false;
	}
	
}