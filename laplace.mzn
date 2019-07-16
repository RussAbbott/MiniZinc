int: w = 6;
int: h = 4;

% arraydec
set of int: HEIGHT = 0..h;
set of int: CHEIGHT = 1..h-1;
set of int: WIDTH = 0..w;
set of int: CWIDTH = 1..w-1;  
array[HEIGHT,WIDTH] of var float: t; % temperature at point (i,j)
var float: left;   % left   edge temperature
var float: right;  % right  edge temperature
var float: top;    % top    edge temperature
var float: bottom; % bottom edge temperature

% equation
% Laplace equation: each internal temp. is average of its neighbours
constraint forall(i in CHEIGHT, j in CWIDTH)(
              4.0*t[i,j] = t[i-1,j] + t[i,j-1] + t[i+1,j] + t[i,j+1]);
% sides
% edge constraints
constraint forall(i in CHEIGHT)(t[i,0] = left);
constraint forall(i in CHEIGHT)(t[i,w] = right);
constraint forall(j in WIDTH)(t[0,j] = top);
constraint forall(j in WIDTH)(t[h,j] = bottom);
% corners
% corner constraints
% Don't need these if we make the top and bottom corners the same as the top and bottom rows.
% Do that by using WIDTH instead of CWIDTH in the constraints above. Could do something similar
% by using HEIGHT instead of CHEIGHT. But can't do both since the top corners would be constrained
% to be both 0 and 100.
% constraint t[0,0]=0.0;
% constraint t[0,w]=0.0;
% constraint t[h,0]=0.0;
% constraint t[h,w]=0.0; 
left = 0.0;
right = 0.0;
top = 100.0;
bottom = 0.0;

solve satisfy;

% The MiniZinc version says "if j == h", but it should be "if j == w".
output [ show_float(6, 2, t[i,j]) ++ 
         if j == w then "\n" else " " endif |
         i in 0..h, j in WIDTH
];
