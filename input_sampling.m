<<<<<<< HEAD
%% Input sampling and isoprobability transformation
% by Jian TANG @ Empa & ETHz
% Input parameters:
% sampling_points: size of sample (int)
% sampling_method: 'random' or 'LatinHypercube' (str)
% sampling_feature: 'RCell'or 'GammaP'or 'GammaN'or 'Q' (str)
% transform_method: 'normal' or 'uniform' (str)

% Output:
% inp_sam: samples after isoprobability transformation
% inp_sam_bef: samples before isoprobability transformation ~ U[-1,1]

function [inp_sam,inp_sam_bef] = input_sampling(sampling_points,sampling_method,sampling_feature,transform_method)

if strcmp(transform_method,'normal')
    
    %---Cell resistance (normal distribution)
    mR=0.380; %mean (Ohms)
    sR=0.100; %var (Ohms)

    %---Activity ratios (lognormal distribution)
    mGammap=1; %mean
    sGammap=0.5; %var
    sigmaGammap = sqrt(log((sGammap/mGammap)^2.0+1));  % turn the mean and variance of sample into mean and standard variance of lognormal distribution
    muGammap = log(mGammap)-0.5*log((sGammap/mGammap)^2.0+1);


    mGamman=1; %mean
    sGamman=0.5; %var
    sigmaGamman = sqrt(log((sGamman/mGamman)^2.0+1));  % turn the mean and variance of sample into mean and standard variance of lognormal distribution
    muGamman = log(mGamman)-0.5*log((sGamman/mGamman)^2.0+1);

    %---Flow rate (normal distribution)
    mQ=21e-6/60; %mean (conversion mL/min to m^3/s)
    sQ=3e-6/60; %var (conversion mL/min to m^3/s)
    
    if strcmp(sampling_method,'random')
        inp_sam = rand([sampling_points 1]); % random sampling
    elseif strcmp(sampling_method,'LatinHypercube')
        inp_sam = lhsdesign(sampling_points,1); % Latin Hypercube Sampling
    else
        fprintf('Wrong input sampling method! Check your input parameters!');
    end

    inp_sam_bef = inp_sam * 2.0 - 1.0; % transform the sampling into uniform distribution between [-1,1]

    % transform the sampling into designed distribution by its inverse CDF
    if strcmp(sampling_feature,'RCell')
        inp_sam = norminv(inp_sam,mR,sR);  % normal distribution
    elseif strcmp(sampling_feature,'GammaP')
        inp_sam = logninv(inp_sam,muGammap,sigmaGammap); % lognormal distribution
    elseif strcmp(sampling_feature,'GammaN')
        inp_sam = logninv(inp_sam,muGamman,sigmaGamman); % lognormal distribution
    elseif strcmp(sampling_feature,'Q')
        inp_sam = norminv(inp_sam,mQ,sQ);  % normal distribution
    else
        fprintf('Wrong input sampling feature! Check your input parameters!');
    end
    
elseif strcmp(transform_method,'uniform')
    
	%---Cell resistance (normal distribution)
    mR=0.380; %mean (Ohms)
    sR=0.100; %var (Ohms)

    %---Activity ratios (lognormal distribution)
    muGammap=1; %mean
    sigmaGammap=0.5; %var

    muGamman=1; %mean
    sigmaGamman=0.6; %var

    %---Flow rate (normal distribution)
    mQ=21e-6/60; %mean (conversion mL/min to m^3/s)
    sQ=3e-6/60; %var (conversion mL/min to m^3/s)
    
    % transform the sampling into uniform distribution between [-1,1]
    if strcmp(sampling_method,'random')
        inp_sam_bef = rand([sampling_points 1])*2.0-1.0; % random sampling
    elseif strcmp(sampling_method,'LatinHypercube')
        inp_sam_bef = lhsdesign(sampling_points,1)*2.0-1.0; % Latin Hypercube Sampling
    else
        fprintf('Wrong input sampling method! Check your input parameters!');
    end

    % transform the sampling into uniform distribution between [ai,bi]
    if strcmp(sampling_feature,'RCell')
        inp_sam = inp_sam_bef * sR + mR;  
    elseif strcmp(sampling_feature,'GammaP')
        inp_sam = inp_sam_bef * sigmaGammap + muGammap; 
    elseif strcmp(sampling_feature,'GammaN')
        inp_sam = inp_sam_bef * sigmaGamman + muGamman; 
    elseif strcmp(sampling_feature,'Q')
        inp_sam = inp_sam_bef * sQ + mQ; 
    else
        fprintf('Wrong input sampling feature! Check your input parameters!');
    end
    
else
    fprintf('Wrong input transform method! Check your input parameters!');
end

end


=======
%% Input sampling and isoprobability transformation
% by Jian TANG @ Empa & ETHz
  
% Input parameters:
% sampling_points: size of sample (int)
% sampling_method: 'random' or 'LatinHypercube' (str)
% sampling_feature: 'RCell'or 'GammaP'or 'GammaN'or 'Q' (str)

% Output:
% inp_sam: samples after isoprobability transformation
% inp_sam_bef: samples before isoprobability transformation ~ U[-1,1]

function [inp_sam,inp_sam_bef] = input_sampling(sampling_points,sampling_method,sampling_feature)

%---Cell resistance (normal distribution)
mR=0.380; %mean (Ohms)
sR=0.100; %var (Ohms)

%---Activity ratios (lognormal distribution)
mGammap=1; %mean
sGammap=0.5; %var
sigmaGammap = sqrt(log((sGammap/mGammap)^2.0+1));  % turn the mean and variance of sample into mean and standard variance of lognormal distribution
muGammap = log(mGammap)-0.5*log((sGammap/mGammap)^2.0+1);


mGamman=1; %mean
sGamman=0.5; %var
sigmaGamman = sqrt(log((sGamman/mGamman)^2.0+1));  % turn the mean and variance of sample into mean and standard variance of lognormal distribution
muGamman = log(mGamman)-0.5*log((sGamman/mGamman)^2.0+1);



%---Flow rate (normal distribution)
mQ=21e-6/60; %mean (conversion mL/min to m^3/s)
sQ=3e-6/60; %var (conversion mL/min to m^3/s)


if strcmp(sampling_method,'random')
    inp_sam = rand([sampling_points 1]); % random sampling
elseif strcmp(sampling_method,'LatinHypercube')
    inp_sam = lhsdesign(sampling_points,1); % Latin Hypercube Sampling
else
    fprintf('Wrong input sampling method! Check your input parameters!');
end

inp_sam_bef = inp_sam * 2.0 - 1.0; % transform the sampling into uniform distribution between [-1,1]

% transform the sampling into designed distribution by its inverse CDF
if strcmp(sampling_feature,'RCell')
    inp_sam = norminv(inp_sam,mR,sR);  % normal distribution
elseif strcmp(sampling_feature,'GammaP')
    inp_sam = logninv(inp_sam,muGammap,sigmaGammap); % lognormal distribution
elseif strcmp(sampling_feature,'GammaN')
    inp_sam = logninv(inp_sam,muGamman,sigmaGamman); % lognormal distribution
elseif strcmp(sampling_feature,'Q')
    inp_sam = norminv(inp_sam,mQ,sQ);  % normal distribution
else
    fprintf('Wrong input sampling feature! Check your input parameters!');
end

end


>>>>>>> d4ab9a66cedae533c76f99dca130fd0035ec08b5
