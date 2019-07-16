int: n = 4;
array[0..n-1] of var 0..n: s;

constraint forall(i in 0..n-1) (
   s[i] = (sum(j in 0..n-1)(s[j]=i)));

% In configuration include -a as an additional command line argument.
solve satisfy;   

output [ "s = \(s);\n" ] ;


/* From Dynamic optimization course 2:00

int n = 5;
range D = 0..n-1;
var{int} series[D] in D;
solve {
   forall(k in D)
   series[k] = sum(i in D) (series[i]=k);
}

*/