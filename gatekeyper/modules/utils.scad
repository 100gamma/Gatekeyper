/*
	General purpose stuff
*/


// variables for left/right (duh)
left = true;
right = false;


// generate an vector of spacings.
// element 0 is for the cut closest to the shoulder
// `face` is the distance between the shoulder and the first cut
// `space` is the distance between subsequent cuts
// `num` is the number of items to generate
// probably just keep this set to a big number
function gen_spacing(face, space, num=100) =
    [for (n = [0:num-1]) n*space+face];


// add a constant to every element in a vector 
function add_offset(N, o) = [for (n = N) n+o];


// generate a vector containing `item` repeated `N` times
function nfill(item, N) = [for (n = [1:N]) item];

// swap x and y values in vector
function rotate_array(a) =
    [for (x = [0:len(a[0])-1]) 
        [for (y = [0:len(a)-1])
            a[y][x]
        ]
    ];


// get an interpolated value between start and end that is `n/N` in between. 
function single_interp(start, end, n, N) = 
        N == 1 ? 
            start :
            (start + (n/(N-1))*(end-start));


// generate a vector starting at `start` and ramping up to `end` with `n` elements
function i1d(start, end, n) =
        [for (i = [0:n-1]) single_interp(start, end, i, n)];


// same thing as i1d() but in 2d
function i2d(start, end, n) = 
        rotate_array(
            [for (p = rotate_array([start,end]))
                i1d(p[0], p[1], n)]
        );
