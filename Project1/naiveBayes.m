%% Probablistic classification using Naive Bayes.
% Authored by Rahul Krishna. Dated- Thursday, March 15th 2014
%# image size
% Load data
load('data.mat');
clc,
disp('Naive Bayes classification');
% Split data according to their labels. The labels are available in the
% last column, they are -1 and +1.
tr_testRatio=4;
j=1;
k=1;
for i=1:size(data,1)
if(data(i,8)<0)
dataA(j,1:7)=data(i,1:7); j=j+1;
else
dataB(k,1:7)=data(i,1:7); k=k+1;
end
end
numData_class_A = size(dataA,1);
numData_class_B = size(dataB,1);

% Training Vectors

numtrainA = randperm(numData_class_A);
trainDataA = dataA(numtrainA(1:floor(numData_class_B*tr_testRatio/10)),:);
numtrainB = randperm(numData_class_B);
trainDataB = dataB(numtrainB(1:floor(numData_class_B*tr_testRatio/10)),:);

varVectA=diag(cov(trainDataA));
varVectB=diag(cov(trainDataB));

meanVectA=mean(trainDataA,1);
meanVectB=mean(trainDataB,1);

trainData= [trainDataA ; trainDataB];
trainClass = [-ones(size(trainDataA,1),1); ones(size(trainDataB,1),1)];

% Test data

testDataA=dataA(ceil(numData_class_B*tr_testRatio/10):end,:);
testDataB=dataB(ceil(numData_class_B*tr_testRatio/10):end,:);
testData= [testDataA; testDataB];
testClass = [-ones(size(testDataA,1),1); ones(size(testDataB,1),1)];


[l, c]=size(m);
[l,N]=size(X);
for i=1:N
    for j=1:c
        t(j)=P(j)*comp_gauss_dens_val(m(:,j),S(:,:,j),X(:,i));
    end
    [num, z(i)]=max(t);
end
