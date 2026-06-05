global.camera = self;
cursor = global.cursor;
target = global.player;

depth = layers.borders;

cam = view_camera[0];
viewW = camera_get_view_width(cam);
viewH = camera_get_view_height(cam);

rx1 = 0;
ry1 = 0;
rx2 = room_width;
ry2 = room_height;

lookAheadDistance = 256;
lookAheadDistanceByMouse = 448;
lookAheadX = 0;
lookAheadY = 0;

lookAheadSpeedY = 0.04;
lookAheadReturnY = 0.05;

follow = 0.05;
catchUp = 0.001;
maxFollow = 0.25;

lookAheadSpeed = 0.03;
lookAheadReturn = 0.03;

lookDelay = 30;

firstStep = true;

lightingCol = undefined;
lightingAlpha = 0;