event_inherited();

if (setup) {

	setup = false;
	
	//hash
	var xx = (bbox_left + bbox_right) * 0.5;
	var yy = (bbox_top + bbox_bottom) * 0.5;
	
	var cell = scr_hash_getCellAt(xx, yy);
	
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.envHash, id, hashCellX, hashCellY);
	
	if (onGround) {
		depth = layers.ground;
		projCollision = false;
	}
	
}