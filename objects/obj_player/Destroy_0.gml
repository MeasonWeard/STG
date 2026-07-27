event_inherited();

if (instance_exists(global.runController)) global.runController.gameState = "fail";

if (!global.stageController.hub) scr_obj_createPortal(x, y);