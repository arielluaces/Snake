varying highp vec2 vTexCoord;
highp vec4 getTexel(highp vec2 texCoord);

void main()
{
    gl_FragColor = getTexel(vTexCoord);
}

uniform lowp vec4 uColor;
uniform highp float uExponent;

highp vec4 getTexel(highp vec2 texCoord)
{
    lowp vec2 delta = abs(texCoord-floor(texCoord+vec2(0.5, 0.5)));
    return vec4(uColor.rgb,uColor.a*(1.0-pow(delta.x*delta.y,uExponent)));
}
