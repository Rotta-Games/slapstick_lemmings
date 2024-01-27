shader_type canvas_item;

uniform float height = 25.0;
uniform float speed = 4.0;

void vertex() {
    // Calculate screen size from projection matrix
	// Called for every vertex the material is visible on.
	VERTEX.y += height * 10.0 * sin((UV.x) * 6.0 + (speed * TIME));
}

void fragment() {
	// COLOR.rgb = vec4(1.0, 1.0, 0.5, 1.0).rgb;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
