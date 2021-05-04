%% calculate the leave-one error of the model
%input
%val_n: size of validation set
%sampling: type of sampling between 'random' or 'LatinHypercube'
%Z: regression matrix of dimensions nxP
%c: vector containing the PCE coefficients
%Alpha: output of regression_matrix.m

%output
%ELOO,eLOO: leave-one-error before or after divided by the variance of U
%eLOO_mod: modified the error by Heuristic modification factors to avoid overfitting
%evar: mean-squared error

function [ELOO,eLOO,eLOO_mod,evar] = leave_one_error(val_n,sampling,Z,c,Alpha)
[val_E,val_X] = validation_set(val_n,sampling); % get the validation set

U_val = voltage(val_X); % get the experimental result of validation set
%U_val is a row vector of dimension 1xval_n
Y_val=zeros(1,val_n);
for i=1:val_n
Y_val(i) = model_evaluation(c,val_n,val_E(:,i),Alpha);% get the PCE result of validation set
end
% calculate the leave-one-rror
h = Z* pinv(Z'*Z) *Z'; 
ELOO = sum(((U_val-Y_val)./(1-diag(h)')).^2)/val_n; % calculate the leaveoneerror
eLOO = ELOO / var(U_val);
eLOO_mod = eLOO * (1+trace(pinv(Z'*Z./val_n))/val_n)/(1-det(Z)/val_n); % modified the error by Heuristic modification factors to avoid overfitting

% mean-squared error
evar = sum((U_val-Y_val).^2) / var(U_val);

end