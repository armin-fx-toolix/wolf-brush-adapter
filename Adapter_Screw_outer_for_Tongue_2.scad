include <Adapter_Screw_outer_for_Tongue_1.scad>

tongue_inset           = 53.0;
tongue_screw_position  = 44.0;

shaft_length           = 54.5 + 1.5;
shaft_bind_length_tool = 20; // 0.1

make_groove     = true;

/* [Display] */

show_tongue = true;

/* [Hidden] */

component="none";


// object_slice (axis=Z, position=0, thickness=2.9)
difference()
{
	union()
	{
		tongue_bind();
		screw_shaft();
		screw_outer();
	}

	tongue_cut (inset=tongue_inset + gap);

	translate_x (tongue_screw_position)
	{
		translate_z (-tongue_thickness/2 - 1.0)
		cylinder_extend (h=30, d= 6.2 + 2*gap, outer=0.5);
		translate_z ( tongue_thickness/2 + 5.0)
		cylinder_extend (h=30, d=12.2 + 2*gap, outer=0.5);
	}
}

