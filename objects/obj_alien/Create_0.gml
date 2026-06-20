event_inherited();

bloodCol = c_purple;

bulletHitFunc = scr_effects_bulletHitFlesh;
deathFunc = scr_char_fleshExplosion;

gun1 = new gun_alienOrb();

scr_guns_collectGun(self, gun1, true);

stats.maxHp = 60;