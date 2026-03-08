include <Adapter Buerste.scad>

tongue_inset          = 53.0;
tongue_screw_position = 45.0;

shaft_length = 51;

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
		translate_z (-tongue_thickness/2 - 1.0)
		cylinder_extend (h=30, d= 6.0 + 2*gap, outer=0.5);
		translate_z ( tongue_thickness/2 + 5.0)
		cylinder_extend (h=30, d=12.0 + 2*gap, outer=0.5);
	}
}
