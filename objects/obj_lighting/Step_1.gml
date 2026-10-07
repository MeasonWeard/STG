camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

x = camX;
y = camY;

var len = array_length(cols);

if (len > 0) {

    transitionPos += transitionFreq / 60;
    transitionPos = transitionPos mod len;

}