event_inherited();

hp = 100;

var polyChance = 4 + rc.runLevel * 1.5;

scr_env_addDrop(self, obj_res_metals, 66, 4);
scr_env_addDrop(self, obj_res_bio, 66, 4);
scr_env_addDrop(self, obj_res_polymers, polyChance, 4);
scr_env_addDrop(self, obj_res_metals, 33, 8);
scr_env_addDrop(self, obj_res_bio, 33, 8);
scr_env_addDrop(self, obj_res_polymers, polyChance * 0.5, 8);

var fissChance = 3 + rc.runLevel * 0.5;
var fissVal = scr_random_chance(fissChance * 0.25) ? 2 : 1;
scr_env_addDrop(self, obj_res_fissiles, fissChance, fissVal);

scr_env_addDrop(self, obj_stimPack, 5, 1);
scr_env_addDrop(self, obj_stimPack, 5, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 2);

spawnChance = 25;

lootMaxRarity = 3;
lootImproveChance = 20;

destroyWhenStageOver = true;