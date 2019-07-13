% Use this editor as a MiniZinc scratch book

int: n = 3;
set of int: r = 1..3;

int: agatha  = 1;
int: butler  = 2;
int: charles = 3;

% Decision variables
% The two decision variables the_killer and the_victim has both the domain 1..3, i.e. the set {agatha, butler charles}.
var r: the_killer;
var r: the_victim;

% The 3x3 entries in the two matrices hates and richer are binary decision variables: 1 represents true, 0 represents false.
array[r,r] of var 0..1: hates;
array[r,r] of var 0..1: richer;

% A killer always hates, and is no richer than his victim. 
constraint  hates[the_killer, the_victim] = 1;
constraint  richer[the_killer, the_victim] = 0;

% no one is richer than him-/herself
constraint forall(i in r) (richer[i,i] = 0);
% Define richer
constraint forall(i, j in r where i != j) (richer[i,j] = 1 <-> richer[j,i] = 0);
% Charles hates no one that Agatha hates. 
constraint  forall(i in r) (hates[charles, i] = 0 <- hates[agatha, i] = 1);

% Agatha hates everybody except the butler.
constraint hates[agatha, charles] = 1;
constraint hates[agatha, agatha] = 1;
constraint hates[agatha, butler] = 0;

% The butler hates everyone not richer than Aunt Agatha.
constraint forall(i in r) (hates[butler, i] = 1 <- richer[i, agatha] = 0);

% The butler hates everyone whom Agatha hates. 
constraint forall(i in r) (hates[butler, i] = 1 <- hates[agatha, i] = 1);

% Noone hates everyone. 
constraint forall(i in r) (sum(j in r) (hates[i,j]) <= 2);

% Who killed Agatha? 
constraint the_victim = agatha;

% The following statement just states that the CP solver should use its default search method.
solve satisfy;

output [
  "the killer: ", show(the_killer), "\n",
  "the victim: ", show(the_victim),
] ++ 
["\n\nhates:"] ++
[
  if j > 1 then "" else (if i = 1 then "\nagatha:  " else (
                          if i = 2 then "\nbutler:  " else (
                            if i = 3 then "\ncharles: " else "" 
                            endif) 
                          endif) 
                         endif)
  endif  ++ 
  show(hates[i,j]) | i, j in r

] ++ 
["\n\nricher:"] ++
[
  if j > 1 then "" else (if i = 1 then "\nagatha:  " else (
                          if i = 2 then "\nbutler:  " else (
                            if i = 3 then "\ncharles: " else "" 
                            endif) 
                          endif) 
                         endif)
  endif  ++ 
 show(richer[i,j]) | i, j in r
] ++
[ "\n" ]
% ++
% [
%   "hates: "  ++ show(hates) ++  "\n" ++
%   "richer: " ++ show(richer) ++ "\n"
% ]
;
