function z=nBayes(testData,meanVect,varVect)
[dataSize, ftrSize]=size(testData);
mA=meanVect(1,:);
mB=meanVect(2,:);
vA=varVect(1,:);
vB=varVect(2,:);
gaussVectA=zeros(dataSize,7);
gaussVectB=zeros(dataSize,7);
for i=1:dataSize
gaussVectA(i,:)=exp(0.5.*(testData(i,:)-mA).^2./vA.^2);
end
for i=1:dataSize
gaussVectB(i,:)=exp(0.5.*(testData(i,:)-mB).^2./vB.^2);
end
class=prod(gaussVectA,2)>prod(gaussVectB,2);
z=class-(class==0);