clear all;

%-----Distributed unputs
M = 4; %number of distributed inputs (cell resistance, activity ratios and flow rate)

%------ Experimental design
%--inputs
n=10000; %input size
sampling = 'random'; %sampling type ('random' or 'hypercube')
%--outputs
%X: original variables samples (Mxn matrix)
%E: auxiliary variables samples uniformly distributed on [-1,1] (Mxn matrix)
[E,X] = experimental_design(n,sampling);

%------ Regression matrix
%--inputs
p=4; %maximum degree of polynomials allowed
u=voltage(X); %voltage calculated from original variables samples
mean_u = mean(u);
variance_u = var(u);
%--outputs
%Z: regression matrix (nxP) where P=(M+p)!/M!p!
%Alpha: set of multi-indices that satisfy the requirement |α|≤p
%c: coordinates of the Legendre basis
[Z,Alpha,c] = regression_matrix(M,p,E,u);

%------ Evaluation of the PCE model
%--outputs
%U: voltage from PCE-evaluated model
U = zeros([1 n]);
for i=1:n
    U(1, i) = model_evaluation(c,M,E(:,i),Alpha);
end
mean_U = mean(U);
variance_U = var(U);

%----- leave-one-out error
%--outputs
%ELOO,eLOO: leave-one-out error before or after divided by the variance of U
%evar: mean-squared error
[ELOO,eLOO,evar] = leave_one_out(n,Z,u,U);

mean = mean(U)/mean(u)-1;
variance = var(U)/var(u)-1;



