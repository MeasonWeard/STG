bg = global.stageController.backgroundSprite;

if (!is_undefined(bg) and setupBg) {
	
	setupBg = false;
	
	var bgd = instance_create_layer(0, 0, "Instances", obj_bgDraw);
	bgd.spr = bg;
	bgd.skybox = global.stageController.backgroundSkybox;
	bgd.parallax = global.stageController.backgroundParallax;
	
}

if (buildWallList) {

	buildWallList = false;

	var wallObjList = [];

	with (obj_bgWall) {
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

