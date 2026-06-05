global.stageController = self;

if (!instance_exists(global.player)) global.player = scr_obj_createExclusive(obj_player, 30, 30);
global.camera = scr_obj_createExclusive(obj_camera, global.player.x, global.player.y);
global.env = scr_obj_createExclusive(obj_envDraw, 0, 0);
global.hud = scr_obj_createExclusive(obj_hud, 0, 0);

global.roomLeft = 2;
global.roomRight = room_width - 2;
global.roomTop = 2;
global.roomBottom = room_height - 2;

var layerId = layer_get_id("Tiles");
layer_depth(layerId, layers.ground);