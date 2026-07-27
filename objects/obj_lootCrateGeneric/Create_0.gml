event_inherited();

hp = 100;

scr_env_addDrop(self, obj_res_metals, 75, 4);
scr_env_addDrop(self, obj_res_polymers, 75, 4);
scr_env_addDrop(self, obj_res_metals, 45, 12);
scr_env_addDrop(self, obj_res_polymers, 25, 12);
scr_env_addDrop(self, obj_res_fissiles, 15, 4);

scr_env_addDrop(self, obj_lootOrb, 100, 1);
scr_env_addDrop(self, obj_lootOrb, 75, 1);
scr_env_addDrop(self, obj_lootOrb, 25, 1);
scr_env_addDrop(self, obj_lootOrb, 10, 1);

spawnChance = 60;

lootMaxRarity = 5;
lootImproveChance = 40;