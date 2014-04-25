function [] = optimFeatures(varargin)
data=varargin{1};
labels=varargin{2};
dataA=[]; dataB=[];
projA=[];projAA=[];projAB=[];
projB=[];projBB=[];projBA=[];
J1=[];J3=[];J2=[];
for i=1:size(data,1)
    if(labels(i)<0)
        dataA=[dataA;data(i,:)];
    else
        dataB=[dataB;data(i,:)];
    end
end
% Compute the principal components. Extract the major axis of the ellipsoid
covA=cov(dataA);
covB=cov(dataB);
[eigVectA, eigValA]=eig(covA);
[eigVectB, eigValB]=eig(covB);
majA=eigVectA(:,7);
majB=eigVectB(:,7);
for i=1:size(dataA,1)
    projAA=[projAA; (dot(dataA(i,:),majA')/norm(majA')^2*majA)'];
    projAB=[projAB; (dot(dataA(i,:),majB')/norm(majB')^2*majB)'];
end
projA=projAB./projAA;
[projRatioA, indexA]=sort(projA,1,'ascend');
for i=1:size(dataB,1)
    projBB=[projBB; (dot(dataB(i,:),majB')/norm(majB')^2*majB)'];
    projBA=[projBA; (dot(dataB(i,:),majA')/norm(majA')^2*majA)'];
end
projB=projBA./projBB;
[projRatioB, indexB]=sort(projB,1,'ascend');

% Compute the within class scatter matrix.
trTestRatio=10;
for t=1:trTestRatio-1
    w1=dataA(indexA(1:round(size(indexA,1)*t/10)),:);
    w2=dataB(indexB(1:round(size(indexB,1)*t/10)),:);
    p1=size(dataA,1)/(size(dataA,1)+size(dataB,1));
    p2=size(dataB,1)/(size(dataA,1)+size(dataB,1));
    S_w=p1*cov(w1)+p2*cov(w2);
    classVarA=cov(mean(w1)-mean(dataA));
    classVarB=cov(mean(w2)-mean(dataB));
    S_b=p1*classVarA+p2*classVarB;
    J3=[J3; trace(inv(S_w)*(S_w+S_b))];
    J1=[J1; trace(S_w+S_b)/trace(S_w)];
    J2=[J2; det(S_w)/det(S_b)];
end
if(length(varargin)>2&strcmp(varargin{3},'plot'))
    switch varargin{4}
        case 'J1'
            plot(((J1/sum(J1(:)))));
        case 'J3'
            plot(((J3/sum(J3(:)))));
        case 'J2'
            curvature=[NaN;NaN;diff(diff(J2/sum(J2(:))))];
            bar(J2/sum(J2(:)));
            hold all, plot(curvature)
        case 'all'
            plot(((J1/sum(J1(:))))),
            figure,
            curvature=[NaN;NaN;diff(diff(J2/sum(J2(:))))];
            bar(J2/sum(J2(:)));
            hold all, plot(curvature)
            figure,
            plot(((J3/sum(J3(:)))));
        otherwise
            error('Invalid string. Valid strings: "J1", "J2", "J3" or "all".')
    end
end
if(length(varargin)>2&~strcmp(varargin{3},'plot'))
    error('Invalid string.')
end
