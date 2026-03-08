include <Adapter Buerste.scad>

tongue_inset          = 47.0;
tongue_screw_position = 20.5;

shaft_length = 24.5;

/* [Hidden] */

component="none";


virtual()
tongue_only (inset=tongue_inset);

// object_slice (axis=Z, position=0, thickness=2.9)
difference()
{
	translate_x (tongue_length)
	union()
	{
		tongue_bind();
		
		translate_x (tongue_bind_length)
		screw();
	}
	
	tongue_cut (inset=tongue_inset + gap);
	
	translate_x (tongue_length)
	translate_x (tongue_screw_position)
	{
		cylinder_extend (h=30, d=4.0 + 2*gap, outer=0.5);
		translate_z (tongue_thickness/2 + 3)
		cylinder_extend (h=30, d=8.0 + 2*gap, outer=0.5);
	}
}
