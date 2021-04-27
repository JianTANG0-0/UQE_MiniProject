clear all;

%------Physical constants
R = 8.314; %Ideal gas constant (J/K/mol)
T = 298.15; %absolute temperature (K)
F = 96485; %Faraday constant (C/mol)

%-----Known Inputs
I = 0.4; %charging current (A)
b = 0.9; %fitted constant for the flow rate
A = 2.236*0.4e-4; %electrode area (m^2)
a = A*4e-5; %fitted constant for the electrolyte flow rate
Ep0 = 0.62; %thermodynamic potential of TEMPO (V)
En0 = -0.63; %thermodynamic potential of MV (V)
kp0 = 4.2e-5; %kinetic constant of TEMPO (m/s)
kn0 = 3.3e-5; %kinetic constant of MV (m/s)

%------ Distributed inputs
N=10; %input size

%---Cell resistance (normal distribution)
mR=0.380; %mean (Ohms)
sR=0.100; %var (Ohms)
R = normrnd(mR, sR, [N 1]); %normally distributed random numbers

%---Activity ratios (lognormal distribution)
mGammap=1; %mean
sGammap=1; %var
muGammap = log(mGammap^2/sqrt(sGammap+mGammap^2)); % location
sigmaGammap = sqrt(log(1+sGammap/mGammap^2)); %shape parameter
Gammap=lognrnd(muGammap,sigmaGammap,[N 1]); %lognormally distributed random numbers

mGamman=1; %mean
sGamman=1; %var
muGamman = log(mGamman^2/sqrt(sGamman+mGamman^2)); % location
sigmaGamman = sqrt(log(1+sGamman/mGamman^2)); %shape parameter
Gamman=lognrnd(muGamman,sigmaGamman,[N 1]); %lognormally distributed random numbers

%---Flow rate (normal distribution)
mQ=21e-6/60; %mean (conversion mL/min to m^3/s)
sQ=3e-6/60; %var (conversion mL/min to m^3/s)
Q = normrnd(mQ, sQ, [N 1]); %normally distributed random numbers
%---concentration difference between bulk and surface
Deltac = I./(a.*Q.^b)
g = 1- Deltac;

%---Input vector X
X = horzcat(R, Gammap, Gamman, g);

%----Creating vectorized function for the cell voltage
U = @(X) X(:,1).*I + Ep0 - En0 + R*T/F* log( X(:,2).*X(:,3)) +R*T/F/2 .*log((I+sqrt(I^2+4*F*kp0.*X(:,4)))/(2.*X(:,4)))+R*T/F/2 .*log((I+sqrt(I^2+4*F*kn0*X(:,4)))/(2.*X(:,4))) ;




