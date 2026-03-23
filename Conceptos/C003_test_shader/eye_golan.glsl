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
uniform float time;

float sdCircle(vec2 p, vec2 c, float r){
    return length(p - c) - r;
}

float hash(float n){
    return fract(sin(n)*43758.5453);
}

void main(){

    vec2 p = gl_FragCoord.xy;

    float dA = sdCircle(p, eyeA, rEye);
    float dB = sdCircle(p, eyeB, rEye);
    float dI = sdCircle(p, iris, rIris);

    float eyelid = max(dA,dB);
    float irisMask = max(eyelid,dI);

    if(eyelid > 0.0)
        discard;

    // =====================
    // ESCLERA (globo ocular)
    // =====================

    vec3 col = vec3(1.0);

    // sombreado esférico fake
    vec2 eyeCenter = (eyeA+eyeB)*0.5;
    vec2 n = (p-eyeCenter)/rEye;

    float sphere = sqrt(max(0.0,1.0-dot(n,n)));
    col *= 0.85 + 0.15*sphere;

    // =====================
    // IRIS
    // =====================

    if(irisMask < 0.0){

        vec2 v = p - iris;
        float r = length(v);
        float a = atan(v.y,v.x);

        float rn = r/rIris;

        // micro movimiento orgánico
        float wobble =
            sin(time*2.0 + a*8.0)*0.02;

        rn += wobble;

        // fibras radiales
        float fibers =
            sin(a*70.0 + hash(floor(a*30.0))*6.28);

        fibers *= (1.0-rn);

        vec3 irisColor =
            vec3(0.2,0.6,0.9) *
            (0.7 + 0.3*(1.0-rn))
            + fibers*0.08;

        col = irisColor;

        // =====================
        // PUPILA DINÁMICA
        // =====================

        float pupilRadius =
            rIris*(0.30 + 0.05*sin(time*1.5));

        float pupil =
            smoothstep(pupilRadius,
                       pupilRadius-2.0,
                       r);

        col = mix(vec3(0.0), col, pupil);

        // =====================
        // LIMBAL RING
        // =====================

        float limbal =
            smoothstep(0.75,1.0,rn);

        col *= 1.0 - limbal*0.6;

        // =====================
        // REFLEJO DEPENDIENTE
        // =====================

        vec2 lightDir =
            normalize(vec2(-0.5,-0.6));

        vec2 highlightPos =
            iris + lightDir*rIris*0.5;

        float highlight =
            smoothstep(
                0.0,
                10.0,
                length(p-highlightPos)
            );

        col += (1.0-highlight)*0.9;
    }

    gl_FragColor = vec4(col,1.0);
}
