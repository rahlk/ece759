function [X, y] = data_generator(m,s,N,seed)
rand('seed',seed);
S = s*eye(2);
[l c]=size(m);
X=[];
for i=1:c
    X = [X mvnrnd(m(:,i)',S,N)'];
end
y=[ones(1,N) ones(1,N) -ones(1,N) -ones(1,N)];
end

