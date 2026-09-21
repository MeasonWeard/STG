if (tileW <= 0 or tileH <= 0) exit;

var cam = view_camera[0];

var camX = camera_get_view_x(cam);
var camY = camera_get_view_y(cam);

var viewW = camera_get_view_width(cam);
var viewH = camera_get_view_height(cam);

//surface dimensions
var surfW = room_width;
var surfH = room_height;

if (skybox) {

    surfW = ceil(viewW + max(0, room_width - viewW) * parallax);
    surfH = ceil(viewH + max(0, room_height - viewH) * parallax);

}

//recreate surface if necessary
if (surface_exists(surf)) {

    if (surface_get_width(surf) != surfW or surface_get_height(surf) != surfH) {

        surface_free(surf);
        surf = -1;

    }

}

if (!surface_exists(surf)) {

    surf = surface_create(surfW, surfH);

    surface_set_target(surf);

    draw_clear_alpha(c_black, 0);

    for (var xx = 0; xx < surfW; xx += tileW) {

        for (var yy = 0; yy < surfH; yy += tileH) {

            var w = min(tileW, surfW - xx);
            var h = min(tileH, surfH - yy);

            draw_sprite_part(spr, 0, 0, 0, w, h, xx, yy);

        }

    }

    surface_reset_target();

}

//draw background
if (skybox) {

    //clip drawing to room boundaries
    var left = max(0, -camX);
    var top = max(0, -camY);

    var right = min(viewW, room_width - camX);
    var bottom = min(viewH, room_height - camY);

    var w = right - left;
    var h = bottom - top;

    if (w > 0 and h > 0) {

        //pan across the larger surface
		var panX = camX * parallax;
		var panY = camY * parallax;

        draw_surface_part(
            surf,
            panX + left,
            panY + top,
            w,
            h,
            camX + left,
            camY + top
        );

    }

} else {

    draw_surface(surf, 0, 0);

}


//if (tileW <= 0 or tileH <= 0) exit;

//var cam = view_camera[0];

//var camX = camera_get_view_x(cam);
//var camY = camera_get_view_y(cam);

//var surfW = skybox ? camera_get_view_width(cam) : room_width;
//var surfH = skybox ? camera_get_view_height(cam) : room_height;

////create or recreate surface
//if (!surface_exists(surf)) {

//    surf = surface_create(surfW, surfH);

//    surface_set_target(surf);
//    draw_clear_alpha(c_black, 0);

//    for (var xx = 0; xx < surfW; xx += tileW) {

//        for (var yy = 0; yy < surfH; yy += tileH) {

//            var w = min(tileW, surfW - xx);
//            var h = min(tileH, surfH - yy);

//            draw_sprite_part(spr, 0, 0, 0, w, h, xx, yy);

//        }

//    }

//    surface_reset_target();

//}

////draw background
//if (skybox) {

//    var left = max(0, -camX);
//    var top = max(0, -camY);

//    var right = min(surfW, room_width - camX);
//    var bottom = min(surfH, room_height - camY);

//    var w = right - left;
//    var h = bottom - top;

//    if (w > 0 and h > 0) {

//        draw_surface_part(
//            surf,
//            left,
//            top,
//            w,
//            h,
//            camX + left,
//            camY + top
//        );

//    }

//} else {

//    draw_surface(surf, 0, 0);

//}