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
y=voltage(X); %voltage calculated from original variables samples
%--outputs
%Z: regression matrix (nxp)
%Alpha: set of multi-indices that satisfy the requirement |α|≤p
%c: coordinates of the Legendre basis
[Z,Alpha,c] = regression_matrix(M,p,X,y);

%------ Evaluation of the PCE model
%--outputs
%Y: PC evaluated model
[Y] = model_evaluation(c,M,X,Alpha);

%----- leave-one-out error
%--inputs
%val_n = 10; %size of validation set
%--outputs
%ELOO,eLOO: leave-one-error before or after divided by the variance of U
%eLOO_mod: modified the error by Heuristic modification factors to avoid overfitting
%evar: mean-squared error
%[ELOO,eLOO,eLOO_mod,evar] = leave_one_error(val_n,sampling,Z,c,Alpha);