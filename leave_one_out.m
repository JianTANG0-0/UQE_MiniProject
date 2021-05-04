%% calculate the leaveoneerror of the model
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

function [ELOO,eLOO,evar] = leave_one_out(n,Z,u,U)
% calculate the leave-one-error
h = Z* pinv(Z'*Z) *Z'; 
ELOO = sum(((u-U)./(1-diag(h)')).^2)/n; % calculate the leaveoneerror
eLOO = ELOO / var(u);
%eLOO_mod = eLOO * (1+trace(pinv(Z'*Z./n))/n)/(1-det(Z)/n); % modified the error by Heuristic modification factors to avoid overfitting

% mean-squared error
evar = sum((u-U).^2) / var(u);

end