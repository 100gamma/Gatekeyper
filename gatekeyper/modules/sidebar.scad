/*
	functions and constants for dealing with the Medeco naming convention for key pins
*/


// definitions for key pin values
K="K"; // fore left
B="B"; // fore center
Q="Q"; // fore right
M="M"; // aft left
D="D"; // aft center
S="S"; // aft right
L="L"; // left
R="R"; // right
C="C"; // center
F="F"; // fore
A="A"; // aft
N="N"; // dead center (neither fore nor aft)


nan = 0/0;

//doesn't support dead

// KBQMDS -> LCR
function datum_to_axial(c) =
    (c == K || c == M) ? L : 
    (c == B || c == D) ? C :
    (c == Q || c == S) ? R : c;

// KBQMDSLCR -> FAN
function datum_to_longitudinal(c) =
    (c == K || c == B || c == Q) ? F : 
    (c == M || c == D || c == S) ? A :
    (c == L || c == C || c == R) ? N : c;

// [KBQMDS] -> [LCR]
function axial_from_code(code) = [for (c = code) datum_to_axial(c)];

// [KBQMDS] -> [FA] 
function longitudinal_from_code(code) = [for (c = code) datum_to_longitudinal(c)];

///////////////////////////////

left_angle = 20;
center_angle = 0;
right_angle = -20;

function datum_to_angle(c) =
    datum_to_axial(c) == L ? left_angle :
    datum_to_axial(c) == C ? center_angle:
    datum_to_axial(c) == R ? right_angle : nan;

function sidebar_to_angles(code) =
    [for (letter = code) datum_to_angle(letter)];


longitudinal_offset = 1.575/2;

function datum_to_distance(c) =
	datum_to_longitudinal(c) == F ? -longitudinal_offset :
	datum_to_longitudinal(c) == A ?  longitudinal_offset : 0;


function sidebar_to_distances(code) = [for (c = code) datum_to_distance(c)];

