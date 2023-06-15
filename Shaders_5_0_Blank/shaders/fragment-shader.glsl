
varying vec2 vUvs;

uniform float time;
uniform sampler2D diffuse;

float inverseLerp(float currValue, float minValue, float maxValue) {
  return (currValue - minValue) / (maxValue - minValue);
}

float remap(float currValue, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(currValue, inMin, inMax);
  return mix(outMin, outMax, t);
}

void main() {
  vec4 dogTexture = texture(diffuse, vUvs);
  vec3 colour = vec3(0.0);

  float t1 = remap(sin(vUvs.y * 400.0 + time * 10.0), -1.0, 1.0, 0.8, 1.0);
  float t2 = remap(sin(vUvs.y * 20.0 - time * 2.0), -1.0, 1.0, 0.9, 1.0);

  colour = t1 * t2  * dogTexture.xyz;

  gl_FragColor = vec4(colour, 1.0);
}
