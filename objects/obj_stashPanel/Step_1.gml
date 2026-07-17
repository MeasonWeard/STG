if (tabDirty) {

	tabDirty = false;
	displayedItems = variable_struct_get(inventory, tab);
	pageIndex = 0;
	
	var itemsPerPage = columns * rows;
	var itemCount = array_length(displayedItems);

	maxPages = max(ceil(itemCount / itemsPerPage), 1);
	
}