clear all;

%------Physical constants
R = 8.314; %Ideal gas constant (J/K/mol)
T = 298.15; %absolute temperature (K)
F = 96485; %Faraday constant (C/mol)

%-----Known Inputs
I = 0.4; %charging current (A)
b = 0.9; %fitted constant for the flow rate
A_e = 2.236*0.4e-4; %electrode area (m^2)
A_m = 5e-4; %membrane area (m^2)
a = 4e-5; %fitted constant for the electrolyte flow rate ( (m/s)^(0.1) )
Ep0 = 0.62; %thermodynamic potential of TEMPO (V)
En0 = -0.63; %thermodynamic potential of MV (V)
kp0 = 4.2e-5; %kinetic constant of TEMPO (m/s)
kn0 = 3.3e-5; %kinetic constant of MV (m/s)

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
p=4; %maximum degree of polynomials allowed
y=voltage(X); %voltage calculated from original variables samples
%--outputs
%Z: regression matrix (nxp)
%Alpha: set of multi-indices that satisfy the requirement |α|≤p
%c: coordinates of the Legendre basis
[Z,Alpha,c] = regression_matrix(M,p,X,y);

%------ Evaluation of the PCE model
[Y] = model_evaluation(c,M,X,Alpha);

%----- leave-one-out error
[ELOO,eLOO,eLOO_mod,evar] = leave_one_error(n,sampling,Z,c,Alpha);
