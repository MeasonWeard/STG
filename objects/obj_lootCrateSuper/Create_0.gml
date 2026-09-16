event_inherited();

hp = 10000;

var polyChance = 10 + rc.runLevel * 3;

scr_env_addDrop(self, obj_res_metals, 99, 24);
scr_env_addDrop(self, obj_res_bio, 99, 24);
scr_env_addDrop(self, obj_res_polymers, polyChance, 24);
scr_env_addDrop(self, obj_res_metals, 66, 28);
scr_env_addDrop(self, obj_res_bio, 66, 28);
scr_env_addDrop(self, obj_res_polymers, polyChance * 0.5, 28);

var fissChance = 8 + rc.runLevel;
var fissVal = scr_random_chance(fissChance * 0.25) ? 5 : 3;
scr_env_addDrop(self, obj_res_fissiles, fissChance, fissVal);

scr_env_addDrop(self, obj_lootOrb, 100, 3);
scr_env_addDrop(self, obj_lootOrb, 80, 2);
scr_env_addDrop(self, obj_lootOrb, 40, 1);
scr_env_addDrop(self, obj_lootOrb, 20, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 1);

spawnChance = 100;

lootMaxRarity = 6;
lootImproveChance = 60;

image_speed = 0.25;

createArrow = true;