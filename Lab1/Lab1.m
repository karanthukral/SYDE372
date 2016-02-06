clear all
close all

mu_a = [5 10];
covar_a = [8 2; 2 4];

mu_b = [10 15];
covar_b = [8 2; 2 4];

mu_c = [5 10];
covar_c = [8 4; 4 40];

mu_d = [15 10];
covar_d = [8 0; 0 8];

mu_e = [10 5];
covar_e = [10 -5; -5 20];

A = gaussianTransform(mu_a, covar_a);
B = gaussianTransform(mu_b, covar_b);
C = gaussianTransform(mu_c, covar_c);
D = gaussianTransform(mu_d, covar_d);
E = gaussianTransform(mu_e, covar_e);

[A_x, A_y] = contourCalculation(mu_a, covar_a);
[B_x, B_y] = contourCalculation(mu_b, covar_b);
[C_x, C_y] = contourCalculation(mu_c, covar_c);
[D_x, D_y] = contourCalculation(mu_d, covar_d);
[E_x, E_y] = contourCalculation(mu_e, covar_e);

scatter(A(:,1),A(:,2),'filled');
hold on
plot(A_x,A_y,'LineWidth',2);