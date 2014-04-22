%% Non-parametric optimization using kNN optimization medthod.
% Authored by Rahul Krishna. Dated- Thursday, March 15th 2014
%# image size
% Load data
load('fVectPCA.mat');
% clc,
% disp('Non-parametric optimization using kNN optimization medthod..');
% Split data according to their labels. The labels are available in the
% last column, they are -1 and +1.
err=[];
errOut=[];
for iter=1:1
j=1;k=1;
dimen=size(fData,2);
for i=1:size(fData,1)
if(fData(i,dimen)<0)
dataA(j,1:dimen-1)=fData(i,1:dimen-1); j=j+1;
else
dataB(k,1:dimen-1)=fData(i,1:dimen-1); k=k+1;
end
end
numData_class_A = size(dataA,1);
numData_class_B = size(dataB,1);
numtrainA = randperm(numData_class_A);
numtrainB = randperm(numData_class_B);
% numtrainA = 1:numData_class_A;
% numtrainB = 1:numData_class_B;

for tr_testRatio=[2 5 8]
%# Training Vectors
% Training to testing ratios include, 25%:75%

trainDataA = dataA(numtrainA(1:floor(numData_class_A*tr_testRatio/10)),:);
trainDataB = dataB(numtrainB(1:floor(numData_class_B*tr_testRatio/10)),:);

trainData= [trainDataA ; trainDataB];
trainClass = [-ones(size(trainDataA,1),1); ones(size(trainDataB,1),1)];

% Test data
testDataA=dataA(numtrainA(ceil(numData_class_A*tr_testRatio/10):end),:);
testDataB=dataB(numtrainB(ceil(numData_class_B*tr_testRatio/10):end),:);
testData= [testDataA; testDataB];
testClass = [-ones(size(testDataA,1),1); ones(size(testDataB,1),1)];

%# compute pairwise distances between each test instance vs. all training data
D = pdist2(testData, trainData, 'euclidean');
[D,I] = sort(D, 2, 'ascend');
% 
%# K nearest neighbors
K = 11;
% disp('100 Nearest Neighbours considered');
D = D(:,1:K);
I = I(:,1:K);
% 
%# majority vote
P = mode(trainClass(I),2);
% 
%# performance (confusion matrix and classification error)
C = confusionmat(testClass, P);
err = [err;((C(1,2)+C(2,1))*100/sum(C(:)))];
% fprintf('Total vectors in class A - %d\n',size(dataA,1));
% fprintf('Total vectors in class B - %d\n',size(dataB,1));
% fprintf('Training to testing ratio - %d:%d\n',tr_testRatio,(10-tr_testRatio));
% fprintf('\nWrongly classified vectors form class A - %d\n',C(2,1));
% fprintf('Wrongly classified vectors form class B - %d\n',C(1,2));
% fprintf('\nClassification error in percentage - %0.2f\n',(C(1,2)+C(2,1))*100/sum(C(:)));
end
%% err = err(2:end);
% bar(err(1:end));
err
end