if (!active) exit;

var cell = scr_hash_getCellAt(x, y);

var newCellX = cell.xx;
var newCellY = cell.yy;

if (newCellX != hashCellX or newCellY != hashCellY) {
	
	hashCellX = newCellX;
	hashCellY = newCellY;
	
	nearbyEnv = scr_hash_getNearbyCell(
		global.stageController.envHash,
		hashCellX,
		hashCellY
	);
	
	nearbyDest = scr_hash_getNearbyCell(
		global.stageController.destHash,
		hashCellX,
		hashCellY
	);
	
	scr_hash_updateHashKeys(charHashKeys, hashCellX, hashCellY);
	
}