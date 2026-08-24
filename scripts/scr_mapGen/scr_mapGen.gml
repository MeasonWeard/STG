function scr_mapGen_randomStartingLocation(mapW, mapH, pad, avoidCorners) {

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
			
			miniMap[i][j] = {
				cleared: false,
				col: c_black
			}
			
			if (is_undefined(cell) or !is_struct(cell)) continue;
			
			if (!showAll and !cell.discovered) continue;
			
			var col = cell.cleared ? c_grey : cell.mapCol;
			
			miniMap[i][j] = {
				cleared: cell.cleared,
				col: col
			}
		
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
	newCell.smashables = [];
	
	return newCell;
	
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

function scr_mapGen_makeFurthestEndCellEmpty(
	map,
	startX,
	startY,
	stages
) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);

	var stageCount = array_length(stages);

	if (stageCount <= 0) {
		return {
			success: false,
			xx: startX,
			yy: startY
		};
	}

	var dirs = [
		[-1, 0],
		[1, 0],
		[0, -1],
		[0, 1]
	];

	var visited = array_create(mapW);

	for (var i = 0; i < mapW; i++) {
		visited[i] = array_create(mapH, false);
	}

	var queue = [];
	var queueIndex = 0;

	array_push(queue, {
		xx: startX,
		yy: startY,
		dist: 0
	});

	visited[startX][startY] = true;

	var bestX = -1;
	var bestY = -1;
	var bestDist = -1;

	while (queueIndex < array_length(queue)) {

		var current = queue[queueIndex];
		queueIndex++;

		var cx = current.xx;
		var cy = current.yy;
		var dist = current.dist;

		for (var d = 0; d < 4; d++) {

			var nx = cx + dirs[d][0];
			var ny = cy + dirs[d][1];

			if (nx < 0 or nx >= mapW) continue;
			if (ny < 0 or ny >= mapH) continue;

			var cell = map[nx][ny];

			// Empty neighbour = possible end cell
			if (is_undefined(cell)) {

				var candidateDist = dist + 1;

				if (candidateDist > bestDist) {
					bestDist = candidateDist;
					bestX = nx;
					bestY = ny;
				}

				continue;
			}

			// Existing map cell: continue flood fill
			if (!is_struct(cell)) continue;
			if (visited[nx][ny]) continue;

			visited[nx][ny] = true;

			array_push(queue, {
				xx: nx,
				yy: ny,
				dist: dist + 1
			});

		}

	}

	if (bestX < 0) {
		return {
			success: false,
			xx: startX,
			yy: startY
		};
	}

	var key = stages[irandom(stageCount - 1)];

	var newCell = scr_mapGen_createCell(key);
	newCell.endCell = true;
	newCell.mapCol = c_fuchsia;

	map[bestX][bestY] = newCell;

	return {
		success: true,
		xx: bestX,
		yy: bestY
	};

}

function scr_mapGen_randomWalk(map, stages, startX, startY, steps) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);
	
	var cellCount = 0;
	
	var stageCount = array_length(stages);
	
	if (stageCount <= 0) return {
		map: map,
		cellCount: cellCount
	};
	
	if (steps <= 0) return {
		map: map,
		cellCount: cellCount
	};
	
	var xx = startX;
	var yy = startY;
	
	for (var i = 0; i < steps; i++) {

		if (is_undefined(map[xx][yy])) {
	
			var rand = irandom_range(0, stageCount - 1);
			var key = stages[rand];
	
			map[xx][yy] = scr_mapGen_createCell(key);
			cellCount++;
	
		}

		if (i >= steps - 1) break;

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
			show_debug_message("random walk got stuck after " + cellCount + " cells");
			break;
		}
		
	}

	return {
		map: map,
		cellCount: cellCount
	}
	
}

