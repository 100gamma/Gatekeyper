/*
	module to generate the areas of negative space that define the cuts
*/

module cuts()
    for (n = [0:len(cuts_depth)-1])
        cut(depth=cuts_depth[n],
        	space=cuts_space[n],
            axial=cuts_axial[n],
            angle=cuts_angle[n],
            flat=cuts_flat[n]
           );