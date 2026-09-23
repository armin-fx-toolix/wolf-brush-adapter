include <Adapter Buerste.scad>

tongue_inset          = 53.0;
tongue_screw_position = 42.0;

shaft_length = 51;

/* [Display] */

show_tongue = true;

/* [Hidden] */

component="none";


if (show_tongue)
virtual()
tongue_only (inset=tongue_inset);

// object_slice (axis=Z, position=0, thickness=2.9)
difference()
{
	union()
	{
		tongue_bind();
		screw();
	}
	
	tongue_cut (inset=tongue_inset + gap);
	
	translate_x (tongue_screw_position)
	{
		translate_z (-tongue_thickness/2 - 1.0)
		cylinder_extend (h=30, d= 6.0 + 2*gap, outer=0.5);
		translate_z ( tongue_thickness/2 + 5.0)
		cylinder_extend (h=30, d=12.0 + 2*gap, outer=0.5);
	}
}
