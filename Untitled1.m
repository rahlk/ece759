u1 = [1, 1]';
u2 = [1.5 1.5]';
% Generate 100 feature vectors form each class.
for i=1:100
rnd1(i,:,:)=u1+0.2*randn(2,1);
rnd2(i,:,:)=u2+0.2*randn(2,1);
end
class1=sum(rnd1,2);
class2=sum(rnd2,2);
% Calcaluate the percentage of error
fprintf('\nFor minimizing the error probablity\n\n');
val1 = class1>2.5;
val2 = class2>2.5;
fprintf('Percentage error for case of minimum probability error: %f\n', sum(val1)/100);
fprintf('Percentage error for case of minimum probability error: %f\n', sum(val2)/100);

% Now, for minimizing the risk %

class1_1=sum(rnd1.^2,2)-(sum(rnd1,2))-0.5;
class2_1=sum(rnd2.^2,2)-(sum(rnd2,2))-0.5;

val1_1 = class1_1>0;
val2_1 = class2_1>0;
fprintf('\nFor minimizing the risk\n\n');
fprintf('Percentage error for case of minimum probability error: %f\n', sum(val1_1)/100);
fprintf('Percentage error for case of minimum probability error: %f\n', sum(val2_1)/100);
