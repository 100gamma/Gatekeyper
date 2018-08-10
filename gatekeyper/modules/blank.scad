/* 
	module to generate extruded version of profile
	some parts of this have been removed at my lawyers insistence
*/

module blank() {
    rotate([90,0,180])
        difference() {
                linear_extrude(blank_length)
                    profile();
                rotate([0,0,profile_rotation])
                    sharpen();
        }
}