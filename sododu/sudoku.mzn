

include "alldifferent.mzn";

int: S;
int: N = S * S;

set of int: PuzzleRange = 1..N;

array[PuzzleRange, PuzzleRange] of var PuzzleRange: puzzle;

% Contains the starting board: start.
include "sudoku.dzn";
% in start, 0 = empty
array[PuzzleRange, PuzzleRange] of 0..N: start; 
% copy fromt start to puzzle board
constraint forall(i, j in PuzzleRange)(
    if start[i, j] > 0 then puzzle[i, j] = start[i, j] else true endif );

% All different in rows 
constraint forall (i in PuzzleRange) (
                   alldifferent( [ puzzle[i, j] | j in PuzzleRange ]) ); 

% All different in columns.
constraint forall (j in PuzzleRange) (
                   alldifferent( [ puzzle[i, j] | i in PuzzleRange ]) ); 

% All different in sub-squares:
set of int: SubSquareRange = 1..S;
constraint
        forall (SubSquareRow, SubSquareCol in SubSquareRange)(
                alldifferent( [ puzzle[(SubSquareRow-1)*S + row, (SubSquareCol-1)*S + col] |
                                        row, col in SubSquareRange ] ) );

solve satisfy;

% Add 1 to field_size to leave a space between cells.
int: field_size = 1 + ceil(log(10.0, int2float(N))); % nbr of digits for each cell value

output  ["\n"] ++ 
        [if start[i, j] == 0 then " ." else show_int(field_size, start[i, j]) endif ++ 
         % Leave extra space between sub-squares.
         if j mod S == 0 then " " else "" endif ++
         if i == 100 then "" 
                   else % In other than the last row:
                        % Newline after each row.
                        if j == N then "\n" else "" endif ++
                        % Add additional newline between sub-squares.
                        if j == N /\ i mod S == 0 then "\n" else "" endif 
         endif
         | i, j in PuzzleRange ];
         
output  ["\n"] ++ 
        [show_int(field_size, puzzle[i, j]) ++ 
         % Leave extra space between sub-squares.
         if j mod S == 0 then " " else "" endif ++
         if i == 100 then "" 
                   else % In other than the last row:
                        % Newline after each row.
                        if j == N then "\n" else "" endif ++
                        % Add additional newline between sub-squares.
                        if j == N /\ i mod S == 0 then "\n" else "" endif 
         endif
         | i, j in PuzzleRange ];
         
