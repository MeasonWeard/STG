event_inherited();

hp = 10000;

scr_env_addDrop(self, obj_res_metals, 75, 4);
scr_env_addDrop(self, obj_res_polymers, 75, 4);
scr_env_addDrop(self, obj_res_metals, 45, 12);
scr_env_addDrop(self, obj_res_polymers, 25, 12);
scr_env_addDrop(self, obj_res_fissiles, 15, 4);

scr_env_addDrop(self, obj_lootOrb, 100, 2);
scr_env_addDrop(self, obj_lootOrb, 80, 1);
scr_env_addDrop(self, obj_lootOrb, 40, 1);
scr_env_addDrop(self, obj_lootOrb, 20, 2);
scr_env_addDrop(self, obj_lootOrb, 10, 2);

spawnChance = 100;

lootMaxRarity = 6;
lootImproveChance = 55;

image_speed = 0.25;

createArrow = true;

destroyWhenStageOver = false;