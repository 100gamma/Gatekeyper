/*
	module to generate the bow
*/

$fn = 100;

include <text_lines.scad>
include <rrect.scad>

module bow(
            d=[10,10],
            r=2,
            inset=2,
            in_h=1/2,
            out_h=1,
            text_rotation=0,
            lines=["top","kek"],
            line_height=2,
            line_dist=3,
            font="Ubuntu:style=bold",
            halign="center",
            valign="center",
            centerline=true
           ) {
               
    module text_face()
        linear_extrude(out_h/2)
        text_lines(
                  lines,
                  line_height,
                  line_dist,
                  font,
                  halign,
                  valign,
                  centerline
                 );
        
    rotate([0,90,180]) {
        translate([-d[0]/2,0,0]) {
            translate([0,0,-out_h/2])
            difference() {
                linear_extrude(out_h)
                    rrect([d[0],d[1]],r);
                translate([0,0,-out_h/2])
                    linear_extrude(out_h*2)
                        offset(-inset)
                            rrect([d[0],d[1]],r);
            }
            color("red")
            translate([0,0,-in_h/2])
                linear_extrude(in_h)
                    offset(-inset/2)
                        rrect([d[0],d[1]],r);
        }
 
    translate([0,d[1]/2,0])
        rotate([0,0,text_rotation]) {
            text_face();
                rotate([0,180,0])
                    text_face();
        }
    }
}










