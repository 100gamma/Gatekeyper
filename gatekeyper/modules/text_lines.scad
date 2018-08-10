/*
	generate text on multiple lines
	for some reason this feature isn't built into OpenSCAD
*/

module text_lines(
                  lines, 								// number of lines
                  line_height =  2, 					// height of lines
                  line_dist =    3, 					// distance between the center of each line
                  font =         "Ubuntu:style=bold", 	// OpenSCAD font string
                  halign =       "center", 				// horizontal align
                  valign =       "center", 				// vertical align
                  centerline =   true 					// center text around middle line
                 )
    translate([0,
               centerline ?
                    ((len(lines)-1)*line_dist)/2 :
                    0,
               0])
        for (n = [0:len(lines)-1])
            translate([0,-n*line_dist,0])
            text(
                 lines[n],
                 font =      font,
                 halign =    halign,
                 valign =    valign,
                 size =      line_height
                );