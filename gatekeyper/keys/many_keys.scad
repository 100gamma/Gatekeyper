/*
    this file creates a lot of keys
    
    every parameter for each key can be gradually changed from one side to the other
    
*/

include <../modules/blade.scad>
include <../modules/units.scad>
include <../modules/bitting.scad>
include <../modules/sidebar.scad>
include <../modules/bow.scad>
include <../modules/shoulder.scad>
include <../modules/utils.scad>

function i1dn(a, b) = i1d(a, b, num_keys);
function i2dn(a, b) = i2d(a, b, num_keys);
function kfill(n) = nfill(n, num_keys);


num_keys = 7;

cuts_depth_ = kfill([0,0,0,0,0],[6,6,6,6,6]);

colors = i2dn([0.7,0.2,0.6],[1,0.5,0]);


profile_insets = i1d(0,0.4, num_keys);

module intermediate_blade(n)
	color(colors[n])
	blade(
		vertical_center = 			true,
		profile_use_rectangles = 	false, 
		cuts_depth = 				cuts_depth_[n],
        profile_inset =             profile_insets[n]
	);



module blades()
	for (n = [0:num_keys-1])
		translate([n*center_dist,0,0])
		rotate([90,0,0])
			intermediate_blade(n);		


center_dist = 10;
base_thickness = 3;
base_width = 10;


module base()
	translate([-center_dist/2,-base_width/2,-base_thickness])
		cube([center_dist*(num_keys-1)+center_dist, base_width, base_thickness]);

module score_polygon()
	circle(1);

module scoring()
	for (n = [0:num_keys])
		translate([n*center_dist-center_dist/2,base_width,0])
			rotate([90,0,0])
				linear_extrude(base_width*2)
					score_polygon();


translate([(-num_keys+1)*center_dist/2,0,base_thickness])
difference() {
	union() {
		blades();
		base();
	}
	scoring();
}