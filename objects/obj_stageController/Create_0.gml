global.stageController = self;
rc = scr_data_getRunController();

hub = false;
setupHub = true;

if (!instance_exists(global.player)) global.player = scr_obj_createExclusive(obj_player, room_width * 0.5, room_height * 0.5);
global.camera = scr_obj_createExclusive(obj_camera, global.player.x, global.player.y);
global.env = scr_obj_createExclusive(obj_envDraw, 0, 0);
global.hud = scr_obj_createExclusive(obj_hud, 0, 0);

global.roomLeft = 2;
global.roomRight = room_width - 2;
global.roomTop = 2;
global.roomBottom = room_height - 2;
global.projectileTop = global.roomTop - 64;

var layerId = layer_get_id("Tiles");
layer_depth(layerId, layers.ground);

player = global.player;

createdArrows = false;
stageInProgress = true;
checkIfCleared = true;

//projectile pool
projectilePool = [];
procectilePoolLen = 200;
for (var i = 0; i < procectilePoolLen; i++) {

	var newProj = instance_create_layer(0, 0, "Instances", obj_projectile);
	array_push(projectilePool, newProj);
	
}

//time slicing
timeSlicing = {

	thorns: {
		nextIndex: 0,
		turn: 0,
		steps: 4
	},
	
	ghostCheck: {
		nextIndex: 0,
		turn: 0,
		steps: 12
	},
	
	activation: {
		nextIndex: 0,
		turn: 0,
		steps: 8
	},
	
	aim: {
		nextIndex: 0,
		turn: 0,
		steps: 8
	},
	
	detection: {
		nextIndex: 0,
		turn: 0,
		steps: 16
	},
	
	avoid: {
		nextIndex: 0,
		turn: 0,
		steps: 12
	}
	
}

//spatial hashing
charHash = {};
ghostHash = {};
envHash = {};
destHash = {};
itemHash = {};