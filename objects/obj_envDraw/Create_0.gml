rc = scr_data_getRunController();

seed = instance_exists(rc) ? rc.currentCell.seed : 0;

wallWidth = 256;
wallHeight = 128;
wallsAmount = floor(room_width / wallWidth);
wallSurface = surface_create(room_width, wallHeight);

buildWallList = true;
wallList = [];

drawWalls = true;

depth = layers.ground;

