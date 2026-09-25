include <Adapter_Brush.scad>

tongue_inset           = 43.5;
tongue_screw_position  = 17;

shaft_length           = 43.5 + 1.5;
shaft_bind_length_tool = 20; // 0.1

screw_diameter_outer = 37.5;
screw_depth          = 17;
screw_cylinder_depth =  0;
//
screw_pitch          = 3.9; // 0.1
screw_tooth_diameter = 2; // 0.1
screw_tooth_depth    = 1.2; // 0.1

wall = 4;

make_knurling     = true;
knurling_depth    =  2;
knurling_diameter = 40;
knurling_count    = 10;

/* [Display] */

show_tongue = true;

type = "component"; // ["component", "printable"]

/* [Hidden] */

component = "screw only outer";

screw_outer_diameter = norm([tongue_width, tongue_thickness]) + 2*wall;


if (component=="screw only outer")
{
	if (type=="component")
	{
		if (show_tongue)
		virtual()
		tongue_only (inset=tongue_inset);
		
		screw_outer_for_tongue ();
	}
	
	if (type=="printable")
		translate_z (shaft_length + screw_depth)
		rotate_y (90)
		screw_outer_for_tongue ();
}

module screw_outer_for_tongue ()
{
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
			cylinder_extend (h=30, d=4.2 + 2*gap, outer=0.5);
			translate_z (tongue_thickness/2 + 3)
			cylinder_extend (h=30, d=8.2 + 2*gap, outer=0.5);
		}
	}
}

module screw_outer ()
{
	slices = get_screw_slices();
	
	wall_tube = wall + (make_knurling ? knurling_depth : 0);
	
	translate_x (shaft_length)
	rotate_y (90)
	combine()
	{
		// Gehäuse um das Gewinde:
		part_main()
		tube (
			  h = screw_depth
			, ri=screw_diameter_outer/2
			, ro=screw_diameter_outer/2 + wall_tube
			, $fn=slices);
		
		// Anbindung
		conture =
		[ each bezier_curve (
			[[-screw_outer_diameter/2+epsilon, -shaft_bind_length_tool]
			,[-screw_outer_diameter/2+epsilon, -wall]
			,[-screw_diameter_outer/2        , -wall]
			], slices="x")
		, each reverse_full	 (
			translate_points (v=[-screw_diameter_outer/2-wall_tube+wall, 0], list=
			circle_curve     (r=wall, angle=[90,180], slices="x")
			) )
		, [-screw_outer_diameter/2, 0]
		];
		part_main()
		rotate_extrude_extend (slices=slices, convexity=4)
		polygon (conture);
		
		// Gewinde:
		part_main()
		intersection()
		{
			build(
				let(
					a = tooth_profile_cut (),
					e = helix_extrude_points ( list=a
						, height=screw_depth, pitch=screw_pitch
						, r=screw_diameter_outer/2
						, orientation=true
						, slices=slices)
				) e
				, convexity=5
			);
			
			cylinder_extend (h=screw_depth, d=screw_diameter_outer, slices=slices);
		}
		
		if (make_knurling)
		part_cut()
		for (a=[0:360/knurling_count:359])
		rotate_z (a)
		translate ([screw_diameter_outer/2+wall, 0, -shaft_bind_length_tool])
		cylinder_extend (
			  d=knurling_diameter
			, h=screw_depth+shaft_bind_length_tool+extra
			, angle=[180,90]
			, align=X+Z
			);
	}
}

