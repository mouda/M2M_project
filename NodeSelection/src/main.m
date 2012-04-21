%This is the main program in the node selection simulation.

%fprintf('hello\n');
[ x, y ] = nodeGenerate(100,300);
%disp(x);
%disp(y);
%scatter(x,y);

% setting up the scenraio
% construct the distance matrix d
for i = 1 : 100
    for j = 1 : 100
        d(i,j) = ((x(i) - x(j))^2 + (y(i) - y(j))^2)^(1/2);
    end
end
%disp(d);
% construct the variance vector

theta(1:length(x)) = 0.5;
%disp(theta);

[ covar] = covariance(theta,d,2500);
disp(theta);
