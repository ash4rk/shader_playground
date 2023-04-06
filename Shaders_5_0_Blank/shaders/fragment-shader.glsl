
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
  float tx = sin(vUvs.x * 100.0);
  float ty = sin(vUvs.y * 100.0);

  colour = vec3(max(tx,ty));

  gl_FragColor = vec4(colour, 1.0);
}
