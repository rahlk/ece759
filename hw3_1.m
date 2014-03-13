% Multilayer Perceptron
w1 = [[0.1; -0.2], [0.2; 0.1], [-0.15; 0.2], [1.1; 0.8], [1.2; 1.1]];
w1(3,:) = 1;
w2 = [[1.1; -0.1], [1.25; 0.15], [0.9; 0.1], [0.1; 1.2], [0.2; 0.9]];
w2(3,:) = 1;

% Get the 5 decision Hyper Planes
for i=1:5
g{i} = sPercep(w1(:,i), w2, 10);
end
% Decision Node
scatter(w1(1,:),w1(2,:))
hold all, scatter(w2(1,:), w2(2,:), 'rx')
for i=1:5
refline(-g{i}(1)/g{i}(2),-g{i}(3)/(g{i}(2)))
end