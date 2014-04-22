%% PRINCIPAL COMPONENT ANALYSIS %%

% Obtain Data
load('data.mat');
% Subtract the mean from the original data and obtain covariance matrix
mu = repmat(mean(data(:,1:7),1),size(data,1),1);
newData=data(:,1:7)-mu;
covMat=cov(newData);
% Get the eigen vectors and values
[eigVect, eigVal]=eig(covMat);

% Generate the feature vector
fVect=[eigVect(:,7)'];%eigVect(:,6)'];%eigVect(:,5)']; %eigVect(:,4)'];

% Final Data
fData=(fVect*newData');
fData=[fData;data(:,8)'];
fData=fData';

save fVectPCA fData
