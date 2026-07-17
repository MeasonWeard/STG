if (instance_exists(stashController)) {

	if (type == itemTypes.gear) {

		item = stashController.equippedGear[$ slotKey];

	
	} else if (type == itemTypes.weapon) {

		item = stashController.equippedWeapons[$ slotKey];

	}

}