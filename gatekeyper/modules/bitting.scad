/*
	array of depths for each cut value
*/

depths = 
         [
/* 0 */    0,
/* 1 */    0.712,
/* 2 */    1.6262,
/* 3 */    2.0612,
/* 4 */    2.6962,
/* 5 */    3.3312,
/* 6 */    4.0
         ];

// depths, but zero element is guaranteed to be zero depth
depths_true_zero = concat(0,depths);


// round cut value down to nearest neighbor
function depth_floor(n) =
    depths_true_zero[n+1];


// interpolate between cut values
function depth_interp(n) =
    lookup(n,
        [for (n = [-1:len(depths)-1]) [n, depth_floor(n)]]);


// round cut value to nearest neighbor
function depth_round(n) =
    depth_floor(round(n));


// round cut value up to nearest neighbor
function depth_ceil(n) =
    depth_floor(ceil(n));


// apply these functions to vectors
// holy shit OpenSCAD needs to implement higher order functions
// please
function depths_floor (N) = [for (n = N) depth_floor (n)];
function depths_interp(N) = [for (n = N) depth_interp(n)];
function depths_round (N) = [for (n = N) depth_round (n)];
function depths_ceil  (N) = [for (n = N) depth_ceil  (n)];
function depths(N)		  = [for (n = N) depth_interp(n)];