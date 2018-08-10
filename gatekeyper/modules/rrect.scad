/*
	module to generate rectangle with rounded corners
*/

module rrect(d, r) {
    minr = min(d[0], d[1])/2;
    if (r < minr)
        offset(r)
            offset(-r)
                square(d);
    else
        hull() {
            translate([minr,minr,0])
                circle(minr);
            translate(d[0] > d[1] ? [d[0]-minr,minr,0] : [minr,d[1]-minr,0])
                circle(minr);   
        }
}
