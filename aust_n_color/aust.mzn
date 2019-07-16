% Listing 2.1.1 A MiniZinc model aust.mzn for colouring the states and territories in Australia¶
% Colouring Australia using nc colours

% int: nc = 3;

% Using an enum instead of integers.
enum Color = {red, green, blue};

% var 1..nc: wa;   var 1..nc: nt;  var 1..nc: sa;   var 1..nc: q;
% var 1..nc: nsw;  var 1..nc: v;   var 1..nc: t;

var Color: wa;   var Color: nt;  var Color: sa;   var Color: q;
var Color: nsw;  var Color: v;   var Color: t;

constraint wa != nt;
constraint wa != sa;
constraint nt != sa;
constraint nt != q;
constraint sa != q;
constraint sa != nsw;
constraint sa != v;
constraint q != nsw;
constraint nsw != v;

% Satisfies the constraints without using a solver.
% solve satisfy;

output ["wa=\(wa)\t nt=\(nt)\t sa=\(sa)\n",
        "q=\(q)\t nsw=\(nsw)\t v=\(v)\n",
         "t=", show(t),  "\n"];