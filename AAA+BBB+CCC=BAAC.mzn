% Use this editor as a MiniZinc scratch book
% 
% AAA + BBB + CCC = BAAC in MiniZinc.
% 
% https://mindyourdecisions.com/blog/2017/12/27/puzzle-if-aaa-bbb-ccc-baac-what-are-a-b-and-c/
% """
% If AAA + BBB + CCC = BAAC, What Are A, B, And C?
% """

% 
% This MiniZinc model was created by Hakan Kjellerstrand, hakank@gmail.com
% See also my MiniZinc page: http://www.hakank.org/minizinc/
%

include "globals.mzn"; 

var 1..9: A;
var 1..9: B;
var 1..9: C;

var int: AAA = A*111; % = A*100 + A*10 + A
var int: BBB = B*111; % = B*100 + B*10 + B
var int: CCC = C*111; % = C*100 + C*10 + C
var int: BAAC = B*1000+A*100+A*10+C;

constraint BAAC = AAA+BBB+CCC;
constraint all_different([A,B,C]);

solve satisfy;
% solve :: int_search(x, first_fail, indomain_min, complete) satisfy;


output ["\n A = \(A); ", " B = \(B); ", " C = \(C); \n\n"];
output [" A = \(A):\t \(A)\(A)\(A)\n"];
output [" B = \(B):\t \(B)\(B)\(B)\n"];
output [" C = \(C):\t+\(C)\(C)\(C)\n"];
output ["\t", concat(["-" | i in 1..4]), "\n"];
output ["        \(B)\(A)\(A)\(C)\n\n"];

