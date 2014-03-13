%% Non-parametric optimization using kNN optimization medthod.

% Authored by Rahul Krishna. Dated- Thursday, March 15th 2014
%# image size
% Load data
load('data.mat');
% Split data according to their labels. The labels are available in the
% last column, they are -1 and +1. 
j=1;k=1;
for i=1:size(data,1)
if(data(i,8)<0)
dataA(j,1:7)=data(i,1:7); j=j+1;
else
dataB(k,1:7)=data(i,1:7); k=k+1;
end
end
numData_class_A = size(dataA,1);
numData_class_B = size(dataB,1);

%# training Vectors
% Training to testing ratios include, 25%, 33.33%, 50%, and 66.67%
numtrainA = randperm(numData_class_A);
numTrainA = numTrainA(1:floor(numData_class_A/4));
numtrainB = randperm(numData_class_B);
numTrainB = numTrainA(1:floor(numData_class_B/4));

trainData = zeros(numTrain,prod(sz));
for i=1:numTrain
    img = imread( sprintf('train/image_%03d.jpg',i) );
    trainData(i,:) = img(:);
end

%# testing images
numTest = 200;
testData = zeros(numTest,prod(sz));
for i=1:numTest
    img = imread( sprintf('test/image_%03d.jpg',i) );
    testData(i,:) = img(:);
end

%# target class (I'm just using random values. Load your actual values instead)
trainClass = randi([1 5], [numTrain 1]);
testClass = randi([1 5], [numTest 1]);

%# compute pairwise distances between each test instance vs. all training data
D = pdist2(testData, trainData, 'euclidean');
[D,idx] = sort(D, 2, 'ascend');

%# K nearest neighbors
K = 5;
D = D(:,1:K);
idx = idx(:,1:K);

%# majority vote
prediction = mode(trainClass(idx),2);

%# performance (confusion matrix and classification error)
C = confusionmat(testClass, prediction);
err = sum(C(:)) - sum(diag(C))