seed = global.runController.currentCell.seed;

wallWidth = 256;
wallHeight = 128;
wallsAmount = floor(room_width / wallWidth);
wallSurface = surface_create(room_width, wallHeight);

buildWallList = true;
wallList = [];

drawWalls = true;

depth = layers.ground;

