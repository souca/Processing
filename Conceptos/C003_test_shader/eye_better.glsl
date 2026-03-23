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

// ruido barato (sin textura)
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

    // =====================
    // COLOR BASE
    // =====================

    vec3 col;

    // ---- fuera ----
    if(eyelid > 0.0)
        discard;

    // ---- esclera ----
    col = vec3(1.0);

    // =====================
    // IRIS
    // =====================

    if(irisMask < 0.0){

        vec2 v = p - iris;
        float r = length(v);
        float a = atan(v.y,v.x);

        float rn = r / rIris; // radio normalizado

        // --- fibras radiales ---
        float fibers =
            sin(a*60.0 + hash(floor(a*20.0))*3.14);

        fibers *= (1.0 - rn);

        // --- variación cromática ---
        float radialShade =
            smoothstep(1.0,0.2,rn);

        vec3 irisColor =
            vec3(0.15,0.55,0.85) *
            (0.7 + 0.3*radialShade)
            + fibers*0.08;

        col = irisColor;

        // =====================
        // PUPILA
        // =====================

        float pupilR = rIris*0.35;
        float pupil = smoothstep(
            pupilR,
            pupilR-2.0,
            r);

        col = mix(vec3(0.0), col, pupil);

        // =====================
        // BORDE OSCURO DEL IRIS
        // =====================

        float limbal =
            smoothstep(0.8,1.0,rn);

        col *= 1.0 - limbal*0.5;

        // =====================
        // REFLEJO
        // =====================

        vec2 lightPos = iris + vec2(-0.3*rIris,-0.3*rIris);

        float highlight =
            smoothstep(
                0.0,
                8.0,
                length(p-lightPos)
            );

        col += (1.0-highlight)*0.9;
    }

    gl_FragColor = vec4(col,1.0);
}
