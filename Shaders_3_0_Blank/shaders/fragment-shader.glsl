varying vec2 uUvs;

uniform sampler2D diffuse;
uniform sampler2D overlay;

void main(void) {
  vec4 dogTexture = texture(diffuse, uUvs* (-4.0));
  vec4 overlayTexture = texture(overlay, uUvs);
  gl_FragColor = mix(dogTexture, overlayTexture, overlayTexture.w);
}
