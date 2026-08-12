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

	var cell = scr_hash_getCellAt(xx, yy);
	
	var baseCellX = cell.xx;
	var baseCellY = cell.yy;
	
	var results = [];
	
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

function scr_hash_getInDirection(hash, xx, yy, dir, width) {

	var results = [];
	var usedKeys = [];

	var step = HASH_CELL_SIZE;
	var dist = 0;

	while (true) {

		var px = xx + lengthdir_x(dist, dir);
		var py = yy + lengthdir_y(dist, dir);

		if (px < 0 or px >= room_width or py < 0 or py >= room_height) {
			break;
		}

		var cell = scr_hash_getCellAt(px, py);

		for (var cx = cell.xx - width; cx <= cell.xx + width; cx++) {
			for (var cy = cell.yy - width; cy <= cell.yy + width; cy++) {

				var key = scr_hash_getKey(cx, cy);

				if (array_contains(usedKeys, key)) continue;
				array_push(usedKeys, key);

				if (variable_struct_exists(hash, key)) {

					var arr = hash[$ key];
					var len = array_length(arr);

					for (var i = 0; i < len; i++) {
						array_push(results, arr[i]);
					}
				}
			}
		}

		dist += step;
	}

	return results;
}

function scr_hash_getAlongLine(hash, x1, y1, x2, y2, width) {

	var results = [];
	var usedKeys = [];
	var usedInstances = [];

	width = max(0, floor(width));

	var dist = point_distance(x1, y1, x2, y2);
	var dir = point_direction(x1, y1, x2, y2);

	// Half-cell steps ensure the line does not skip a cell.
	var stepSize = HASH_CELL_SIZE * 0.5;
	var steps = max(1, ceil(dist / stepSize));

	for (var i = 0; i <= steps; i++) {

		var amount = i / steps;

		var px = lerp(x1, x2, amount);
		var py = lerp(y1, y2, amount);

		var cell = scr_hash_getCellAt(px, py);

		for (var cx = cell.xx - width; cx <= cell.xx + width; cx++) {
			for (var cy = cell.yy - width; cy <= cell.yy + width; cy++) {

				var key = scr_hash_getKey(cx, cy);

				if (array_contains(usedKeys, key)) continue;
				array_push(usedKeys, key);

				if (!variable_struct_exists(hash, key)) continue;

				var arr = hash[$ key];
				var len = array_length(arr);

				for (var j = 0; j < len; j++) {

					var inst = arr[j];

					if (!instance_exists(inst)) continue;
					if (array_contains(usedInstances, inst)) continue;

					array_push(usedInstances, inst);
					array_push(results, inst);
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

function scr_hash_getNearbyCell(hash, cellX, cellY) {

	var results = [];

	for (var cx = cellX - 1; cx <= cellX + 1; cx++) {
		for (var cy = cellY - 1; cy <= cellY + 1; cy++) {
		
			var key = scr_hash_getKey(cx, cy);
		
			if (!variable_struct_exists(hash, key)) continue;
			
			var arr = hash[$ key];
			var len = array_length(arr);
		
			for (var i = 0; i < len; i++) {
				array_push(results, arr[i]);
			}
		}
	}
	
	return results;
	
}

function scr_hash_updateCharHashKeys(inst) {

	var index = 0;

	for (var cx = inst.hashCellX - 1; cx <= inst.hashCellX + 1; cx++) {
		for (var cy = inst.hashCellY - 1; cy <= inst.hashCellY + 1; cy++) {

			inst.charHashKeys[index] = scr_hash_getKey(cx, cy);
			index++;

		}
	}
}