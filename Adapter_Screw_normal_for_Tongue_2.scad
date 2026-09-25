include <Adapter_Screw_normal_for_Tongue_1.scad>

tongue_inset          = 53.0;
tongue_screw_position = 44.0;

shaft_length = 53;

/* [Display] */

show_tongue = true;

type = "component"; // ["component", "printable"]

/* [Hidden] */

component="screw only";


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
			translate_z (-tongue_thickness/2 - 1.0)
			cylinder_extend (h=30, d= 6.2 + 2*gap, outer=0.5);
			translate_z ( tongue_thickness/2 + 5.0)
			cylinder_extend (h=30, d=12.2 + 2*gap, outer=0.5);
		}
	}
}

