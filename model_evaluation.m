function [Y] = model_evaluation(c,M,X,Alpha)
%function which evaluates the PCE model on a general input X
%Input Variables:
%c vector containing the PCE coefficients
%M number of inputs of the model
%p maximal degree allowed
%X input for the evaluation of the PCE model


Shape_Alpha=size(Alpha);
Polynomials=zeros(Shape_Alpha(1),1);
for i=1:length(Polynomials)
    poly=zeros(M,1);
    for k=1:M
        poly(k)=eval_legendre(X(k),alpha(i,k));
    end
    Polynomials(i)=prod(poly);
end
Z=zeros(length(Polynomials),1);
for i=1:length(Z)
    Z(i)=Polynomials(i)*c(i);
end
Y=sum(Z);
          
end

