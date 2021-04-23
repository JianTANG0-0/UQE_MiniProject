clear all;

%------Physical constants
R = 8.314; %Ideal gas constant (J/K/mol)
T = 298.15; %absolute temperature (K)
F = 96485; %Faraday constant (C/mol)

%-----Known Inputs
I = 0.4; %charging current in A
b = 0.9; %fitted constant for the flow rate
A = 2.236*0.4e-4; %electrode area (m^2)
a = A*4e-5; %fitted constant for the electrolyte flow rate
I0 = 0.2; %reference current (A)
Ep0 = 0.62; %thermodynamic potential of TEMPO (V)
En0 = -0.63; %thermodynamic potential of MV (V)

%------ Distributed inputs
N=10; %input size
%---Cell resistance

%---Thermodynamic potentials (mV)
mGammap=610; %mean
sGammap=20; %var
muGammap = log(mGammap^2/sqrt(sGammap+mGammap^2)); % location
sigmaGammap = sqrt(log(1+sGammap/mGammap^2)); %shape parameter
Gammap=lognrnd(muEp,sigmaGammap,[N 1]); %lognormal distribution

mGamman=-623; %mean
sGamman=50; %var
muGamman = log(mGamman^2/sqrt(sGamman+mGamman^2)); % location
sigmaGamman = sqrt(log(1+sGamman/mGamman^2)); %shape parameter
Gamman=lognrnd(muGamman,sigmaGamman,[N 1]); %lognormal distribution

%---Flow rate

%----Creating vectorized function for the cell voltage
U = @(X) X(:,1).*I + X(:,2)+ X(:,3); %the overpotential term is missing for now




