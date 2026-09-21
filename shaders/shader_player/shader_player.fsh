varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 hairColour;
uniform vec3 skinColour;

uniform vec2 texelSize;
uniform vec4 spriteUV;

//Recolour one original texel
vec4 recolour(vec4 col)
{
    vec3 hairDark = vec3(153.0, 0.0, 90.0) / 255.0;
    vec3 hairMid = vec3(204.0, 0.0, 120.0) / 255.0;
    vec3 hairLight = vec3(255.0, 0.0, 150.0) / 255.0;

    vec3 skin1 = vec3(79.0, 39.0, 29.0) / 255.0;
    vec3 skin2 = vec3(107.0, 54.0, 31.0) / 255.0;
    vec3 skin3 = vec3(155.0, 89.0, 50.0) / 255.0;
    vec3 skin4 = vec3(222.0, 139.0, 85.0) / 255.0;
    vec3 skin5 = vec3(248.0, 189.0, 131.0) / 255.0;
	vec3 skin6 = vec3(192.0, 115.0, 70.0) / 255.0;
	vec3 skin7 = vec3(245.0, 179.0, 112.0) / 255.0;

    float tolerance = 0.01;

    //HAIR
    if (distance(col.rgb, hairDark) < tolerance) {

        col.rgb = hairColour * 0.6;

    } else if (distance(col.rgb, hairMid) < tolerance) {

        col.rgb = hairColour * 0.8;

    } else if (distance(col.rgb, hairLight) < tolerance) {

        col.rgb = hairColour;

    } else {

        //SKIN
        float d1 = distance(col.rgb, skin1);
        float d2 = distance(col.rgb, skin2);
        float d3 = distance(col.rgb, skin3);
        float d4 = distance(col.rgb, skin4);
        float d5 = distance(col.rgb, skin5);
		float d6 = distance(col.rgb, skin6);
		float d7 = distance(col.rgb, skin7);

        float closest = min(min(min(d1, d2), min(d3, d4)), min(min(d5, d6), d7));

		if (closest < tolerance) {

		    if (closest == d1) {

		        col.rgb = skinColour * 0.32;

		    } else if (closest == d2) {

		        col.rgb = skinColour * 0.43;

		    } else if (closest == d3) {

		        col.rgb = skinColour * 0.62;

		    } else if (closest == d6) {

		        col.rgb = skinColour * 0.74;

		    } else if (closest == d4) {

		        col.rgb = skinColour * 0.85;

		    } else if (closest == d7) {

		        col.rgb = skinColour * 0.95;

		    } else {

		        col.rgb = skinColour;

		    }

		}

    }

    return col;
}

void main()
{
    //Convert texture coordinates into texel coordinates.
    vec2 pos = v_vTexcoord / texelSize - 0.5;

    vec2 base = floor(pos);
    vec2 blend = fract(pos);

    //Find the centres of the four neighbouring texels.
    vec2 uv00 = (base + vec2(0.5, 0.5)) * texelSize;
    vec2 uv10 = (base + vec2(1.5, 0.5)) * texelSize;
    vec2 uv01 = (base + vec2(0.5, 1.5)) * texelSize;
    vec2 uv11 = (base + vec2(1.5, 1.5)) * texelSize;

    //Keep samples inside the current sprite frame.
    vec2 uvMin = spriteUV.xy + texelSize * 0.5;
    vec2 uvMax = spriteUV.zw - texelSize * 0.5;

    uv00 = clamp(uv00, uvMin, uvMax);
    uv10 = clamp(uv10, uvMin, uvMax);
    uv01 = clamp(uv01, uvMin, uvMax);
    uv11 = clamp(uv11, uvMin, uvMax);

    //Recolour each texel separately.
    vec4 c00 = recolour(texture2D(gm_BaseTexture, uv00));
    vec4 c10 = recolour(texture2D(gm_BaseTexture, uv10));
    vec4 c01 = recolour(texture2D(gm_BaseTexture, uv01));
    vec4 c11 = recolour(texture2D(gm_BaseTexture, uv11));

    //Blend the recoloured texels.
    vec4 top = mix(c00, c10, blend.x);
    vec4 bottom = mix(c01, c11, blend.x);

    vec4 col = mix(top, bottom, blend.y);

    gl_FragColor = col * v_vColour;
}

//varying vec2 v_vTexcoord;
//varying vec4 v_vColour;

//uniform vec3 hairColour;
//uniform vec3 skinColour;

//void main()
//{
//    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);

//    float tolerance = 0.15;

//    //HAIR COLOURS
//    vec3 hairDark = vec3(153.0, 0.0, 90.0) / 255.0;
//    vec3 hairMid = vec3(204.0, 0.0, 120.0) / 255.0;
//    vec3 hairLight = vec3(255.0, 0.0, 150.0) / 255.0;

//    //SKIN COLOURS
//    vec3 skin1 = vec3(79.0, 39.0, 29.0) / 255.0;
//    vec3 skin2 = vec3(107.0, 54.0, 31.0) / 255.0;
//    vec3 skin3 = vec3(155.0, 89.0, 50.0) / 255.0;
//    vec3 skin4 = vec3(222.0, 139.0, 85.0) / 255.0;
//    vec3 skin5 = vec3(248.0, 189.0, 131.0) / 255.0;

//    //HAIR
//    if (distance(col.rgb, hairDark) < tolerance) {

//        col.rgb = hairColour * 0.6;

//    } else if (distance(col.rgb, hairMid) < tolerance) {

//        col.rgb = hairColour * 0.8;

//    } else if (distance(col.rgb, hairLight) < tolerance) {

//        col.rgb = hairColour;

//    }

//    //SKIN - only above cutoff
//    else {

//        //Find the closest original skin shade.
//        float d1 = distance(col.rgb, skin1);
//        float d2 = distance(col.rgb, skin2);
//        float d3 = distance(col.rgb, skin3);
//        float d4 = distance(col.rgb, skin4);
//        float d5 = distance(col.rgb, skin5);

//        float closest = min(min(min(d1, d2), min(d3, d4)), d5);

//        if (closest < tolerance) {

//            if (closest == d1) {

//                col.rgb = skinColour * 0.32;

//            } else if (closest == d2) {

//                col.rgb = skinColour * 0.43;

//            } else if (closest == d3) {

//                col.rgb = skinColour * 0.62;

//            } else if (closest == d4) {

//                col.rgb = skinColour * 0.85;

//            } else {

//                col.rgb = skinColour;

//            }

//        }

//    }

//    gl_FragColor = col * v_vColour;
//}