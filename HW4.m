m=[0,0;0,2;0,2;0,3;0,3];
s(1,1)=0.5;
s(2,2)=0.5;
s(5,5)=1.5;
s(4,4)=1;
s(3,3)=1;
[X1,y1]=genGaussClasses(m(:,1), s, 1,100);
[X2,y2]=genGaussClasses(m(:,2), s, 1,100);
y2=2*y2;
y=[y1,y2];
X=[X1;X2];
[Sw,Sb,Sm]=scatter_mat(X(:,5)',y);
% Pairs
pairs=nchoosek([1 2 3 4 5 ],2);
[r c]=size(triples);
for i=1:r
    [Sw,Sb,Sm]=scatter_mat(X(:,pairs(i,:))',y);
    J3_p(i)=J3_comp(Sw,Sm);
end
J3_pairs=[pairs,J3_p'];
% Triples
triples=nchoosek([1 2 3 4 5 ],3);
[r c]=size(triples);
for i=1:r
    [Sw,Sb,Sm]=scatter_mat(X(:,pairs(i,:))',y);
    J3_tr(i)=J3_comp(Sw,Sm);
end
J3_triples=[triples,J3_tr'];
