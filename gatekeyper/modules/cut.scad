/*
	module defining cutout for cut
*/


module cut(depth=0,	// how far below the y axis the bottom of the cut is
		   space=0,	// how far away from the shoulder the cut is
		   axial=0,	// axial rotation of the cut
		   flat=0,	// size of the plateau at the bottom of the cut
		   angle=90	// angle of the cut (this does not change depending on the size of the plateau)
		   ) {
    s = sin(90-(angle/2));
    c = cos(90-(angle/2));
    h = profile_height*2;
    rotate([90,0,0])
        translate([0,-depth, -space])
            rotate([0,axial+90,0])
            translate([0,0,-h])
        color([140/255,0,1,1])
        linear_extrude(h*2)
                    polygon([
                             [ flat/2,0],
                             [-flat/2,0],
                             [-c/s*h - flat/2,h],
                             [ c/s*h + flat/2,h]
                            ]);
}