function z=mahalanobis_classifier(m,X,S)
[l, c]=size(m);
[l,N]=size(X);
for i=1:N
    for j=1:c
        t(j)=sqrt((X(:,j)-m(:,j))'*inv(S(:,:,j))*(X(:,i)-m(:,j)));
    end
    [num, z(i)]=min(t);
end
