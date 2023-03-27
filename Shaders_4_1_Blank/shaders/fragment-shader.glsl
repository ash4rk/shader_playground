
varying vec2 vUvs;

uniform vec2 resolution;
uniform sampler2D diffusion;

vec3 red = vec3(1.0, 0.0, 0.0);
vec3 blue = vec3(0.0, 0.0, 1.0);
vec3 white = vec3(1.0, 1.0, 1.0);
vec3 black = vec3(0.0, 0.0, 0.0);
vec3 yellow = vec3(1.0, 1.0, 0.0);
vec3 green = vec3(0.0, 1.0, 0.0);
vec3 purple = vec3(0.5, 0.0, 0.5);
vec3 pink = vec3(1.0, 0.753, 0.796);
vec3 cyan = vec3(0.0, 1.0, 1.0);
vec3 lavender = vec3(0.9, 0.9, 1.0);

void main() {
  vec3 gray_colour = vec3(0.75);
  vec3 colour = vec3(0.0);

  // Grid
  vec2 center = vUvs - 0.5;
  vec2 cell = fract(center * resolution / 100.0);
  cell = abs(cell - 0.5);
  float distToCell = 1.0 - 2.0 * (max(cell.y, cell.x));
  // Grid Lines
  float cellLine = smoothstep(0.0, 0.025, distToCell);
  float xAxis = smoothstep(0.0, 0.002, abs(vUvs.x - 0.5));
  float yAxis = smoothstep(0.0, 0.002, abs(vUvs.y - 0.5));

  // Lines
  vec2 pos = center * resolution / 100.0;
  float value1 = pos.x;
  float value2 = abs(pos.x);
  float value3 = floor(pos.x);
  float value4 = ceil(pos.x);
  float value5 = round(pos.x);
  float value6 = fract(pos.x);
//  float value7 = mod(pos.x, 0.25);
  float functionLine1 = smoothstep(0.0, 0.07, abs(pos.y - value1));
  float functionLine2 = smoothstep(0.0, 0.025, abs(pos.y - value2));
  float functionLine3 = smoothstep(0.0, 0.015, abs(pos.y - value3));
  float functionLine4 = smoothstep(0.0, 0.015, abs(pos.y - value4));
  float functionLine5 = smoothstep(0.0, 0.005, abs(pos.y - value5));
  float functionLine6 = smoothstep(0.0, 0.015, abs(pos.y - value6));
//  float functionLine7 = smoothstep(0.0, 0.015, abs(pos.y - value7));


  colour = mix(black, gray_colour, cellLine);
  colour = mix(blue, colour, xAxis);
  colour = mix(blue, colour, yAxis);
  colour = mix(yellow, colour, functionLine1);
  colour = mix(red, colour, functionLine2);
  colour = mix(green, colour, functionLine3);
  colour = mix(pink, colour, functionLine4);
  colour = mix(cyan, colour, functionLine5);
  colour = mix(purple, colour, functionLine6);
//  colour = mix(lavender, colour, functionLine7);

  gl_FragColor = vec4(colour, 1.0);
}
