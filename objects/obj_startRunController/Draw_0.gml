if (instance_exists(rc) and is_array(rc.miniMap)) {

	var miniMap = rc.miniMap;
	var xx = rc.startX;
	var yy = rc.startY;

	scr_ui_drawMiniMap(miniMap, 16, 128, 128, xx, yy);
	
}