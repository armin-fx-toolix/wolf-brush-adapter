include <Adapter Buerste.scad>

tongue_inset = 48;

shaft_length = 28;

/* [Hidden] */

component="none";


virtual()
tongue_only (inset=tongue_inset);

difference()
{
	translate_x(tongue_length)
	union()
	{
		tongue_bind();
		
		translate_x(tongue_bind_length)
		screw();
	}
	
	tongue_cut (inset=tongue_inset);
	
	translate_x(tongue_length)
	translate_x(21)
	{
		cylinder_extend (h=30, r=3.0);
		translate_z (tongue_thickness/2 + 3)
		cylinder_extend (h=30, r=8.0);
	}
}
