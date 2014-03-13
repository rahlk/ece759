function w =sPercep(x,Y,nIter)
% x - mean of data from Class 1
% Y - a [2xN] matrix with data from class 2, where each row is a mean value
% nIter - number of iterations the perceptron must run before culminating

% w is the output mean value

w = zeros(3,1);
[~,N]=size(Y);
tempMat = zeros(3,N+1);
tempMat(:,1)=x;
tempMat(:,2:N+1)=Y(:,1:N);
for iter=1:nIter
    for n=1:N+1
        if n==1
            res = w'*tempMat(:,n);
            if res<=0
                w=w+tempMat(:,n);
            end
        else
            res = w'*tempMat(:,n);
            if res>=0
                w=w-tempMat(:,n);
            end
        end
    end
end
return
