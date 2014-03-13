% Problem 3.5 Chapter 3, Page 142
clear, close all
m = [1 0; 1 0];
S = zeros(2,2,2);
S(:,:,1) = [1 0; 0 1];
S(:,:,2) = [1 0; 0 1];
P = [0.5; 0.5];
N = 110;
[fVect, class] = genGaussClasses(m,S,P,N);
class=class';
mask = zeros(size(fVect));
for n=[1 3]
    for i=1:N/2
        if n==1
        mask(i,n+1)=(fVect(i,n)+fVect(i,n+1))>1;
        mask(i,n)=(fVect(i,n)+fVect(i,n+1))>1;
        else
        mask(i,n+1)=(fVect(i,n)+fVect(i,n+1))<1;
        mask(i,n)=(fVect(i,n)+fVect(i,n+1))<1;
        end
    end
end
fVect1=fVect;%.*mask;

f1 = fVect1(:,1:2);
f2 = fVect1(:,3:4);
clear XX
clear fVect1
XX(:,1) = reshape(f1,110,1);
XX(:,2) = reshape(f2,110,1);
fVect1=XX;
classSep = sum(fVect1,2);
for i=1:N
    if(class(i)==1)
        class(i)=-1;
    else
        class(i)=1;
    end
end
figure('color',([1 1 1]))
hold on, 
scatter(-55:-1,classSep(1:55),'*','r'), 
scatter(1:55,classSep(56:110),'x','b')

w_percep = [0, 0];
rho = 0.9;
iter =0;
mis_class = N;
while (mis_class>0)&&(iter<1000)
    iter=iter+1;
    mis_class=0;
    gradi= zeros(2,1);
    for i=1:N
        if((fVect1(i,:)'*w_percep)*class(i)>=0)
            mis_class=mis_class+1;
            gradi=gradi-rho.*(class(i).*fVect1(i,:)');
        end
    end
   w_percep=w_percep-rho.*gradi';
end
refline(w_percep(2)/w_percep(1))
ylim([-5 5])

