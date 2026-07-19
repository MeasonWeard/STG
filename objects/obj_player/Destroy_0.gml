event_inherited();

if (instance_exists(global.runController)) global.runController.gameState = "fail";

instance_create_layer(x, y, "Instances", obj_portal);