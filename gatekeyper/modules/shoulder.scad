/*
	modue for creating shoulder stop
*/


// bump up resolution
$fn = 100;


module shoulder_stop(width,		// width of shoulder stop
					 height,	// height of shoulder stop
					 r,			// radius of circles for flared base
					 thickness,	// thickness of shoulder stop
					 clip=0.5	// how much to remove from the ends of the flared base
				 ) {
    sq_w = r*4 + width;  
    module bite() {
        color("green", 1/2)
        union() {
            hull() {
                circle(r);
                translate([0,height])
                    circle(r);
            }
            translate([-r,-r,0])
                square(r);
            }
        }
    rotate([0,90,0])
        translate([0,0,-thickness/2])
            linear_extrude(thickness)
                translate([-sq_w/2,0,0])
                    difference() {
                        square([sq_w,height]);
                        translate([r,r,0])
                            bite();
                        translate([sq_w-r,r,0])
                            rotate([180,0,180])
                                bite();
                        translate([(sq_w/2)-width*1.5-r+clip,0,0])
                            square([width,height]);
                        translate([sq_w-r-clip,0,0])
                            square([width,height]);
                    }
}

//shoulder_stop(width=2, height=5, r=1, thickness=1);