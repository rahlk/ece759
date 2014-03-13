%% PART 1 - To train a neural network 
errout=0;
for i=1:10
s=0.01;
m=[[0;0],[1;1],[0;1],[1;0]];
N=100;
k=2;
mu=i/2;
[X, y] = data_generator(m,s,N,0);
par_vec=[mu, 0, 0, 0];
net = NN_training(X,y,k,1,100,par_vec)
% At this point a new GUI window opens, the mean dquared error can be 
% computed using the GUI.

%% Part 2: Computing the error.
[new_X, new_y]=data_generator(m,s,N/2,0);
y1=sim(net,new_X);
err=sum(new_y.*y1<0)/length(new_y);
errout=[errout,err];
end
bar(errout(2:11));