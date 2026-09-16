event_inherited();

hp = 100;
rc = global.runController;


var polyChance = 6 + rc.runLevel * 1.5;

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

scr_env_addDrop(self, obj_lootOrb, 100, 1);
scr_env_addDrop(self, obj_lootOrb, 75, 1);
scr_env_addDrop(self, obj_lootOrb, 25, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 1);

spawnChance = 60;

lootMaxRarity = 5;
lootImproveChance = 35;