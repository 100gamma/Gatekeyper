/*
	module to generate the 2d profile
*/

module profile()
    rotate([0,0,profile_rotation])
                if (profile_use_rectangles)
                        translate([0,-profile_height/2,0])
                            offset(r=-profile_inset)
                                square(
                                       [profile_height * profile_rectangle_width, 
                                        profile_height],
                                       center=true
                                      );
                else
                    offset(r=-profile_inset)
                        rotate([0, profile_flip ? 180 : 0, 0])
                            resize([0, profile_height, 0], auto=true)
                                import(profile_dxf);
