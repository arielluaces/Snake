uniform lowp vec4 uColor;
uniform highp float uExponent;
varying highp vec2 vGridValue;

void main()
{
    lowp vec2 delta = abs(vGridValue-floor(vGridValue+vec2(0.5, 0.5)));
    gl_FragColor = vec4(uColor.rgb,uColor.a*(1.0-pow(delta.x*delta.y,uExponent)));
}
