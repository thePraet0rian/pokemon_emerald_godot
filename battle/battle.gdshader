shader_type canvas_item;

uniform float blue = 1.0;
uniform float green = 1.0;
uniform float red = 1.0;

uniform bool finished = false; 

void fragment() {
	
	if (finished) {
	COLOR.r = red;
	COLOR.g = green;
	COLOR.b = blue;
	} else {
		COLOR = texture(TEXTURE, UV);
	}
}
