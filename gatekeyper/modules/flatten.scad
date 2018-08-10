/* 
	module to flatten the bumps between cuts
	this is to make the key easier to insert
*/

num_cuts = len(cuts_depth);

cuts_depth_with_endpoints = concat(0, cuts_depth, 0);
spacing_mm_with_endpoints = concat(0, cuts_space, blank_length);

module flatten_connect(cut, neighbor) {
    // cuts start at 1, shoulder is 0
    cutout_width = 4;
    delta = spacing_mm_with_endpoints[neighbor] - spacing_mm_with_endpoints[cut];
    left = delta < 0;
    width = (neighbor == 0 || neighbor == num_cuts+1) ? abs(delta)*2 : abs(delta);
    translate([0,spacing_mm_with_endpoints[cut],-cuts_depth_with_endpoints[cut]])
        rotate([0,0,left ? 180 : 0])
            translate([-cutout_width/2,0,0])
                cube([cutout_width,width,profile_height]);    
}

module cut_flatten_bumps()
    for (n = [1:num_cuts]) {
        b = cuts_depth_with_endpoints[n];
        b_r = cuts_depth_with_endpoints[n+1];
        b_l = cuts_depth_with_endpoints[n-1];
        if (b <= b_r)
            //color([0,0,1,0.5])
            flatten_connect(n, n+1);
        if (b <= b_l)
            //color([1,0,0,0.5])
            flatten_connect(n, n-1);
    }

module cut_flatten_tip()
    //color([0,1,0,0.5])
    flatten_connect(num_cuts, num_cuts+1);

module cut_flatten_shoulder()
    //color([0,1,0,0.5])
    flatten_connect(1, 0);


module cut_flatten() {
    translate([0,0,removal_padding]) {
        if (remove_bumps)
            cut_flatten_bumps();
        if (remove_tip)
            cut_flatten_tip();
        if (remove_shoulder)
            cut_flatten_shoulder();
    }
}