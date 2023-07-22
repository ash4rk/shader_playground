
varying vec3 vNormal;
varying vec3 vPosition;

uniform float time;


float inverseLerp(float v, float minValue, float maxValue) {
  return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(v, inMin, inMax);
  return mix(outMin, outMax, t);
}

mat3 rotateY(float radians) {
  float s = sin(radians);
  float c = cos(radians);

  return mat3(
              c, 0.0, s,
              0.0, 1.0, 0.0,
              -s, 0.0, c
              );
}

mat3 rotateX(float radians) {
  float s = sin(radians);
  float c = cos(radians);

  return mat3(
              1, 0.0, 0.0,
              0.0, c, -s,
              0.0, s, c
              );
}

mat3 rotateZ(float radians) {
  float s = sin(radians);
  float c = cos(radians);

  return mat3(
              c, -s, 0.0,
              s, c, 0.0,
              0.0, 0.0, 1.0
              );
}

void main() {
  vec3 localSpacePosition = position;

  //localSpacePosition.z += sin(time);
  localSpacePosition = rotateX(time) * localSpacePosition;
  localSpacePosition = rotateY(time) * localSpacePosition;
  localSpacePosition = rotateZ(time) * localSpacePosition;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(localSpacePosition, 1.0);
  vNormal = (modelMatrix * vec4(normal, 0.0)).xyz;
  vPosition = (modelMatrix * vec4(localSpacePosition, 1.0)).xyz;
}
