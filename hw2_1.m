% Problem 3.5 Chapter 3, Page 142
clear, close all
m = [-2 2; 0 0];
S = zeros(2,2,2);
S(:,:,1) = [1 0; 0 1];
S(:,:,2) = [1 0; 0 1];
P = [0.5; 0.5];
N = 200;
% randn('seed',0)
[fVect1, class] = genGaussClasses(m,S,P,N);
[fVect2, class] = genGaussClasses(m,S,P,N);
class=class';

% Reorganize data for classification.

f1 = fVect1(:,1:2);
f2 = fVect1(:,3:4);
clear XX
clear fVect1
XX(:,1) = reshape(f1,N,1);
XX(:,2) = reshape(f2,N,1);
XX(:,3) = 1;
fVect1=XX;
classSep1 = sum(fVect1,2);

f1 = fVect2(:,1:2);
f2 = fVect2(:,3:4);
clear XX
clear fVect2
XX(:,1) = reshape(f1,N,1);
XX(:,2) = reshape(f2,N,1);
XX(:,3) = 1;
fVect2=XX;
classSep2 = sum(fVect2,2);

for i=1:N
    if(class(i)==1)
        class(i)=-1;
    else
        class(i)=1;
    end
end

%% Perceptron Algorithm

% Compute the perceptron weight for X1
w_percep_1 = [0, 0, 1];
rho = 0.9;
iter =0;
mis_class = N;
while (mis_class>0)&&(iter<1000)
    iter=iter+1;
    mis_class=0;
    gradi= zeros(3,1);
    for i=1:N
        if((fVect1(i,:)'*w_percep_1)*class(i)>=0)
            mis_class=mis_class+1;
            gradi=gradi-rho.*(class(i).*fVect1(i,:)');
        end
    end
   w_percep_1=w_percep_1-rho.*gradi';
end
w_percep_1=w_percep_1./max(abs(w_percep_1));
figure('color',([1 1 1]))
hold on, 
scatter(-100:-1,classSep1(1:100),'*','r'), 
scatter(1:100,classSep1(101:N),'x','b')
refline(w_percep_1(2)/w_percep_1(1),w_percep_1(3))
ylim([-5 5])

% Compute the perceptron weight for X1'
w_percep_2 = [0, 0, 1];
rho = 0.9;
iter =0;
mis_class = N;
while (mis_class>0)&&(iter<1000)
    iter=iter+1;
    mis_class=0;
    gradi= zeros(3,1);
    for i=1:N
        if((fVect2(i,:)'*w_percep_2)*class(i)>=0)
            mis_class=mis_class+1;
            gradi=gradi-rho.*(class(i).*fVect2(i,:)');
        end
    end
   w_percep_2=w_percep_2-rho.*gradi';
end
w_percep_2=w_percep_2/max(abs(w_percep_2));
figure('color',([1 1 1]))
hold on, 
scatter(-100:-1,classSep2(1:100),'*','r'), 
scatter(1:100,classSep2(101:N),'x','b')
refline(w_percep_2(2)/w_percep_2(1),w_percep_2(3))
ylim([-5 5])

%% Measure the performance
sum_missClass_percep=0;
for i=1:N
    if((fVect2(i,:)'*w_percep_1)*class(i)>=0)
        sum_missClass_percep=sum_missClass_percep+1;
    end
end

%% Minimum Mean Squared error
% Dataset X1
w_mse_1 = inv(fVect1'*fVect1);
w_mse_1 = w_mse_1*(fVect1'*class);
w_mse_1=w_mse_1/max(abs(w_mse_1));
figure('color',([1 1 1]))
hold on, 
scatter(-100:-1,classSep1(1:100),'*','r') 
scatter(1:100,classSep1(101:N),'x','b')
refline(w_mse_1(2)/w_mse_1(1))
ylim([-5 5])

% Dataset X1'
w_mse_2 = inv(fVect2'*fVect2);
w_mse_2 = w_mse_2*(fVect2'*class);
w_mse_2=w_mse_2/max(abs(w_mse_2));
figure('color',([1 1 1]))
hold on, 
scatter(-100:-1,classSep2(1:100),'*','r') 
scatter(1:100,classSep2(101:N),'x','b')
refline(w_mse_2(2)/w_mse_2(1), 2+w_mse_2(3))
ylim([-5 5])

w_mse_1=w_mse_1';
%% Measure the performance of MSE
sum_missClass_mse=0;
for i=1:N
    if((fVect2(i,:)*w_mse_1')*class(i)<=-0)
        sum_missClass_mse=sum_missClass_mse+1;
    end
end


%% LMS Algorithm
rho=0.1;
w_lms_1 = [0, 0, 0];
for i=1:N
w_lms_1=w_lms_1+(rho/i)*(class(i)-fVect1(i,:)*w_lms_1')*fVect1(i,:);
end
figure('color',([1 1 1]))
hold on, 
scatter(-100:-1,classSep1(1:100),'*','r') 
scatter(1:100,classSep1(101:N),'x','b')
refline(w_lms_1(2)/w_lms_1(1))
ylim([-5 5])

%% LMS Algorithm
rho=0.1;
w_lms_2 = [0, 0, 0];
for i=1:N
w_lms_2=w_lms_2+(rho/i)*(class(i)-fVect2(i,:)*w_lms_2')*fVect2(i,:);
end
figure('color',([1 1 1]))
hold on, 
scatter(-100:-1,classSep2(1:100),'*','r') 
scatter(1:100,classSep2(101:N),'x','b')
refline(w_lms_2(2)/w_lms_2(1))
ylim([-5 5])
%% Measure the performance of LMS
sum_missClass_lms=0;
for i=1:N
    if((fVect2(i,:)*w_lms_1')*class(i)<=-0)
        sum_missClass_lms=sum_missClass_lms+1;
    end
end
