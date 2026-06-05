function scr_stages_getStageData(key) {

	static stages = global.data.stages;

	var sData = {};
	
	scr_data_structCopyInto(sData, stages.def);
	
	if (variable_struct_exists(stages, key)) {
	
		var newData = variable_struct_get(stages, key);
		
		scr_data_structCopyInto(sData, newData);
	
	}
	
	return sData;

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
		return;
	}

	if (!is_struct(data)) return;
	if (!variable_struct_exists(data, "room")) return;
	if (is_undefined(data.room)) return;

	room_goto(data.room);
	
}