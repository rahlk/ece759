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
% Find the mean vector of class A and class B
for i=1:7
mean_classA=mean(dataA);
mean_classB=mean(dataB);
end
