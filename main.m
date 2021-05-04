clear all;

%-----Distributed unputs
M = 4; %number of distributed inputs (cell resistance, activity ratios and flow rate)

%------ Experimental design
%--inputs
n=10; %input size
sampling = 'random'; %sampling type ('random' or 'hypercube')
%--outputs
%X: original variables samples (4xn matrix)
%E: auxiliary variables samples uniformly distributed on [-1,1] (4xn matrix)
[E,X] = experimental_design(n,sampling);

%------ Regression matrix
%--inputs
p=2; %maximum degree of polynomials allowed
u=voltage(X); %voltage calculated from original variables samples
%--outputs
%Z: regression matrix (nxP) where P=(M+p)!/M!p!
%Alpha: set of multi-indices that satisfy the requirement |α|≤p
%c: coordinates of the Legendre basis
[Z,Alpha,c] = regression_matrix(M,p,E,u);

%------ Evaluation of the PCE model
%--outputs
%U: PC evaluated model
U = zeros([1 n]);
for i=1:n
    U(1, i) = model_evaluation(c,M,E,Alpha);
end

%----- leave-one-out error
%--inputs
val_n = 10; %size of validation set
%--outputs
%ELOO,eLOO: leave-one-error before or after divided by the variance of U
%eLOO_mod: modified the error by Heuristic modification factors to avoid overfitting
%evar: mean-squared error
[ELOO,eLOO,eLOO_mod,evar] = leave_one_error(val_n,sampling,Z,c,Alpha);
