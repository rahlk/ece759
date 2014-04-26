function [Y]=reduceDimen(varargin)
% Reduces the number of dimension in the data using PCA, LLE or MDS.
%   Y = reduceDimen(X,d,'PCA') uses principal component analysis. X is the 
%   input matix, d is number of dimensions required in the output. 
%   Y is the reduced data.
%
%   Y = reduceDimen(X,d,'LLE',k) uses Locally Linear Enbedding. X is the 
%   input matix, d is number of dimensions required in the output, k is neighbors. 
%   Y is the reduced data.
% 
%   Example:
%   Y=reduceDimen('data',3,'PCA');
%   Y=reduceDimen('data',3,'LLE',11);
% 


X=importdata(strcat(varargin{1},'.mat'));
d=varargin{2};
switch varargin{3}
    case 'LLE'
        if(length(varargin)<4)
            error('Not enough input arguments. Perhaps the parameter k is missing.')
        end
        disp('Locally Linear Embedding')
        Y=lle(X(:,1:7),varargin{4},d);
    case 'PCA'
        disp('Principal Component Analysis')
        Y=PCA(X(:,1:7),X(:,8),d);
    case 'MDS'
        Y=MDS(X(:,1:7),d);
    otherwise
        error('Invalid method chosen: use PCA or LLE')        
end
end

%% PRINCIPAL COMPONENT ANALYSIS %%
function dataOut=PCA(data,label,d)
clc
% data = Input data matrix of size [NxD]. label = Input class labels of
% size [Nx1]. d = Number of output dimensions (scalar).
% dataOut -> an [Nx(d+1)] matrix. The first [Nxd] matrix is data with the
% reduced dimensionality
% Subtract the mean from the original data and obtain covariance matrix
mu = repmat(mean(data(:,1:7),1),size(data,1),1);
newData=data(:,1:7)-mu;
fprintf(1,'-->Computing Covariance..\n');
covMat=cov(newData);
% Get the eigen vectors and values
fprintf(1,'-->Getting Eigen vectors and eigen values...\n');
[eigVect, eigVal]=eig(covMat);
fVect=[];
% Generate the feature vector
fprintf(1,'-->Generating the feature vector....\n');
for i=1:d
    fVect=[fVect; eigVect(:,8-i)'];
end
% Final Data
fprintf(1,'-->Reconstructing data with %d dimensions.....\n',d);
fData=(fVect*newData');
fprintf(1,'-->Appending labels......\n');
fData=[fData;label']; % Append label
fprintf(1,'Execution completed\n');
dataOut=fData';
savedata=input('Save data? (Y/n)','s');
if savedata=='Y'|savedata=='y'
    saveName=input('Enter Filename: ','s');
    save(saveName,'dataOut')
    disp('File Saved.')
end
end
%% Locally Linear Embedding %%
function dataOut=lle(X,K,d)
clc
X=X';
[D,N] = size(X);
fprintf(1,'LLE running on %d points in %d dimensions..\n',N,D);
% STEP1: COMPUTE PAIRWISE DISTANCES & FIND NEIGHBORS
fprintf(1,'-->Finding %d nearest neighbours...\n',K);
X2 = sum(X.^2,1);
distance = repmat(X2,N,1)+repmat(X2',1,N)-2*X'*X;
[sorted,index] = sort(distance);
neighborhood = index(2:(1+K),:);
% STEP2: SOLVE FOR RECONSTRUCTION WEIGHTS
fprintf(1,'-->Solving for reconstruction weights....\n');
if(K>D)
    fprintf(1,'   [note: K>D; regularization will be used]\n');
    tol=1e-3; % regularlizer in case constrained fits are ill conditioned
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % other possible regularizers for K>D
    %   C = C + tol*diag(diag(C));             % regularlization
    %   C = C + eye(K,K)*tol*trace(C)*K;       % regularlization
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    tol=0;
end
W = zeros(K,N);
for ii=1:N
    z = X(:,neighborhood(:,ii))-repmat(X(:,ii),1,K); % shift ith pt to origin
    C = z'*z;                                        % local covariance
    C = C + eye(K,K)*tol*trace(C);                   % regularlization (K>D)
    W(:,ii) = C\ones(K,1);                           % solve Cw=1
    W(:,ii) = W(:,ii)/sum(W(:,ii));                  % enforce sum(w)=1
end
% STEP 3: COMPUTE EMBEDDING FROM EIGENVECTS OF COST MATRIX M=(I-W)'(I-W)
fprintf(1,'-->Computing embedding.....\n');
% M=eye(N,N); % use a sparse matrix with storage for 4KN nonzero elements
M = sparse(1:N,1:N,ones(1,N),N,N,4*K*N);
for ii=1:N
    w = W(:,ii);
    jj = neighborhood(:,ii);
    M(ii,jj) = M(ii,jj) - w';
    M(jj,ii) = M(jj,ii) - w;
    M(jj,jj) = M(jj,jj) + w*w';
end;
% CALCULATION OF EMBEDDING
options.disp = 0; options.isreal = 1; options.issym = 1;
[Y,eigenvals] = eigs(M,d+1,0,options);
Y = Y(:,2:d+1)'*sqrt(N); % bottom evect is [1,1,1,1...] with eval 0
dataOut=Y';
fprintf(1,'Execution completed\n');
savedata=input('Save data? (Y/n)','s');
if savedata=='Y'|savedata=='y'
    saveName=input('Enter Filename: ','s');
    save(saveName,'dataOut')
    disp('File Saved.')
end
end
%% Multidimensional Scaling
function dataOut=MDS(X,d)
% Setup squared proximity matrix
fprintf('--> Computing proximity matrix..\n');
prox=pdist2(X(:,1:7),X(:,1:7));
fprintf('--> Performing MDS...\n');
dataOut=mdscale(prox,d);
end
%% END OF CODE

