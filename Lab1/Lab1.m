clear all
close all

% Constant Declarations

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

contourSize = 10000;

% Class Definitions
ClassA = struct('mean',mu_a, 'covar',covar_a, 'n',n_a)
ClassB = struct('mean',mu_b, 'covar',covar_b, 'n',n_b)
ClassC = struct('mean',mu_c, 'covar',covar_c, 'n',n_c)
ClassD = struct('mean',mu_d, 'covar',covar_d, 'n',n_d)
ClassE = struct('mean',mu_e, 'covar',covar_e, 'n',n_e)

% Cluster Generation
A = gaussianTransform(randn(ClassA.n,2), ClassA.mean, ClassA.covar)
B = gaussianTransform(randn(ClassB.n,2), ClassB.mean, ClassB.covar);
C = gaussianTransform(randn(ClassC.n,2), ClassC.mean, ClassC.covar);
D = gaussianTransform(randn(ClassD.n,2), ClassD.mean, ClassD.covar);
E = gaussianTransform(randn(ClassE.n,2), ClassE.mean, ClassE.covar);

ClassA.gauss = A;
ClassB.gauss = B;
ClassC.gauss = C;
ClassD.gauss = D;
ClassE.gauss = E;

% Base contour creation which can be transformed to suit each class
contour = [cos((1:contourSize)/contourSize*2*pi());sin((1:contourSize)/contourSize*2*pi())]';

% Unit contours for each class
A_contour = gaussianTransform(contour,mu_a,covar_a);
B_contour = gaussianTransform(contour,mu_b,covar_b);
C_contour = gaussianTransform(contour,mu_c,covar_c);
D_contour = gaussianTransform(contour,mu_d,covar_d);
E_contour = gaussianTransform(contour,mu_e,covar_e);

% Decison boundary grids
X = linspace(-5,25,100);
Y = linspace(0,30,100);
 
% Decision Boundry Generation by classification of each point in the grid 
grid.micd = zeros(length(Y),length(X));
grid.map = zeros(length(Y),length(X));
grid.med = zeros(length(Y),length(X));
 
grid2.micd = zeros(length(Y),length(X));
grid2.map = zeros(length(Y),length(X));
grid2.med = zeros(length(Y),length(X));
for j = 1:length(Y)
    for i=1:length(X)
        grid.micd(j,i)= MICD([X(i),Y(j)],[ClassA ClassB]);
        grid.map(j,i) = MAP([X(i),Y(j)],[ClassA ClassB]);
        grid.med(j,i) = MED([X(i),Y(j)],[ClassA ClassB]);
       
        grid2.micd(j,i)= MICD([X(i),Y(j),],[ClassC ClassD ClassE]);
        grid2.map(j,i)= MAP([X(i),Y(j),],[ClassC ClassD ClassE]);
        grid2.med(j,i)= MED([X(i),Y(j),],[ClassC ClassD ClassE]);
    end
end
 
% Plots

% Scatter Plot Class A and Class B
figure;
scatter(A(:,1),A(:,2),'filled','r');
hold on;
scatter(B(:,1),B(:,2),'filled','b');
hold on;
plot (A_contour(:,1), A_contour(:,2), 'r-');
hold on;
plot (B_contour(:,1), B_contour(:,2), 'b-');

% Scatter Plot Class C, Class D and Class E
figure;
scatter(C(:,1),C(:,2),'filled','r');
hold on;
scatter(D(:,1),D(:,2),'filled','b');
hold on;
scatter(E(:,1),E(:,2),'filled','g');
hold on;
plot (C_contour(:,1), C_contour(:,2), 'r-');
hold on;
plot (D_contour(:,1), D_contour(:,2), 'b-');
hold on;
plot (E_contour(:,1), E_contour(:,2), 'g-');

% Classification Plots
figure;
scatter(A(:,1),A(:,2),[],'r','.');
hold on
scatter(B(:,1),B(:,2),[],'b','.');
hold on
contour(X,Y,grid.micd,1,'-r');
hold on
contour(X,Y,grid.map,1,'-b');
hold on
contour(X,Y,grid.med,1,'-g');
 
 
figure;
scatter(C(:,1),C(:,2),[],'r','.');
hold on
scatter(D(:,1),D(:,2),[],'b','.');
hold on
scatter(E(:,1),E(:,2),[],'black','.');
hold on
contour(X,Y,grid2.micd,2,'-r');
hold on
contour(X,Y,grid2.map,2,'-b');
hold on
contour(X,Y,grid2.med,2,'-g');
 
 
 
% Classification of distributions for confusion matrix
 
A = [A , zeros(length(A),1)];
B = [B , zeros(length(B),1)];
C = [C , zeros(length(C),1)];
D = [D , zeros(length(D),1)];
E = [E , zeros(length(E),1)];
 
for j=1:length(A)
    A(j,3) = MICD([A(j,1),A(j,2)],[ClassA ClassB]);
    B(j,3) = MICD([B(j,1),B(j,2)],[ClassA ClassB]);
    C(j,3) = MICD([C(j,1),C(j,2)],[ClassC ClassD ClassE]);
    D(j,3) = MICD([D(j,1),D(j,2)],[ClassC ClassD ClassE]);
    E(j,3) = MICD([E(j,1),E(j,2)],[ClassC ClassD ClassE]);
end