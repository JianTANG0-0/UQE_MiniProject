function [Z,Alpha] = regression_matrix(M,p,X)
%function which realises the regression matrix based on the
%Legendre PCE 
%Input Variables:
%M number of inputs of our computational model
%p maximum degree of polynomials allowed
%X auxiliary experimental design
%Output Variables:
%Z regression matrix of dimensions nxP
%where n is the number of samples
%P is the total number of the polynomial basis 
%such that each polynomial the basis has degree
%at most p given as an input
%Zij= (Psi_j(X(:,i))) i=1,..n, j=1..P
%Psi_j is the j-th multivariate polynomial of the Legendre basis
Shape_X=size(X);
Alpha=create_alphas(M,p);
Shape_Alpha=size(Alpha);

Z=zeros(Shape_X(2),Shape_Alpha(1));

for i=1:Shape_X(2)
    for j=1:Shape_Alpha(1)
        poly=zeros(1,M);
        for k=1:M
            poly(k)=eval_legendre(X(k,i),Alpha(j,k));
        end
        Z(i,j)=prod(poly);
    end
end
            



end

