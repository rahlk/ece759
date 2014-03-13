%% Data Set [X1 y1], [X2 y2]
s=2;
m=[[-5;5],[5;-5],[5;5],[-5;-5]];
N=100;
seed1=0;
seed2=10;
[X1, y1]=data_generator(m,s,N,seed1);
[X2, y2]=data_generator(m,s,N,seed2);
lr=0.01; 
par_vec=[lr, 0, 0, 0];
Nodes=[2, 4, 15];
net=NN_training(X1, y1, Nodes(1), 1, 1000, par_vec);

%% Probablity of error
y2=sim(net,X1);
err=sum(y2.*y1<0)/length(y2);
err