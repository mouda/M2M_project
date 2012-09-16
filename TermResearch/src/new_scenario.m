clear;
close all;
setparams;
% Setup the sensor
% [SensorX, SensorY] = nodeGenerate(recept.n,500);
% Setup the environment
C = gplume(recept.x, recept.y, recept.z, source.z, source.expectQ, Uwind);

%scatter(SensorX, SensorY);
%m(1:300) = false;
%myplot(recept.x, recept.y, C, m);

% Add the accuracy of requirement
ErrBound = 10^(-5);
Probability = 0.999;
% Add the uncertainty, choose the variance sigma randomly
sigmaForEachSensor = abs(randn(recept.n,1)*10^(-3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate the sample times per sensor
% ErrBound = 10^-5
% Probability
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
func = @(x)Probability- (normcdf(ErrBound,0,x)-0.5)*2;
sigmaCritria = fzero(func,10^-5); 

samplesPerNode(1:recept.n)=0;
for i = 1:recept.n
	samplesPerNode(i) = floor((sigmaForEachSensor(i)/sigmaCritria)^(1/2));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the data need to transmit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta=ceil(abs(log2(ErrBound)));
H = -(1/2)*log2((2*pi*exp(1)*sigmaForEachSensor.*sigmaForEachSensor)/delta^2);

dTxPower = 0.001;
TxPowerAxis = 0.01:dTxPower:1
for TxPower = 0.01:dTxPower:1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Channel Status                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Gi  = G .* ((sqrt(recept.x.*recept.x + recept.y.*recept.y)*10^-3).^(-4.281));
ChannelCapacity = Bw*log2(1+((Gi*TxPower)/(Bw*N0)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transimission time                                                          % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timePerSensor = H./ChannelCapacity;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Total Transimission time  (baseline)                                        % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if TxPower == 0.01
    totalTime = sum(samplesPerNode'.*timePerSensor);
    else
    totalTime = [totalTime sum(samplesPerNode'.*timePerSensor)];
end
end 
plot(TxPowerAxis, totalTime);
