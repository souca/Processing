#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform vec2 resolution;
uniform vec2 eyeA;
uniform vec2 eyeB;
uniform vec2 iris;
uniform float rEye;
uniform float rIris;

float sdCircle(vec2 p, vec2 c, float r){
    return length(p - c) - r;
}

void main(){

    vec2 p = gl_FragCoord.xy;

    float dA = sdCircle(p, eyeA, rEye);
    float dB = sdCircle(p, eyeB, rEye);
    float dI = sdCircle(p, iris, rIris);

    // INTERSECCIÓN DE LOS DOS
    float f = max(dA, dB);

    // INTERSECCIÓN DE LOS TRES
    float d = max(max(dA, dB), dI);

    if(d < 0.0)
        gl_FragColor = vec4(1.0,0.5,0.5,1.0); // visible
    else if(f < 0.0)
	gl_FragColor = vec4(1.0);
    else if (f == 0.0)
        gl_FragColor = vec4(0.0,0.0,0.0,1.0);
    else
	discard;
	
}
