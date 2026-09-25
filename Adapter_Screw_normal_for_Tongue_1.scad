include <Adapter_Brush.scad>

tongue_inset          = 43.5;
tongue_screw_position = 17;

shaft_length = 24;

/* [Display] */

show_tongue = true;

type = "component"; // ["component", "printable"]

/* [Hidden] */

component="screw only";


if (component=="screw only")
{
	if (type=="component")
	{
		if (show_tongue)
		virtual()
		tongue_only (inset=tongue_inset);
		
		screw_for_tongue ();
	}
	
	if (type=="printable")
		translate_z (shaft_length + screw_cylinder_depth + screw_depth)
		rotate_y (90)
		screw_for_tongue ();
}

module screw_for_tongue ()
{
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
			cylinder_extend (h=30, d=4.2 + 2*gap, outer=0.5);
			translate_z (tongue_thickness/2 + 3)
			cylinder_extend (h=30, d=8.2 + 2*gap, outer=0.5);
		}
	}
}

