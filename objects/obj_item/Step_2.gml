if (x != prevX or y != prevY) {

	//hash
	var cell = scr_hash_getCellAt(x, y);
	hashCellX = cell.xx;
	hashCellY = cell.yy;

	scr_hash_add(global.stageController.itemHash, id, hashCellX, hashCellY);

}

prevX = x;
prevY = y;

depth = layers.physical - y;

if (collectDelay > 0) collectDelay --;
