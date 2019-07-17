int: n = 5;
% MiniZinc uses sets to define ranges.
set of int: D = 0..n-1;
array[D] of var D: series;

constraint 
  forall(i in D) (
    series[i] = sum(j in D)(series[j]==i)
    );

% In configuration click User-defined behavior, check Print intermediate solutions. Stop after 0 (which means don't stop) to get all solutions.
solve satisfy;   

output [ "\nseries = \(series);\n\n" ] ;


/* From Dynamic Optimization course Week 3 Video CP-3 2:00

int n = 5;
range D = 0..n-1;
var{int} series[D] in D;
solve {
   forall(i in D)
     series[i] = sum(j in D)(series[j]=i);
}

*/