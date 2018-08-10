/*
	create the blank, make the cuts, flatten bumps between cuts
*/

module compound()
	translate([0,0,vertical_center ? profile_height/2 : 0])
    difference() {
        blank();
        cuts();
        cut_flatten();
}