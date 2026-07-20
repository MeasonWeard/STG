function scr_stages_getStageData(key) {

	static stages = global.data.stages;

	var sData = {};
	var newData = undefined;
	
	scr_data_structCopyInto(sData, stages.def);
	
	if (is_string(key)) {
	
		if (variable_struct_exists(stages, key)) {
	
			newData = variable_struct_get(stages, key);
		
		}
	
	}
	
	var keyIsRoom = asset_get_type(key) == asset_room;
	
	if (keyIsRoom) {

		var keys = variable_struct_get_names(stages);
		var keysLen = array_length(keys);
		
		for (var i = 0; i < keysLen; i++) {
			
			var stageKey = keys[i];
			var stg = stages[$ stageKey];
			var rm = stg.room;
			
			if (rm == key) newData = stg;
			
		}

	}
	
	if (is_struct(newData)) {
		
		scr_data_structCopyInto(sData, newData);
		
	} else if (keyIsRoom) {
		
		sData.room = key;
		
	}
	
	return sData;

}

function scr_stages_isCellValid(xx, yy) {
	
	var map = global.runController.map;
	
	if (!is_array(map)) return false;
	
	var width = array_length(map);
	
	if (xx < 0 or xx >= width) return false;
	
	var height = array_length(map[xx]);
	
	if (yy < 0 or yy >= height) return false;
	
	var cell = map[xx][yy];
	
	if (!is_struct(cell)) return false;
	
	if (!variable_struct_exists(cell, "room")) return false;
	if (is_undefined(cell.room)) return false;
	
	return true;
	
}

function scr_stages_isCellInDirValid(dir) {

	var cell = scr_stages_getCellInDir(dir);
	
	if (cell == undefined) return false;
	
	return true;
	
}

function scr_stages_getCellAt(xx, yy) {
	
	var valid = scr_stages_isCellValid(xx, yy);
	
	if (!valid) return undefined;
	
	return global.runController.map[xx][yy];
	
}

function scr_stages_getCellInDir(dir) {

	var rc = global.runController;
	var map = rc.map;
	
	var xx = rc.posX;
	var yy = rc.posY;
	
	if (dir == 0 or dir == "up") yy --;
	else if (dir == 1 or dir == "right") xx ++;
	else if (dir == 2 or dir == "down") yy ++;
	else if (dir == 3 or dir == "left") xx --;
	else return undefined;
	
	var valid = scr_stages_isCellValid(xx, yy);
	
	if (!valid) return undefined;
	
	return map[xx][yy];
	
}

/// @function scr_stages_goToStage(stageRef)
/// @param {string|struct} stageRef Stage key or map cell struct.
function scr_stages_goToStage(stageRef) {

	var key;
	var data;

	if (is_string(stageRef)) {
		data = scr_stages_getStageData(stageRef);
	} else if (is_struct(stageRef) and variable_struct_exists(stageRef, "room")) {
		data = stageRef;
	} else {
		return false;
	}

	if (!is_struct(data)) return false;
	if (!variable_struct_exists(data, "room")) return false;
	if (is_undefined(data.room)) return false;

	room_goto(data.room);

	return true;
	
}

function scr_stages_discoverAdjacentCells() {

	var cell;

	cell = scr_stages_getCellInDir("left");
	if (cell != undefined) cell.discovered = true;
	
	cell = scr_stages_getCellInDir("up");
	if (cell != undefined) cell.discovered = true;
	
	cell = scr_stages_getCellInDir("right");
	if (cell != undefined) cell.discovered = true;
	
	cell = scr_stages_getCellInDir("down");
	if (cell != undefined) cell.discovered = true;
	
}

function scr_stages_moveInDir(dir) {

	var rc = global.runController;
	var xx = rc.posX;
	var yy = rc.posY;
	
	if (!scr_stages_isCellInDirValid(dir)) return false;
	
	if (dir == 0 or dir == "up") yy --;
	else if (dir == 1 or dir == "right") xx ++;
	else if (dir == 2 or dir == "down") yy ++;
	else if (dir == 3 or dir == "left") xx --;
	else return false;
	
	var cell = scr_stages_getCellAt(xx, yy);
	
	var success = scr_stages_goToStage(cell);
	
	if (success) {
		rc.posX = xx;
		rc.posY = yy;
		rc.currentCell = rc.map[xx][yy];
		scr_stages_discoverAdjacentCells();
	}
	
	return success;
	
}

function scr_stages_goToCell(xx, yy) {

	var rc = global.runController;
	
	if (!scr_stages_isCellValid(xx, yy)) return false;
	
	var cell = scr_stages_getCellAt(xx, yy);
	
	var success = scr_stages_goToStage(cell);
	
	if (success) {
		rc.posX = xx;
		rc.posY = yy;
		rc.currentCell = rc.map[xx][yy];
		scr_stages_discoverAdjacentCells();
	}
	
	return success;
	
}

function scr_stages_endRun() {

	if (instance_exists(global.player)) instance_destroy(global.player);
	
	room_goto(room_endRun);
	
}

function scr_stages_getStartingEdge() {

	if (!instance_exists(global.runController)) return undefined;

	var rc = global.runController;

	var w = rc.zoneInst.mapW;
	var h = rc.zoneInst.mapH;

	var leftDist   = rc.startX;
	var rightDist  = (w - 1) - rc.startX;
	var upDist     = rc.startY;
	var downDist   = (h - 1) - rc.startY;

	var minDist = leftDist;
	var edge = "left";

	if (rightDist < minDist) {
		minDist = rightDist;
		edge = "right";
	}

	if (upDist < minDist) {
		minDist = upDist;
		edge = "up";
	}

	if (downDist < minDist) {
		edge = "down";
	}

	return edge;

}

function scr_stages_inStartingCell() {

	if (!instance_exists(global.runController)) return false;
		
	var startX = global.runController.startX;
	var startY = global.runController.startX;
	var posX = global.runController.posX;
	var posY = global.runController.posX;
		
	return (posX == startX and posY == startY);
	
}