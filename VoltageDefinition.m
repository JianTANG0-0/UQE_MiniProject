clear all;

%------Known inputs
I = 0.4; %charging current in A
R = 8.314; %Ideal gas constant (J/K/mol)
T = 298.15; %absolute temperature (K)
F = 96485; %Faraday constant (C/mol)
b = 0.9; %fitted constant for the flow rate
a = 1e-5; %fitted constant for the flow rate

%------ Battery composition at SOC 50
cT1 = 0.56; %TEMPO+ concentration (M)
cT2 = 0.56; %TEMPO2+ concentration (M)
cM1 = 0.745; %MV+ concentration (M)
cM2 = 0.745; %MV2+ concentration (M)
%At this composition the ratios are equal to 1 so we can get rid of
% the ln(ratio) term to keep only thermodynamic potential in the Nernstian
% term

%----Creating vectorized function for the cell voltage
U = @(X) X(:,1).*I + X(:,2)+ X(:,3); %the overpotential term is missing for now