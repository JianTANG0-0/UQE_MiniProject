%This loop plots the mean, variance and error of main.m as a function of n
%and p
clear all;

%desired values of n
min_power = 2;
max_power = 4;
number_eval_n = 10;
N = logspace(min_power, max_power, number_eval_n);
N=round(N);

%desired values of p
number_eval_p = 3;
P = zeros([1 number_eval_p]);
for i=1:number_eval_p
    P(1,i) = i+1 ;
end

%matrixes for mean, variance and error
Mean = zeros([number_eval_p number_eval_n]);
Variance = zeros([number_eval_p number_eval_n]);
LeastSquareError = zeros([number_eval_p number_eval_n]);
LeaveOneOutError = zeros([number_eval_p number_eval_n]);

M = 4; 
sampling = 'random'; %sampling type ('random' or 'hypercube')

%while loop on the n values
j=1;
while j<number_eval_n+1
    n=N(1,j); %input size

    [E,X] = experimental_design(n,sampling);
    
    %while loop on the p values
    k=1;
    while k<number_eval_p+1
        p=P(1,k); %maximum degree of polynomials allowed
        u=voltage(X); %voltage calculated from original variables samples

        [Z,Alpha,c] = regression_matrix(M,p,E,u);

        U = zeros([1 n]);
            for i=1:n
                U(1, i) = model_evaluation(c,M,E(:,i),Alpha);
            end

        [ELOO,eLOO,evar] = leave_one_out(n,Z,u,U);
    
        %storing values for mean, variance and error as a function of p
        Mean(k,j) = mean(U)/mean(u)-1;
        Variance(k,j) = var(U)/var(u)-1;
        LeastSquareError(k,j) = evar;
        LeaveOneOutError(k,j) = eLOO;
        k=k+1;
    end
    
    j=j+1;
end


%-------Plotting section
figure(1)
surf(N, P, LeastSquareError);
set(gca,'XScale','log')
set(gca,'YScale','log')
set(gca,'ZScale','log')
grid on

figure(2)
surf(N, P, LeaveOneOutError);
set(gca,'XScale','log')
set(gca,'YScale','log')
set(gca,'ZScale','log')
grid on
