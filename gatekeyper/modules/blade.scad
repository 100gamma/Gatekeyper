/*
	create blade of key
*/

module blade(
				// location of dxf file containing profile
                profile_dxf =               "example_keyway.dxf",
                // how much material to remove from the edges of the profile
                profile_inset =             0,
                // horizontally flip the profile
                profile_flip =              false,
                // distance between top and bottom of profile
                profile_height =            7,
                // degrees to rotate profile (without rotating cuts)
                profile_rotation =          0,
                // distance from shoulder to tip
                blank_length =              30,
                // vector of depths for each cut, starting closest to shoulder
                cuts_depth =                [2.80, 3.43, 1.53, 2.16, 3.43],
                // vector of spacings for each cut, starting closest to shoulder
                cuts_space =                [6.2, 10.52, 14.84, 19.16, 23.48],
                // vector of axial rotations for each cut, starting closest to shoulder
                cuts_axial =                nfill(0, 100),
                // vector of plateau sizes for each cut, starting closest to shoulder
                cuts_flat =                 nfill(38/100,100),
                // vector of angles for each cut, starting closest to shoulder
                cuts_angle =                nfill(90, 100),
                // top angle of tip of key
                tip_angle_top =             45,
                // bottom angle of tip of key
                tip_angle_bottom =          45,
                // how far up to move the top angle
                tip_offset_top =            0,
                // how far down to move the bottom angle
                tip_offset_bottom =         0,
                // remove extraneous material between cuts to strengthen the key and make it insert more easily
                remove_bumps =              false,
                // same thing but the last bump
                remove_tip =                false,
                // same thing but the first bump
                remove_shoulder =           false,
                // how much bump material to leave
                removal_padding =           0.5,
                // turn the profile into a rectangle (useful for testing)
                profile_use_rectangles =    true,
                // width of aforementioned rectangle
                profile_rectangle_width =   0.5,
                // center blade vertically with respect to y axis
                vertical_center =           false
            ) {
    include <profile.scad>
    include <sharpen.scad>
    include <blank.scad>
    include <cut.scad>
    include <flatten.scad>
    include <cuts.scad>
    include <compound.scad>
    compound();    
}

