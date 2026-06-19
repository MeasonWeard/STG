function scr_hash_getKey(cellX, cellY) {
	return string(cellX) + "," + string(cellY);
}

function scr_hash_add(hash, inst, cellX, cellY) {
	
	var key = scr_hash_getKey(cellX, cellY);
		
	if (!variable_struct_exists(hash, key)) {
		hash[$ key] = [];
	}
	
	var arr = hash[$ key];
	
	// prevent duplicates
	if (array_contains(arr, inst)) return;
	
	array_push(arr, inst);
	
	//hash[$ key] = arr;
	
}

function scr_hash_remove(hash, inst, cellX, cellY) {
	
	var key = scr_hash_getKey(cellX, cellY);
	
	if (!variable_struct_exists(hash, key)) return;
	
	var arr = hash[$ key];
	var len = array_length(arr);
	
	for (var i = 0; i < len; i++) {
		
		if (arr[i] == inst) {
			
			array_delete(arr, i, 1);
			
			if (array_length(arr) == 0) {
				variable_struct_remove(hash, key);
			}


			
			return;
		}
		
	}

}

function scr_hash_getNearby(hash, xx, yy) {
	
	//cellSize = HASH_CELL_SIZE;
	
	var cell = scr_hash_getCellAt(xx, yy);
	
	var baseCellX = cell.xx;
	var baseCellY = cell.yy;
	
	var results = [];
	
	//TO DO: include cells diagonal to base cell?
	for (var cx = baseCellX - 1; cx <= baseCellX + 1; cx++) {
		for (var cy = baseCellY - 1; cy <= baseCellY + 1; cy++) {
		
			var key = scr_hash_getKey(cx, cy);
		
			if (variable_struct_exists(hash, key)) {
			
				var arr = hash[$ key];
				var len = array_length(arr);
			
				for (var i = 0; i < len; i++) {
					array_push(results, arr[i]);
				}
			
			}
		
		}
	}
	
	return results;
	
}

function scr_hash_getNearbyRange(hash, xx, yy, range) {
	
	var cell = scr_hash_getCellAt(xx, yy);
	
	var baseCellX = cell.xx;
	var baseCellY = cell.yy;
	
	var results = [];
	
	range = max(0, floor(range));
	
	for (var cx = baseCellX - range; cx <= baseCellX + range; cx++) {
		for (var cy = baseCellY - range; cy <= baseCellY + range; cy++) {
		
			var key = scr_hash_getKey(cx, cy);
		
			if (variable_struct_exists(hash, key)) {
			
				var arr = hash[$ key];
				var len = array_length(arr);
			
				for (var i = 0; i < len; i++) {
					array_push(results, arr[i]);
				}
			
			}
		}
	}
	
	return results;
}

function scr_hash_getCellAt(xx, yy) {

	var hashCellX = floor(xx / HASH_CELL_SIZE);
	var hashCellY = floor(yy / HASH_CELL_SIZE);
	
	return {
	
		xx: hashCellX,
		yy: hashCellY
	
	}
	
}