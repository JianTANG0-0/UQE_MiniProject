function [E,X] = experimental_design(n,sampling)
%function which creates the experimental design in a compact way
%Input Variables:
%n: sampling points of the experimental design
%sampling: type of sampling between 'random' or 'LatinHypercube'
%Output Variables:
%E is a matrix of dimension 4xn containing auxiliary variables samples
%uniformly distributed on [-1,1];
%X is a matrix of dimension 4xn containing the original variables samples


if strcmp(sampling,'random') == 1
[R_original,R_uniform] = input_sampling(n,'random','RCell', 'uniform');
[GammaP_original,GammaP_uniform] = input_sampling(n,'random','GammaP', 'uniform');
[GammaN_original,GammaN_uniform] = input_sampling(n,'random','GammaN', 'uniform');
[Q_original,Q_uniform] = input_sampling(n,'random','Q', 'uniform');
else
    [R_original,R_uniform] = input_sampling(n,'LatinHypercube','RCell', 'uniform');
    [GammaP_original,GammaP_uniform] = input_sampling(n,'LatinHypercube','GammaP', 'uniform');
    [GammaN_original,GammaN_uniform] = input_sampling(n,'LatinHypercube','GammaN', 'uniform');
    [Q_original,Q_uniform] = input_sampling(n,'LatinHypercube','Q', 'uniform');
end

E=horzcat(R_uniform,GammaP_uniform,GammaN_uniform,Q_uniform);
X=horzcat(R_original,GammaP_original,GammaN_original,Q_original);
end

