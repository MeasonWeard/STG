function scr_timeSlicing_assignTurnIndex(key) {

	var sets = global.stageController.timeSlicing;

	if (!variable_struct_exists(sets, key)) return -1;
	
	var set = sets[$ key];
	var index = set.nextIndex;
	
	set.nextIndex++;
	if (set.nextIndex >= set.steps) set.nextIndex = 0;
	
	return index;
	
}

function scr_timeSlicing_isMyTurn(key, index) {

	var sets = global.stageController.timeSlicing;

	if (!variable_struct_exists(sets, key)) return false;
	
	var set = sets[$ key];
	var turn = set.turn;
	
	return turn == index;
	
}