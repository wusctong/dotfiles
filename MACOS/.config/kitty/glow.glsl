uniform sampler2D image;
varying vec2 texcoord;

void main() {
    vec4 color = texture2D(image, texcoord);
    
    // Intensify bright colors
    float brightness = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    if (brightness > 0.3) {
        // Apply glow to bright text
        vec3 glow = color.rgb * 1.8;
        glow = pow(glow, vec3(0.8)); // Soft glow
        gl_FragColor = vec4(glow, color.a);
    } else {
        gl_FragColor = color;
    }
}
