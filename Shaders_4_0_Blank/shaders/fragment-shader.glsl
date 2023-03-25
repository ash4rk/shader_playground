
varying vec2 vUvs;

uniform vec2 resolution;
uniform sampler2D diffusion;

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 blue = vec3(0.0, 0.0, 1.0);
vec3 white = vec3(1.0, 1.0, 1.0);
vec3 black = vec3(0.0, 0.0, 0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);

void main() {
  vec3 colour = vec3(0.0);

  float value1 = vUvs.x;
  float value2 = smoothstep(0.0, 1.0, vUvs.x);
  float value3 = step(0.5, vUvs.x);

  vec3 line1 = vec3(smoothstep(0.0, 0.0015, abs(vUvs.y - 0.33)));
  vec3 line2 = vec3(smoothstep(0.0, 0.0015, abs(vUvs.y - 0.66)));

  vec3 stepCurve = vec3(smoothstep(0.0, 0.005, abs(vUvs.y - mix(0.66, 1.0, value3))));
  vec3 linearCurve = vec3(smoothstep(0.0, 0.005, abs(vUvs.y - mix(0.0, 0.33, value1))));
  vec3 smoothstepCurve = vec3(smoothstep(0.0, 0.005, abs(vUvs.y - mix(0.33, 0.66, value2))));

  if (vUvs.y < 0.33) {
    colour = vec3(mix(red, blue, vUvs.x));
  } else if (vUvs.y < 0.66) {
    colour = vec3(mix(yellow, black, smoothstep(0.0, 1.0, vUvs.x)));
  } else {
    colour = vec3(step(0.5, vUvs.x));
  }

  colour = mix(white, colour, line1);
  colour = mix(white, colour, line2);
  colour = mix(white, colour, linearCurve);
  colour = mix(white, colour, smoothstepCurve);
  colour = mix(red, colour, stepCurve);

  vec4 textureColour = texture(diffusion, vUvs);
  colour *= textureColour.rgb;

  gl_FragColor = vec4(colour, 1.0);
}
