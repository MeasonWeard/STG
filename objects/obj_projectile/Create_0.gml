active = false;
sc = global.stageController;
tilemap = layer_tilemap_get_id("tiles_collision");

destroyEffect = spr_bulletExplosion;

depth = layers.projectiles;

dir = 0;
spd = 12;
damage = 10;
source = noone;
faction = "none";
aimOverTile = undefined;

rangeLeft = 200;

charHitReport = false;

collisionFunc = undefined;