function scr_mapGen_generateHallways(
	map,
	stages,
	startX,
	startY,
	mainLength,
	sideHallAmount,
	sideHallMinLength,
	sideHallMaxLength
) {

		var mapW = array_length(map);
	var mapH = array_length(map[0]);
	
	var cellCount = 0;
	var stageCount = array_length(stages);
	
	if (stageCount <= 0) {
		return {
			map: map,
			cellCount: cellCount
		};
	}
	
	// ---------------------------------------------------------
	// Pick direction away from the starting edge
	// ---------------------------------------------------------

	var distLeft   = startX;
	var distRight  = mapW - 1 - startX;
	var distTop    = startY;
	var distBottom = mapH - 1 - startY;

	var nearestDist = min(
		distLeft,
		distRight,
		distTop,
		distBottom
	);

	var dx = 0;
	var dy = 0;

	if (distLeft == nearestDist) {
		dx = 1;
	}
	else if (distRight == nearestDist) {
		dx = -1;
	}
	else if (distTop == nearestDist) {
		dy = 1;
	}
	else {
		dy = -1;
	}

	var hallCells = [];

	// ---------------------------------------------------------
	// Generate main hallway
	// ---------------------------------------------------------

	var xx = startX;
	var yy = startY;

	for (var i = 0; i < mainLength; i++) {

		if (xx < 0 or xx >= mapW) break;
		if (yy < 0 or yy >= mapH) break;

		if (!is_undefined(map[xx][yy])) break;

		var key = stages[irandom(stageCount - 1)];
		map[xx][yy] = scr_mapGen_createCell(key);

		array_push(hallCells, {
			xx: xx,
			yy: yy
		});
		
		cellCount++;

		xx += dx;
		yy += dy;

	}

	var hallCount = array_length(hallCells);
	
	if (hallCount <= 0) {
		return {
			map: map,
			cellCount: cellCount
		};
	}

	// Perpendicular directions relative to the main hall
	var sideDX1 = dy;
	var sideDY1 = -dx;

	var sideDX2 = -dy;
	var sideDY2 = dx;

	// Main-hall indices already used for side halls
	var usedSideIndices = [];
	var maxTries = 42;

	// ---------------------------------------------------------
	// Generate side halls
	// ---------------------------------------------------------

	for (var h = 0; h < sideHallAmount; h++) {

		var placed = false;
		var tries = 0;

		while (!placed and tries < maxTries) {

			tries++;

			var index = irandom(hallCount - 1);

			// Require at least one main-hall cell between side halls
			var tooClose = false;

			for (var u = 0; u < array_length(usedSideIndices); u++) {

				if (abs(index - usedSideIndices[u]) <= 1) {
					tooClose = true;
					break;
				}

			}

			if (tooClose) continue;

			var cell = hallCells[index];

			var sideLength = irandom_range(
				sideHallMinLength,
				sideHallMaxLength
			);

			var useFirstSide = choose(true, false);

			var sideDX = useFirstSide ? sideDX1 : sideDX2;
			var sideDY = useFirstSide ? sideDY1 : sideDY2;

			var sx = cell.xx + sideDX;
			var sy = cell.yy + sideDY;

			// First side-hall cell must be valid
			if (sx < 0 or sx >= mapW) continue;
			if (sy < 0 or sy >= mapH) continue;
			if (!is_undefined(map[sx][sy])) continue;

			var placedCells = 0;

			for (var j = 0; j < sideLength; j++) {

				if (sx < 0 or sx >= mapW) break;
				if (sy < 0 or sy >= mapH) break;

				if (!is_undefined(map[sx][sy])) break;

				var key = stages[irandom(stageCount - 1)];
				map[sx][sy] = scr_mapGen_createCell(key);
				
				cellCount++;
				placedCells++;

				sx += sideDX;
				sy += sideDY;

			}

			if (placedCells > 0) {

				array_push(usedSideIndices, index);
				placed = true;

			}

		}

		if (!placed) {
			show_debug_message(
				"side hallway generation failed after "
				+ string(maxTries)
				+ " tries"
			);
		}

	}

	return {
		map: map,
		cellCount: cellCount
	};
	
}

function scr_mapGen_addSideRooms(
	map,
	stages,
	amount
) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);
	
	var maxTries = 42;
	
	var cellCount = 0;
	var stageCount = array_length(stages);
	
	if (stageCount <= 0 or amount <= 0) {
		return {
			map: map,
			cellCount: cellCount
		};
	}
	
	for (var i = 0; i < amount; i++) {
		
		var placed = false;
		var tries = 0;
		
		while (!placed and tries < maxTries) {
			
			tries++;
			
			var xx = irandom(mapW - 1);
			var yy = irandom(mapH - 1);
			
			// Candidate cell must be empty
			if (!is_undefined(map[xx][yy])) continue;
			
			var neighbourCount = 0;
			
			// Left
			if (xx > 0) {
				if (!is_undefined(map[xx - 1][yy])) {
					neighbourCount++;
				}
			}
			
			// Right
			if (xx < mapW - 1) {
				if (!is_undefined(map[xx + 1][yy])) {
					neighbourCount++;
				}
			}
			
			// Above
			if (yy > 0) {
				if (!is_undefined(map[xx][yy - 1])) {
					neighbourCount++;
				}
			}
			
			// Below
			if (yy < mapH - 1) {
				if (!is_undefined(map[xx][yy + 1])) {
					neighbourCount++;
				}
			}
			
			// Must connect to exactly one existing cell
			if (neighbourCount != 1) continue;
			
			var key = stages[irandom(stageCount - 1)];
			map[xx][yy] = scr_mapGen_createCell(key);
			
			cellCount++;
			placed = true;
			
		}
		
		if (!placed) {
			show_debug_message(
				"side room generation failed after "
				+ string(maxTries)
				+ " tries"
			);
		}
		
	}
	
	return {
		map: map,
		cellCount: cellCount
	};
	
}

