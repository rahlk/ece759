function id=features_best_combin(X,y,q)
[l,N]=size(X);
J3_max=0;
id=[];
combin=nchoosek(1:l,q);
for j=1:size(combin,1)
    X1=X(combin(j,:),:);
[Sw,Sb,Sm]=scatter_mat(X1,y);
J3=J3_comp(Sw,Sm)
if(J3>J3_max)
J3_max=J3;
id=combin(j,:);
end
end