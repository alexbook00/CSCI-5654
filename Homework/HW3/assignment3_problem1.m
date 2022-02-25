A_original = [
    1 -1 0 0 0 -1;
    1 0 0 -1 -1 0;
    0 0 -1 0 0 -1;
    0 -1 -1 1 0 1;
    1 0 1 0 1 1;
    -1 0 0 -1 1 -1;
];

b = [
    3;
    -1;
    -2;
    4;
    6;
    -2;
];

c_original = [
    -2 -3 -1 -1 0 1;
];

A = [A_original eye(6)];

c = [c_original zeros(1,6)];

basis0 = [3 4 5 7 8 12];

nonbasis0 = [1 2 6 9 10 11];

A_B = A(:, basis0);
A_N = A(:, nonbasis0);
c_B = c(:, basis0);
c_N = c(:, nonbasis0);

% first solve for constant column
bhat0 = A_B\b;

objVal = c_B * bhat0;

yhat = (A_B'\c_B')';
y0 = c_N - yhat * A_N;

fprintf(1, 'Constant Column: \n')
disp(bhat0)
fprintf(1, 'Objective Value: %f\n', objVal)
fprintf(1, 'Objective Row: \n')
disp(y0)

% choose entering variable (use largest negative coefficient from objective
% row)
enteringIndex = 3; % x6 has the largest positive coefficient (4)
fprintf(1, '%d is the entering variable \n', nonbasis0(enteringIndex))

% work out the column corresponding to the objective row
Aj = -A_N(:, enteringIndex);
AjHat = A_B\Aj;
fprintf(1, 'Constant Column, Column Corresponding to Entering Variable\n')
disp([bhat0, AjHat])

% to do leaving variable analysis
leavingIndex = 6;
fprintf('%d is the leaving variable\n', basis0(leavingIndex))