function scr_mapGen_replaceRooms(
	map,
	stages,
	amount,
	type = undefined
) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);

	var maxTries = 42;

	var roomCount = 0;
	var stageCount = array_length(stages);

	if (stageCount <= 0 or amount <= 0) {
		return {
			map: map,
			roomCount: roomCount
		};
	}

	for (var i = 0; i < amount; i++) {

		var replaced = false;
		var tries = 0;

		while (!replaced and tries < maxTries) {

			tries++;

			var xx = irandom(mapW - 1);
			var yy = irandom(mapH - 1);

			// Must already contain a room
			if (is_undefined(map[xx][yy])) continue;
			
			if (type != undefined) {
				if (map[xx][yy].type != type) continue;	
			}

			var key = stages[irandom(stageCount - 1)];
			map[xx][yy] = scr_mapGen_createCell(key);

			roomCount++;
			replaced = true;

		}

		if (!replaced) {
			show_debug_message(
				"room replacement failed after "
				+ string(maxTries)
				+ " tries"
			);
		}

	}

	return {
		map: map,
		roomCount: roomCount
	};

}

function scr_mapGen_generateRing(
	map,
	stages,
	startPos,
	ringW,
	ringH
) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);
	
	var stageCount = array_length(stages);
	
	var cellCount = 0;
	var ringCells = [];
	
	if (stageCount <= 0) {
		return {
			map: map,
			cellCount: 0,
			ringCells: ringCells,
			success: false
		};
	}
	
	var startX = startPos.xx;
	var startY = startPos.yy;
	var side = startPos.side;
	
	// Direction from map edge toward centre
	var dx = 0;
	var dy = 0;
	
	switch (side) {
		
		case "left":
			dx = 1;
		break;
		
		case "right":
			dx = -1;
		break;
		
		case "top":
			dy = 1;
		break;
		
		case "bottom":
			dy = -1;
		break;
		
	}
	
	
	// ---------------------------------------------------------
	// Entrance
	//
	// start -> hall -> ring
	// ---------------------------------------------------------
	
	for (var i = 0; i < 2; i++) {
		
		var xx = startX + dx * i;
		var yy = startY + dy * i;
		
		if (xx < 0 or xx >= mapW) continue;
		if (yy < 0 or yy >= mapH) continue;
		
		var key = stages[irandom(stageCount - 1)];
		map[xx][yy] = scr_mapGen_createCell(key);
		
		cellCount++;
		
	}
	
	
	// ---------------------------------------------------------
	// Work out rectangle position
	// ---------------------------------------------------------
	
	var left;
	var right;
	var top;
	var bottom;
	
	switch (side) {
		
		case "left":
			
			left = startX + 2;
			right = left + ringW - 1;
			
			top = clamp(
				startY - irandom(ringH - 1),
				0,
				mapH - ringH
			);
			
			bottom = top + ringH - 1;
			
		break;
		
		
		case "right":
			
			right = startX - 2;
			left = right - ringW + 1;
			
			top = clamp(
				startY - irandom(ringH - 1),
				0,
				mapH - ringH
			);
			
			bottom = top + ringH - 1;
			
		break;
		
		
		case "top":
			
			top = startY + 2;
			bottom = top + ringH - 1;
			
			left = clamp(
				startX - irandom(ringW - 1),
				0,
				mapW - ringW
			);
			
			right = left + ringW - 1;
			
		break;
		
		
		case "bottom":
			
			bottom = startY - 2;
			top = bottom - ringH + 1;
			
			left = clamp(
				startX - irandom(ringW - 1),
				0,
				mapW - ringW
			);
			
			right = left + ringW - 1;
			
		break;
		
	}
	
	
	// Make sure rectangle fits
	if (
		left < 0 or
		right >= mapW or
		top < 0 or
		bottom >= mapH
	) {
		
		return {
			map: map,
			cellCount: cellCount,
			ringCells: ringCells,
			success: false
		};
		
	}
	
	
	// ---------------------------------------------------------
	// Generate top and bottom
	// ---------------------------------------------------------
	
	for (var xx = left; xx <= right; xx++) {
		
		var key = stages[irandom(stageCount - 1)];
		
		map[xx][top] = scr_mapGen_createCell(key);
		
		array_push(ringCells, {
			xx: xx,
			yy: top
		});
		
		cellCount++;
		
		
		// Bottom
		key = stages[irandom(stageCount - 1)];
		
		map[xx][bottom] = scr_mapGen_createCell(key);
		
		array_push(ringCells, {
			xx: xx,
			yy: bottom
		});
		
		cellCount++;
		
	}
	
	
	// ---------------------------------------------------------
	// Generate left and right sides
	//
	// Skip corners because they were already created above
	// ---------------------------------------------------------
	
	for (var yy = top + 1; yy < bottom; yy++) {
		
		var key = stages[irandom(stageCount - 1)];
		
		map[left][yy] = scr_mapGen_createCell(key);
		
		array_push(ringCells, {
			xx: left,
			yy: yy
		});
		
		cellCount++;
		
		
		// Right
		key = stages[irandom(stageCount - 1)];
		
		map[right][yy] = scr_mapGen_createCell(key);
		
		array_push(ringCells, {
			xx: right,
			yy: yy
		});
		
		cellCount++;
		
	}
	
	
	return {
		map: map,
		cellCount: cellCount,
		ringCells: ringCells,
		//left: left,
		//right: right,
		//top: top,
		//bottom: bottom,
		success: true
	};
	
}

