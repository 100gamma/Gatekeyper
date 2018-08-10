/*
	Functions for unit conversions.
	These assume the default unit is milimeter.
*/

// abbreviations
function um(n) = n/1000;
function mm(n) = n;
function cm(n) = n*10;
function in(n) = n*25.4;


// full name
function micron(n) = um(n);
function micrometer(n) = um(n);
function milimeter(n) = mm(n);
function centimeter(n) = cm(n);
function inch(n) = in(n);
function mil(n) = in(n)/1000;
function thou(n) = in(n)/1000;

// full name plural
function microns(n) = um(n);
function micrometers(n) = um(n);
function milimeters(n) = mm(n);
function centimeters(n) = cm(n);
function inches(n) = in(n);
function mils(n) = mil(n);
function thous(n) = thou(n);