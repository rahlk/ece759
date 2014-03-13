clear all
% Generate mean vectors.`
m1 = [1;1];
m2 = [8;6];
m3=[16,1]';
% Define the covaraince matrix.
S = [4 0; 0 4];
s(:,:,1) =S;
s(:,:,2) =S;
s(:,:,3) =S;
m=[m1, m2, m3];
% Generate 1000 random variables from a given mean vectors from 3
% equiprobable cases.
[X, y]=genGaussClasses(m,s,[1/3 1/3 1/3],1000);
x1 = X(:,1:2:end)
x2 = X(:,2:2:end)
XX(:,1) = reshape(x1,999,1);
XX(:,2) = reshape(x2,999,1);
XX=XX';
% Perform classifications.
bayes = bayes_classifier(m,s,[1/3 1/3 1/3],XX);
euclid = euclidean_classifier(m,XX);
maha = mahalanobis_classifier(m,XX,s);
% Classification Errors in percentage.
errBayes = class_error(y,bayes)/10
errEuclid = class_error(y,euclid)/10
errMaha = class_error(y,maha)/10