function scr_mapGen_addRingSideRooms(
	map,
	stages,
	ringCells,
	amount
) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);
	
	var stageCount = array_length(stages);
	var cellCount = 0;
	var candidates = [];
	var rejected = [];
	
	if (stageCount <= 0 or amount <= 0) {
		return {
			map: map,
			cellCount: cellCount
		};
	}
	
	var dirs = [
		[-1, 0],
		[1, 0],
		[0, -1],
		[0, 1]
	];
	
	
	// ---------------------------------------------------------
	// Find possible side-room positions
	// ---------------------------------------------------------
	
	var ringLen = array_length(ringCells);
	
	for (var i = 0; i < ringLen; i++) {
		
		var ring = ringCells[i];
		
		for (var d = 0; d < 4; d++) {
			
			var xx = ring.xx + dirs[d][0];
			var yy = ring.yy + dirs[d][1];
			
			if (xx < 0 or xx >= mapW) continue;
			if (yy < 0 or yy >= mapH) continue;
			
			if (!is_undefined(map[xx][yy])) continue;
			
			
			// Avoid duplicate positions
			var duplicate = false;
			
			for (var j = 0; j < array_length(candidates); j++) {
				
				if (
					candidates[j].xx == xx
					and candidates[j].yy == yy
				) {
					duplicate = true;
					break;
				}
				
			}
			
			if (duplicate) continue;
			
			array_push(candidates, {
				xx: xx,
				yy: yy,
				ringX: ring.xx,
				ringY: ring.yy
			});
			
		}
		
	}
	
	
	// ---------------------------------------------------------
	// First pass: obey adjacency rule
	// ---------------------------------------------------------
	
	while (
		cellCount < amount
		and array_length(candidates) > 0
	) {
		
		var index = irandom(array_length(candidates) - 1);
		var candidate = candidates[index];
		
		array_delete(candidates, index, 1);
		
		var xx = candidate.xx;
		var yy = candidate.yy;
		
		if (!is_undefined(map[xx][yy])) continue;
		
		var valid = true;
		
		for (var d = 0; d < 4; d++) {
			
			var nx = xx + dirs[d][0];
			var ny = yy + dirs[d][1];
			
			if (nx < 0 or nx >= mapW) continue;
			if (ny < 0 or ny >= mapH) continue;
			
			if (is_undefined(map[nx][ny])) continue;
			
			// The ring cell this room connects to is allowed
			if (
				nx == candidate.ringX
				and ny == candidate.ringY
			) {
				continue;
			}
			
			valid = false;
			break;
			
		}
		
		if (!valid) {
			array_push(rejected, candidate);
			continue;
		}
		
		var key = stages[irandom(stageCount - 1)];
		map[xx][yy] = scr_mapGen_createCell(key);
		
		cellCount++;
		
	}
	
	
	// ---------------------------------------------------------
	// Second pass: ignore adjacency rule if necessary
	// ---------------------------------------------------------
	
	while (
		cellCount < amount
		and array_length(rejected) > 0
	) {
		
		var index = irandom(array_length(rejected) - 1);
		var candidate = rejected[index];
		
		array_delete(rejected, index, 1);
		
		var xx = candidate.xx;
		var yy = candidate.yy;
		
		// May have become occupied during first pass
		if (!is_undefined(map[xx][yy])) continue;
		
		var key = stages[irandom(stageCount - 1)];
		map[xx][yy] = scr_mapGen_createCell(key);
		
		cellCount++;
		
	}
	
	
	return {
		map: map,
		cellCount: cellCount
	};
	
}

