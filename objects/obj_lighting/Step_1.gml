camX = camera_get_view_x(cam);
camY = camera_get_view_y(cam);
camXmid = camX + camW * 0.5;
camYmid = camY + camH * 0.5;

x = camX;
y = camY;

var colLen = array_length(cols);
var alphaLen = array_length(alphas);

if (colLen > 0) {
    colPos = (colPos + transitionFreq / 60) mod colLen;
}

if (alphaLen > 0) {
    alphaPos = (alphaPos + transitionFreq / 60) mod alphaLen;
}