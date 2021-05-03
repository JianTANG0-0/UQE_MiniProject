%% calculate the leave-one error of the model
%input
%n: size of validation set
%sampling: type of sampling between 'random' or 'LatinHypercube'
%Z: regression matrix of dimensions nxP
%c: vector containing the PCE coefficients
%Alpha: output of regression_matrix.m

%output
%ELOO,eLOO: leave-one-error before or after divided by the variance of U
%eLOO_mod: modified the error by Heuristic modification factors to avoid overfitting
%evar: mean-squared error

function [ELOO,eLOO,eLOO_mod,evar] = leave_one_error(n,sampling,Z,c,Alpha)
[val_E,val_X] = validation_set(n,sampling); % get the validation set

U_val = voltage(val_X); % get the experimental result of validation set
Y_val = model_evaluation(c,n,val_E,Alpha);% get the PCE result of validation set

% calculate the leave-one-rror
h = Z* pinv(Z'*Z) *Z'; 
ELOO = sum(((U_val-Y_val)./(1-diag(h))).^2)/n; % calculate the leaveoneerror
eLOO = ELOO / var(U_val);
eLOO_mod = eLOO * (1+trace(pinv(Z'*Z./n))/n)/(1-det(Z)/n); % modified the error by Heuristic modification factors to avoid overfitting

% mean-squared error
evar = sum((U_val-Y_val).^2) / var(U_val);

end