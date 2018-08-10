/*
	module to to generate the area of negative space used to make the tip nice and pointy
*/

module sharpen() {
    translate([-profile_height/2+profile_inset,
               -profile_height/2 + tip_offset_top*profile_height,
                blank_length])
        rotate([-tip_angle_top,0,0])
            cube(profile_height-profile_inset*2);
    translate([profile_height/2-profile_inset,
              -profile_height/2 - tip_offset_bottom*profile_height,
               blank_length])
        rotate([-tip_angle_bottom,0,180])
            cube(profile_height-profile_inset*2);
}