function scr_mapGen_addRingSideRoomsSet(
	map,
	stages,
	ringCells
) {

	var mapW = array_length(map);
	var mapH = array_length(map[0]);

	var stageCount = array_length(stages);
	var cellCount = 0;
	var candidates = [];

	if (stageCount <= 0) {
		return {
			map: map,
			cellCount: cellCount
		};
	}

	var dirs = [
		[-1, 0],
		[1, 0],
		[0, -1],
		[0, 1]
	];

	// ---------------------------------------------------------
	// Find possible side-room positions
	// ---------------------------------------------------------

	var ringLen = array_length(ringCells);

	for (var i = 0; i < ringLen; i++) {

		var ring = ringCells[i];

		for (var d = 0; d < 4; d++) {

			var xx = ring.xx + dirs[d][0];
			var yy = ring.yy + dirs[d][1];

			if (xx < 0 or xx >= mapW) continue;
			if (yy < 0 or yy >= mapH) continue;

			if (!is_undefined(map[xx][yy])) continue;

			// Avoid duplicate positions
			var duplicate = false;

			for (var j = 0; j < array_length(candidates); j++) {

				if (
					candidates[j].xx == xx
					and candidates[j].yy == yy
				) {
					duplicate = true;
					break;
				}
			}

			if (duplicate) continue;

			array_push(candidates, {
				xx: xx,
				yy: yy,
				ringX: ring.xx,
				ringY: ring.yy
			});
		}
	}

	// Keep every possible position for fallback
	var fallbackCandidates = [];
	array_copy(fallbackCandidates, 0, candidates, 0, array_length(candidates));

	var stageIndex = 0;

	// ---------------------------------------------------------
	// First pass: obey adjacency rule
	// ---------------------------------------------------------

	while (
		stageIndex < stageCount
		and array_length(candidates) > 0
	) {

		var index = irandom(array_length(candidates) - 1);
		var candidate = candidates[index];

		array_delete(candidates, index, 1);

		var xx = candidate.xx;
		var yy = candidate.yy;

		if (!is_undefined(map[xx][yy])) continue;

		var valid = true;

		for (var d = 0; d < 4; d++) {

			var nx = xx + dirs[d][0];
			var ny = yy + dirs[d][1];

			if (nx < 0 or nx >= mapW) continue;
			if (ny < 0 or ny >= mapH) continue;

			if (is_undefined(map[nx][ny])) continue;

			// Ring cell this room connects to is allowed
			if (
				nx == candidate.ringX
				and ny == candidate.ringY
			) {
				continue;
			}

			valid = false;
			break;
		}

		if (!valid) continue;

		map[xx][yy] = scr_mapGen_createCell(stages[stageIndex]);

		stageIndex++;
		cellCount++;
	}

	// ---------------------------------------------------------
	// Second pass: completely ignore adjacency rule
	// ---------------------------------------------------------

	if (stageIndex < stageCount) {

		fallbackCandidates = array_shuffle(fallbackCandidates);

		var fallbackLen = array_length(fallbackCandidates);

		for (var i = 0; i < fallbackLen; i++) {

			if (stageIndex >= stageCount) break;

			var candidate = fallbackCandidates[i];

			var xx = candidate.xx;
			var yy = candidate.yy;

			// Already occupied by a room from first pass
			if (!is_undefined(map[xx][yy])) continue;

			map[xx][yy] = scr_mapGen_createCell(stages[stageIndex]);

			stageIndex++;
			cellCount++;
		}
	}

	return {
		map: map,
		cellCount: cellCount
	};
}