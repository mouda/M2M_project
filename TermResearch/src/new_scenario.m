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

MarkerEdgeColors=[1 0 0; 0 1 0; 0 0 1; 1 0 1];
it=1;
for ErrBoundIt=[10^-4 10^-5 10^-6 10^-7]
    [ totalTime TxPowerAxis]=simulate(0.01, 0.01,0.5, Bw, N0, G,... 
    sigmaForEachSensor, sigmaForEachSensor, ErrBoundIt, Probability, recept);
    hold on
    xlabel('Tx power (watt)');
    ylabel('Total Tx time (ms)');
    plot(TxPowerAxis, totalTime,'color',MarkerEdgeColors(it,:));
    it = it+1;
end
hold off
