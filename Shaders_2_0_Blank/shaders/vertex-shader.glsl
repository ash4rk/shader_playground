attribute vec3 simondevColours;

varying vec2 vUvs;
varying vec3 vColour;

void main() {
  vec4 localPosition = vec4(position, 1.0);

   gl_Position = projectionMatrix * modelViewMatrix * localPosition;
   vUvs = uv;
   vColour = simondevColours;
}
