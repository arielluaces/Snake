varying highp vec2 vTexCoord;
uniform lowp vec4 uColor;
uniform highp float uExponent;

void main()
{
    lowp vec2 delta = abs(vTexCoord-floor(vTexCoord+vec2(0.5, 0.5)));
    gl_FragColor = vec4(uColor.rgb,uColor.a*(1.0-pow(delta.x*delta.y,uExponent)));
}
