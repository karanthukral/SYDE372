clear all
close all

mu_a = [5 10];
covar_a = [8 0; 0 4];
n_a = 200;

mu_b = [10 15];
covar_b = [8 0; 0 4];
n_b = 200;

mu_c = [5 10];
covar_c = [8 4; 4 40];
n_c = 100;

mu_d = [15 10];
covar_d = [8 0; 0 8];
n_d = 200;

mu_e = [10 5];
covar_e = [10 -5; -5 20];
n_e = 150;

ClassA = struct('mean',mu_a, 'covar',covar_a, 'n',n_a)
ClassB = struct('mean',mu_b, 'covar',covar_b, 'n',n_b)
ClassC = struct('mean',mu_c, 'covar',covar_c, 'n',n_c)
ClassD = struct('mean',mu_d, 'covar',covar_d, 'n',n_d)
ClassE = struct('mean',mu_e, 'covar',covar_e, 'n',n_e)

A = gaussianTransform(ClassA.mean, ClassA.covar)
B = gaussianTransform(ClassB.mean, ClassB.covar);
C = gaussianTransform(ClassC.mean, ClassC.covar);
D = gaussianTransform(ClassD.mean, ClassD.covar);
E = gaussianTransform(ClassE.mean, ClassE.covar);

[A_x, A_y] = contourCalculation(ClassA.mean, ClassA.covar);
[B_x, B_y] = contourCalculation(ClassB.mean, ClassB.covar);
[C_x, C_y] = contourCalculation(ClassC.mean, ClassC.covar);
[D_x, D_y] = contourCalculation(ClassD.mean, ClassD.covar);
[E_x, E_y] = contourCalculation(ClassE.mean, ClassE.covar);

ClassA.gauss = A;
ClassB.gauss = B;
ClassC.gauss = C;
ClassD.gauss = D;
ClassE.gauss = E;

% scatter(A(:,1),A(:,2),'filled');
% hold on
% plot(A_x,A_y,'LineWidth',2);

MAP([10,5], [ClassC, ClassD, ClassE])