%% K Means algorithm for cluster detection.

% Initialize data points.
data=TSnolabels(:,1:7);
no_vect=7;

% Method 1: Consider all the vectors at once, try and estimate the class
% based on this.

[idx,ctrs] = kmeans(TSnolabels(:,1:7),2,'Replicates',50,'distance',...
    'sqEuclidean','emptyaction','drop','start','cluster');
classA_1=sum(idx==1);
classB_1=sum(idx==2);

% Method 2: Assume that each row is independent of each other. Find the
% centeroid of the clusters for each feature vector and perform a majority
% vote to determine the final class of the data.
clusters=zeros(size(idx));
for i=1:7
[idx,ctrs] = kmeans(TSnolabels(:,i),2,'Replicates',50,'distance',...
    'sqEuclidean','emptyaction','drop','start','cluster');
clusters=[clusters,idx];
finalC=mode(clusters,2);
classA=sum(finalC==1);
classB=sum(finalC==2);
end