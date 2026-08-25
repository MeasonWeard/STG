event_inherited();

hp = 10000;

scr_env_addDrop(self, obj_res_metals, 75, 4);
scr_env_addDrop(self, obj_res_polymers, 75, 4);
scr_env_addDrop(self, obj_res_metals, 45, 12);
scr_env_addDrop(self, obj_res_polymers, 25, 12);
scr_env_addDrop(self, obj_res_fissiles, 15, 4);

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