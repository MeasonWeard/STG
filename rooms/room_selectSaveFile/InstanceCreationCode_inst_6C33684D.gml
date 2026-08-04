txt = "Delete";

constantFunc = function() {

	var mode = global.selectSaveController.mode;
	if (mode == "select") txt = "Delete";
	if (mode == "delete") txt = "Select";
	
}

leftFunc = function() {

	var mode = global.selectSaveController.mode;
	if (mode == "select") global.selectSaveController.mode = "delete";
	if (mode == "delete") global.selectSaveController.mode = "select";
	
}



