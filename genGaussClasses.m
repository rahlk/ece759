function [X,y] = genGaussClasses(m,S,P,N)
% Usage [X,y] = genGaussClasses(m,S,P,N)
% m : LxC matrix i-th column is the mean vector of the i-th class
% distribution 
% S is a LxLxC matrix where i-th LxL matrix is the covariance of the
% districution
% P is the C dimensional vector that contains the apriori probablities of
% the classes m_i, S_i, P_i and C are provided sa inputs.

% A matrix X with N columns each column of which is a L-Dimesional feature
% vecture.
% y is the vector that contains the class to which each element of X belong

[~, c] = size(m);
X=[];
y=[];
for j=1:c
%   Generate the pi*N vector form each distribution
    t = mvnrnd(m(:,j), S(:,:,j), fix(P(j)*N));
%   Total number may vary based on the P(j)
    X = [X t];
    y = [y ones(1, fix(P(j)*N))*j];
end
return