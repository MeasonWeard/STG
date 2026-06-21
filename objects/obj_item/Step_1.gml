if (setup) {

	setup = false;
	
	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.itemHash, id, hashCellX, hashCellY);
	
}