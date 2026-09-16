event_inherited();

hp = 100;

var polyChance = 8 + rc.runLevel * 1.75;

scr_env_addDrop(self, obj_res_metals, 88, 6);
scr_env_addDrop(self, obj_res_bio, 88, 6);
scr_env_addDrop(self, obj_res_polymers, polyChance, 6);
scr_env_addDrop(self, obj_res_metals, 44, 10);
scr_env_addDrop(self, obj_res_bio, 44, 10);
scr_env_addDrop(self, obj_res_polymers, polyChance * 0.5, 10);

var fissChance = 4 + rc.runLevel * 0.75;
var fissVal = scr_random_chance(fissChance * 0.25) ? 3 : 2;
scr_env_addDrop(self, obj_res_fissiles, fissChance, fissVal);

scr_env_addDrop(self, obj_lootOrb, 100, 2);
scr_env_addDrop(self, obj_lootOrb, 65, 1);
scr_env_addDrop(self, obj_lootOrb, 20, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 1);

spawnChance = 50;

lootMaxRarity = 5;
lootImproveChance = 55;

createArrow = true;