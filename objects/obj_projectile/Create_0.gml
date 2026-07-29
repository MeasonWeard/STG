active = false;
sc = global.stageController;

destroyEffect = spr_bulletExplosion;

shieldHitSounds = global.data.soundProfiles.bulletHitShield;

depth = layers.projectiles;
height = 0;

dir = 0;
spd = 12;
rot = 0;
damage = 10;
source = noone;
faction = "none";
aimOverTile = undefined;
lifeSteal = 0;

rangeLeft = 200;

charHitReport = false;

collisionFuncs = [];

damageDestructibles = false;

oa = 100;