//formatting
meleeBarLeft = x - meleeBarWidth * 0.5;
meleeBarRight = x + meleeBarWidth * 0.5;
meleeBarTop = y - meleeBarHeight * 0.5 + 25;
meleeBarBottom = y + meleeBarHeight * 0.5 + 25;
meleeNumX = meleeBarRight + 8;
meleeNumY = meleeBarTop;

ammoNumX = meleeBarLeft - 8;
ammoNumY = meleeNumY;

reloadBarLeft = x - reloadBarWidth * 0.5;
reloadBarRight = x + reloadBarWidth * 0.5;
reloadBarTop = meleeBarBottom + 8;
reloadBarBottom = reloadBarTop + reloadBarHeight;

gunNameX = x;
gunNameY = y - 50;