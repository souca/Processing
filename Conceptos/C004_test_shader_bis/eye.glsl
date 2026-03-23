#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertTexCoord;

uniform vec2 eyeA;
uniform vec2 eyeB;
uniform vec2 iris;
uniform float rEye;
uniform float rIris;
uniform float rotation;

float sdCircle(vec2 p, vec2 c, float r){
    return length(p - c) - r;
}

void main(){

    // coordenadas locales del rect
    vec2 p = (vertTexCoord.xy - 0.5) * 220.0;

    float c = cos(-rotation);
    float s = sin(-rotation);

    p = vec2(c*p.x - s*p.y,
             s*p.x + c*p.y);

    float dA = sdCircle(p, eyeA, rEye);
    float dB = sdCircle(p, eyeB, rEye);
    float dI = sdCircle(p, iris, rIris);

    float f = max(dA, dB);
    float d = max(f, dI);

    float strokeWidth = 1.00;

    if (abs(f) < strokeWidth){
      gl_FragColor = vec4(0.0,0.0,0.0,1.0);
      return;
    }
    if(d < 0.0)
        gl_FragColor = vec4(1.0,0.5,0.5,1.0);
    else if(f < 0.0)
        gl_FragColor = vec4(1.0);
    else
        discard;
}
