if (buildWallList) {

	buildWallList = false;

	var wallObjList = [];

	with (obj_wall) {
		array_push(wallObjList, id);
	}

	array_sort(wallObjList, function(a, b) {
		return a.x - b.x;
	});

	wallList = [];

	var len = array_length(wallObjList);

	for (var i = 0; i < len; i++) {
		var spr = wallObjList[i].sprite_index
		array_push(wallList, spr);
	}
	
}

