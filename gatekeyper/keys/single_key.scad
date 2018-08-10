/*
    this file generates an example key
    
    it uses the Yale 8 keyway as an example,
but the default measurements are not tuned for Yale locks.

    you will need to provide measurements for the key/lock you are modeling
    
    sorry for the poor documentation, this is still a work-in-progress
*/

include <../modules/blade.scad>
include <../modules/units.scad>
include <../modules/bitting.scad>
include <../modules/sidebar.scad>
include <../modules/bow.scad>
include <../modules/shoulder.scad>
include <../modules/utils.scad>



profile_height = 6.576;
profile_inset = 0.12;



sidebar_code = [L,R,C,L,R];
d = depths([3,1,3,3,7]);

s = gen_spacing(6.2, 4.315) + sidebar_to_distances(sidebar_code);
a = sidebar_to_angles(sidebar_code);

centerpoint = 0.2;




bow_dimensions = [15,15];
bow_corner_radius = 2;

sh_top_height = 3/4;

sh_length = 3;
sh_width = profile_height - profile_inset*2 + sh_top_height;

// shoulder radius so that shoulder is tangent with corner of bow
sh_r = (bow_dimensions[1]-bow_corner_radius*2-sh_width)/2;
sh_thickness = 4;
sh_clip = 0;

bow_text = ["DO NOT","DUPLICATE","LOL"];



union() {
    translate([2/10,0,profile_height/2])
        blade(
            cuts_depth =				d,
            cuts_space =				s,
            cuts_axial = 				a,
            tip_angle_bottom =			0,
            tip_angle_top = 45,
            tip_offset_bottom = centerpoint, 
            tip_offset_top = -centerpoint,
            blank_length =				27,
            remove_bumps =				false,
            remove_tip =				false,
            remove_shoulder =			false,
            profile_use_rectangles =	false,
            removal_padding=3/4,
            profile_inset = profile_inset,
            profile_height = profile_height,
            cutout_active = false,
            cutout_to_shoulder=14.2,
            cutout_side=right,
            profile_flip=true,
            cutout_y=3,
            cutout_x=4/10,
            profile_dxf="example_keyway.dxf"
        );


    color("blue")
    translate([0,-sh_length,sh_top_height/2])
        shoulder_stop(
            width=sh_width,
            height=sh_length,
            r=sh_r,
            thickness=sh_thickness,
            clip=sh_clip
        );


    translate([0,-sh_length,sh_top_height/2])
        bow(
            d=bow_dimensions,
            r=bow_corner_radius,
            inset=1.5,
            in_h = 4,
            out_h=5,
            text_rotation=90,
            line_height=1.5,
            line_dist=3.5,
            lines=bow_text
        );
}