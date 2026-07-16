if (instance_exists(stashController)) {

	if (type == "gear") {

		var item = stashController.gear[$ slotKey];
	
	} else if (type == "weapon") {

		var item = stashController.weapons[$ slotKey];
	
	}

}