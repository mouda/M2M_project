clear;
close all;
setparams;

C = gplume(recept.x, recept.y, recept.z, source.z, source.expectQ, Uwind);

%scatter(SensorX, SensorY);
%m(1:300) = false;
%myplot(recept.x, recept.y, C, m);

% Add the accuracy of requirement
ErrBound = 10^(-5);
Probability = 0.999;
% Add the uncertainty, choose the variance sigma randomly
sigmaForEachSensor = abs(randn(recept.n,1)*10^(-3));

% Specisfy which nodes should be control the sample times 
