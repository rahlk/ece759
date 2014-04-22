%
load('data.mat');
k=11;
covMat={};
% find the K smallest distances assign the corresponding points to be
% neighbours of Xi
[D, ni] = findNN(data, k);
len=size(data,1);
% Create matrix Z consisting of all neighbours of Xi
for m=1:len
    for n=1:k
        Z(m,n,:)=data(ni(m,n),1:7);
        % Subtract Xi from every column of Z and compute the local covariance
        % C=Z'*Z
        Y(m,n,:)=squeeze(Z(m,n,:))'-data(m,1:7);
    end
    covMat=cov(squeeze(Y(m,:,:)));
% If K>D, the local covariance will not be full rank, and it should be 
% regularized by seting C=C+eps*I where I is the identity matrix and 
% eps is a small constant of order 1e-3*trace(C). 
% This ensures that the system to be solved in step 2 has a unique solution.
covMat=covMat+1e-3*trace(covMat)*eye(size(covMat,1));

end