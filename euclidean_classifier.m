function z=euclidean_classifier(m,X)
[l, c]=size(m);
[l,N]=size(X);
for i=1:N
    for j=1:c
        t(j)=sqrt((X(:,j)-m(:,j))'*(X(:,j)-m(:,j)));
    end
    [num, z(i)]=min(t);
end
