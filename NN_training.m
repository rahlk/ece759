function net=NN_training(x,y,k,code,iter,par_vec)
randn('seed',0);
randn('seed',0);
methods_list={'traingd'; 'traingdm'; 'traingda'};
limit=[min(x(:,1)) max(x(:,1)); min(x(:,2)) max(x(:,2))];
net=newff(limit, [k 1], {'tansig', 'tansig'}, methods_list{code,1});
net=init(net);
net.trainParam.epochs=iter;
net.trainParam.lr=par_vec(1);
net=train(net,x,y);
end
