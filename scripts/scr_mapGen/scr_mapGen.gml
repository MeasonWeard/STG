function scr_mapGen_randomStartingLocation(mapW, mapH, pad) {

	var maxX = mapW - 1;
	var maxY = mapH - 1;
	
	var safePadX = min(pad, maxX div 2);
	var safePadY = min(pad, maxY div 2);

	var xx = 0;
	var yy = 0;
	
	var side = choose("left", "right", "top", "bottom");
	
	if (side == "top") {
	
		xx = irandom_range(safePadX, maxX - safePadX);
		
	}
	
	if (side == "bottom") {
	
		yy = maxY;
		xx = irandom_range(safePadX, maxX - safePadX);
		
	}
	
	if (side == "left") {
	
		yy = irandom_range(safePadY, maxY - safePadY);
		
	}
	
	if (side == "right") {
	
		xx = maxX;
		yy = irandom_range(safePadY, maxY - safePadY);
		
	}

	return {
		side: side,
		xx: xx,
		yy: yy
	}

}

function scr_mapGen_createBlankMap(mapW, mapH) {

	var newMap = [];

	for (var i = 0; i < mapW; i++) {
	
		for (var j = 0; j < mapH; j ++) {
	
			newMap[i][j] = undefined;		
	
		}
	
	}
	
	return newMap;
	
}

function scr_mapGen_createMiniMap(map, showAll) {

	var miniMap = [];
	
	var mapW = array_length(map);
	var mapH = array_length(map[0]);
	
	for (var i = 0; i < mapW; i++) {
	
		for (var j = 0; j < mapH; j ++) {
		
			var cell = map[i][j];
			miniMap[i][j] = c_black;
			
			if (is_undefined(cell) or !is_struct(cell)) continue;
			
			if (!showAll and !cell.discovered) continue;
			
			var col = cell.cleared ? c_grey : cell.mapCol;
			miniMap[i][j] = col;
		
		}
	
	}
	
	return miniMap;
	
}

function scr_mapGen_createCell(key) {

	var newCell = scr_stages_getStageData(key);
	
	newCell.seed = scr_random_generateSeed();
	newCell.discovered = false;
	newCell.visited = false;
	newCell.cleared = false;
	newCell.endCell = false;
	
	return newCell;
	
}

function scr_mapGen_randomWalk(map, stages, startX, startY, steps) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);

	var stageCount = array_length(stages);
	if (stageCount <= 0) return map;
	if (steps <= 0) return map;

	var xx = startX;
	var yy = startY;

	for (var i = 0; i < steps; i++) {

		var rand = irandom_range(0, stageCount-1);

		var key = stages[rand];
		var newCell = scr_mapGen_createCell(key);
		
		map[xx][yy] = newCell;

		var moved = false;
		var attempts = 0;

		while (!moved and attempts < 25) {

			attempts++;

			var dir = irandom(3);

			var nx = xx;
			var ny = yy;

			if (dir == 0) ny--;
			if (dir == 1) ny++;
			if (dir == 2) nx--;
			if (dir == 3) nx++;

			if (nx < 0 or nx >= mapW) continue;
			if (ny < 0 or ny >= mapH) continue;

			if (!is_undefined(map[nx][ny])) continue;

			xx = nx;
			yy = ny;
			moved = true;
			
		}

		if (!moved) {
			show_debug_message("random walk got stuck after " + string(i + 1) + " cells");
			break;
		}
	}

	return map;
	
}

function scr_mapGen_makeFurthestEndCell(map, startX, startY, stages) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);

	var bestX = startX;
	var bestY = startY;
	var bestDist = -1;
	
	var stageCount = array_length(stages);
	var key = stages[irandom(stageCount - 1)];

	for (var i = 0; i < mapW; i++) {
	
		for (var j = 0; j < mapH; j++) {
		
			var cell = map[i][j];
			if (is_undefined(cell) or !is_struct(cell)) continue;
			
			var dx = i - startX;
			var dy = j - startY;
			var dist = dx * dx + dy * dy;
			
			if (dist > bestDist) {
				bestDist = dist;
				bestX = i;
				bestY = j;
			}
		
		}
	
	}

	if (bestDist >= 0) {
		var newCell = scr_mapGen_createCell(key);
		newCell.endCell = true;
		newCell.mapCol = c_fuchsia;
		map[bestX][bestY] = newCell;
	}

	return {
		xx: bestX,
		yy: bestY,
	};

}