
varying vec3 vNormal;
varying vec3 vPosition;
varying vec4 vColour;

uniform float time;


float inverseLerp(float v, float minValue, float maxValue) {
  return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(v, inMin, inMax);
  return mix(outMin, outMax, t);
}


void main() {	
  vec3 localSpacePosition = position;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);
  vNormal = (modelMatrix * vec4(normal, 0.0)).xyz;
  vPosition = (modelMatrix * vec4(localSpacePosition, 1.0)).xyz;

  vec3 red = vec3(1.0, 0.0, 0.0);
  vec3 blue = vec3(0.0, 0.0, 1.0);

  float t = remap(vPosition.x, -0.5 , 0.5, 0.0, 1.0);
  t = pow(t, 2.0);

  vColour = vec4(mix(red, blue, t), t);
}
