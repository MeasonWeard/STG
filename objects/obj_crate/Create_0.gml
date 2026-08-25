event_inherited();

hp = 100;

scr_env_addDrop(self, obj_res_metals, 75, 4);
scr_env_addDrop(self, obj_res_polymers, 75, 4);
scr_env_addDrop(self, obj_res_metals, 45, 12);
scr_env_addDrop(self, obj_res_polymers, 25, 12);
scr_env_addDrop(self, obj_stimPack, 5, 1);
scr_env_addDrop(self, obj_stimPack, 5, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 2);

spawnChance = 25;

lootMaxRarity = 3;
lootImproveChance = 20;

destroyWhenStageOver = true;