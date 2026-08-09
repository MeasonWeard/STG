event_inherited();

hp = 100;

scr_env_addDrop(self, obj_res_metals, 75, 4);
scr_env_addDrop(self, obj_res_polymers, 75, 4);
scr_env_addDrop(self, obj_res_metals, 45, 12);
scr_env_addDrop(self, obj_res_polymers, 25, 12);
scr_env_addDrop(self, obj_res_fissiles, 15, 4);

scr_env_addDrop(self, obj_lootOrb, 100, 2);
scr_env_addDrop(self, obj_lootOrb, 65, 1);
scr_env_addDrop(self, obj_lootOrb, 20, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 1);

spawnChance = 50;

lootMaxRarity = 5;
lootImproveChance = 55;

destroyWhenStageOver = false;

createArrow = true;