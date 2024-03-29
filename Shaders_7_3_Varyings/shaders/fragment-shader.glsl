
uniform samplerCube specMap;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec4 vColour;

float inverseLerp(float v, float minValue, float maxValue) {
  return (v - minValue) / (maxValue - minValue);
}

float remap(float v, float inMin, float inMax, float outMin, float outMax) {
  float t = inverseLerp(v, inMin, inMax);
  return mix(outMin, outMax, t);
}

void main() {
  vec3 modelColour = vColour.xyz;

  vec3 red = vec3(1.0, 0.0, 0.0);
  vec3 blue = vec3(0.0, 0.0, 1.0);
  vec3 yellow  = vec3(1.0, 1.0, 0.0);

  float value1 = vColour.w;
  float line = smoothstep(0.003, 0.004, abs(vPosition.y - mix(-0.5, 0.0, value1)));
  modelColour = mix(yellow, modelColour, line);

  // Fragment shader part
  if (vPosition.y > 0.0) {
    float t = remap(vPosition.x, -0.5 , 0.5, 0.0, 1.0);
    t = pow(t, 2.0);
    modelColour = mix(red, blue, t);

    float value2 = t;
    float line2 = smoothstep(0.003, 0.004, abs(vPosition.y - mix(0.0, 0.5, value2)));
    modelColour = mix(yellow, modelColour, line2);
  }


  // Dividing line
  float middleLine = smoothstep(0.004, 0.005, abs(vPosition.y));
  modelColour = mix(vec3(0.0), modelColour, middleLine);

  vec3 lighting = vec3(0.0);

  vec3 normal = normalize(vNormal);
  vec3 viewDir = normalize(cameraPosition - vPosition);

  // Ambient
  vec3 ambient = vec3(1.0);

  // Hemi
  vec3 skyColour = vec3(0.0, 0.3, 0.6);
  vec3 groundColour = vec3(0.6, 0.3, 0.1);

  vec3 hemi = mix(groundColour, skyColour, remap(normal.y, -1.0, 1.0, 0.0, 1.0));

  // Diffuse lighting
  vec3 lightDir = normalize(vec3(1.0, 1.0, 1.0));
  vec3 lightColour = vec3(1.0, 1.0, 0.9);
  float dp = max(0.0, dot(lightDir, normal));

  vec3 diffuse = dp * lightColour;
  vec3 specular = vec3(0.0);

  // Specular
  vec3 r = normalize(reflect(-lightDir, normal));
  float phongValue = max(0.0, dot(viewDir, r));
  phongValue = pow(phongValue, 32.0);

  specular += phongValue * 0.15;

  // IBL Specular
  vec3 iblCoord = normalize(reflect(-viewDir, normal));
  vec3 iblSample = textureCube(specMap, iblCoord).xyz;

  specular += iblSample * 0.5;

  // Fresnel
  float fresnel = 1.0 - max(0.0, dot(viewDir, normal));
  fresnel = pow(fresnel, 2.0);

  specular *= fresnel;

  // Combine lighting
  lighting = hemi * 0.1 + diffuse;

  vec3 colour = modelColour * lighting + specular;

  gl_FragColor = vec4(pow(colour, vec3(1.0 / 2.2)), 1.0);
}
