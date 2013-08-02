attribute vec2 aGridValue;
attribute vec2 aPosition;
uniform mat4 uMVPMatrix;
varying highp vec2 vGridValue;

void main()
{
    gl_Position = uMVPMatrix * vec4(aPosition, 0.0, 1.0);
    vGridValue = aGridValue;
}
