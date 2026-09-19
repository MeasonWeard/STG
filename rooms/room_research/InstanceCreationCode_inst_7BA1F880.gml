txt = "Activated: ";
font = fnt_large;

textGetter = function() {

	var total = 0;
	var activated = 0;
	
	var research = global.gameData.research;
	var categories = research.categories;
	
	var keys = variable_struct_get_names(categories);
	var len = array_length(keys);
	for (var i = 0; i < len; i++) {
	
		var key = keys[i];
		if (key == "meta") continue;
		
		total++;
		
		var cat = categories[$ key];
		if (is_string(cat.selected)) activated ++;
	
	}
	
	return "Activated:             " + string(activated) + " / " + string(total);
	
}