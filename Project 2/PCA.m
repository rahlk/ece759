function dataOut=PCA(data,label,d)
%% PRINCIPAL COMPONENT ANALYSIS %%
% data = Input data matrix of size [NxD]. label = Input class labels of
% size [Nx1]. d = Number of output dimensions (scalar).
% dataOut -> an [Nx(d+1)] matrix. The first [Nxd] matrix is data with the
% reduced dimensionality
% Subtract the mean from the original data and obtain covariance matrix
mu = repmat(mean(data(:,1:7),1),size(data,1),1);
newData=data(:,1:7)-mu;
covMat=cov(newData);
% Get the eigen vectors and values
[eigVect, eigVal]=eig(covMat);
fVect=[];
% Generate the feature vector
for i=1:d
fVect=[fVect; eigVect(:,8-i)'];
end
% Final Data
fData=(fVect*newData');
fData=[fData;label']; % Append label
dataOut=fData';
% save fVectPCA fData
end
