//
// simple colour swapping fragment shader
//

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float flash_amt;

void main()
{
    vec4 col = texture2D( gm_BaseTexture, v_vTexcoord );       
    
    col.r = min(col.r+flash_amt, 1.0);
    col.g = min(col.g+flash_amt, 1.0);
    col.b = min(col.b+flash_amt, 1.0);
    
    gl_FragColor = col;//v_vColour * col;
}

