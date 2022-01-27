profit_per_unit = [
    1.451;
    2.683;
    5.898;
    2.102;
    5.709;
    4.519; 
    7.176; 
    6.075;
    5.718; 
    7.442; 
    1.234; 
    4.68; 
    7.229;
    9.589; 
    6.497;
];

price_per_unit = [
    2.563; 
    4.307;
    6.422; 
    3.488; 
    6.581; 
    8.993; 
    11.481;
    11.73; 
    9.27; 
    10.16;
    1.961;
    9.3;
    11.672;
    10.877;
    12.137;
];

risk_category = [
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    1 0 0 0;
    0 1 0 0;
    0 0 0 1;
    0 0 1 0;
    0 1 0 0;
    0 1 0 0;
    1 0 0 0;
    0 0 1 0;
    0 0 0 1;
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
];

investment_market = [
    1 0 0 0;
    0 1 0 0;
    0 1 0 0;
    0 0 1 0;
    0 1 0 0;
    0 1 0 0;
    0 1 0 0;
    1 0 0 0;
    0 0 1 0;
    0 0 0 1;
    1 0 0 0;
    0 0 0 1;
    0 0 1 0;
    0 0 0 1;
    0 1 0 0;
];

eco_friendly = [
    1;
    1;
    1;
    0;
    0;
    1;
    1;
    1;
    1;
    1;
    1;
    0;
    1;
    0;
    0;
];

risk_category_min = [
    1500;
    4500;
    1000;
    500;
];

risk_category_max = [
    3500;
    6500;
    3000;
    2500;
];

investment_market_min = [
    0;
    0;
    0;
    0;
];

investment_market_max = [
    3000;
    4000;
    5000;
    7000;
];

x = optimvar('x', 15, 'LowerBound', zeros(15,1));

prob = optimproblem('Objective', profit_per_unit.'*x, 'ObjectiveSense', 'max');

prob.Constraints.c1 = (risk_category.*price_per_unit).'*x >= risk_category_min;
prob.Constraints.c2 = (risk_category.*price_per_unit).'*x <= risk_category_max;
prob.Constraints.c3 = (investment_market.*price_per_unit).'*x >= investment_market_min;
prob.Constraints.c4 = (investment_market.*price_per_unit).'*x <= investment_market_max;
prob.Constraints.c5 = (eco_friendly.*price_per_unit).'*x >= 2000;
prob.Constraints.c6 = (eco_friendly.*price_per_unit).'*x <= 10000;
prob.Constraints.c7 = price_per_unit'*x <= 10000;

problem = prob2struct(prob);

[sol,fval,exitflag,output] = linprog(problem);

sol
profit_per_unit.'*sol