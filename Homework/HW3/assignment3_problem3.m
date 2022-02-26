A_original = [
    1 -2 1;
    1 0 2;
    -1 1 0;
    0 2 1;
    1 0 1;
];

b = [
    0;
    3;
    0;
    3;
    5;
];

A = [A_original eye(5)];

basis0 = [1 2 5 6 8];

A_B = A(:, basis0);
disp(inv(A_B))