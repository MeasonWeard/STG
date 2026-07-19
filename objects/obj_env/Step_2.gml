event_inherited();

//hash cell
if (movedThisStep) {

	var xx = (bbox_left + bbox_right) * 0.5;
	var yy = (bbox_top + bbox_bottom) * 0.5;

	var cell = scr_hash_getCellAt(xx, yy);

	var newCellX = cell.xx;
	var newCellY = cell.yy;

	if (newCellX != hashCellX or newCellY != hashCellY) {
	
		scr_hash_remove(global.stageController.envHash, id, hashCellX, hashCellY);
	
		hashCellX = newCellX;
	    hashCellY = newCellY;
	
		scr_hash_add(global.stageController.envHash, id, hashCellX, hashCellY);
	
	}
	
}