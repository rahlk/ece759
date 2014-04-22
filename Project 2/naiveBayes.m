%% Probablistic classification using Naive Bayes.
% Authored by Rahul Krishna. Dated- Thursday, March 15th 2014

load('fVectPCA.mat');
clc,
disp('Naive Bayes classification');

% Split data according to their labels. The labels are available in the
% last column, they are -1 and +1.
classErr=[];
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

% Training Vectors

% Compute mean, and variance of the training vectors. 
% Since we don't know the pdf of the data set we can make a maximum entropy
% estimate. We can compute the mean and variance of the training dataset
% and assume that the pdf is normally distributed.
for tr_testRatio=[2 5 8]

trainDataA = dataA(numtrainA(1:floor(numData_class_A*tr_testRatio/10)),:);
trainDataB = dataB(numtrainB(1:floor(numData_class_B*tr_testRatio/10)),:);
% Compute the variance.
varVectA=diag(cov(trainDataA));
varVectB=diag(cov(trainDataB));
varVect=[varVectA';varVectB'];
% Compute the mean.
meanVectA=mean(trainDataA,1);
meanVectB=mean(trainDataB,1);
meanVect=[meanVectA;meanVectB];
% Concatenate the training data.
trainData= [trainDataA ; trainDataB];
trainClass = [-ones(size(trainDataA,1),1); ones(size(trainDataB,1),1)];
% Define test data
testDataA=dataA(ceil(numData_class_B*tr_testRatio/10):end,:);
testDataB=dataB(ceil(numData_class_B*tr_testRatio/10):end,:);
testData= [testDataA; testDataB];
testClass = [-ones(size(testDataA,1),1); ones(size(testDataB,1),1)];

% Probablity of classes
pA=numData_class_A/(numData_class_A+numData_class_B);
pB=numData_class_B/(numData_class_A+numData_class_B);

resClass_Label=nBayes(testData, meanVect, varVect);
classErr=[classErr; sum(resClass_Label~=testClass)/sum(testClass==testClass)*100];
fprintf('Training to testing ratio = %d:%d\n',tr_testRatio,(10-tr_testRatio));
fprintf('Classification Error = %0.2f\n',classErr);
end
plot(classErr)
clear classErr
