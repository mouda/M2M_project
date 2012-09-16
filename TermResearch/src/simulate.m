function [ result axis ] = simulate(dTxPower, lowerbound, upperbound, Bw, N0, G, sigmaForEachSensor, sigmaCritria, ErrBound, Probability, recept );

for TxPowerIt = lowerbound:dTxPower:upperbound

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate the sample times per sensor
% ErrBound = 10^-5
% Probability
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
func = @(x)Probability- (normcdf(ErrBound,0,x)-0.5)*2;
sigmaCritria = fzero(func,ErrBound); 

samplesPerNode(1:recept.n)=0;
for i = 1:recept.n
	samplesPerNode(i) = floor((sigmaForEachSensor(i)/sigmaCritria)^(1/2));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the data need to transmit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta=ceil(abs(log2(ErrBound)));
H = -(1/2)*log2((2*pi*exp(1)*sigmaForEachSensor.*sigmaForEachSensor)/delta^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Channel Status                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Gi  = G .* ((sqrt(recept.x.*recept.x + recept.y.*recept.y)*10^-3).^(-4.281));
ChannelCapacity = Bw*log2(1+((Gi*TxPowerIt)/(Bw*N0)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transimission time                                                          % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timePerSensor = H./ChannelCapacity;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Total Transimission time  (baseline)                                        % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if TxPowerIt == lowerbound
    totalTime = sum(samplesPerNode'.*timePerSensor);
    else
    totalTime = [totalTime sum(samplesPerNode'.*timePerSensor)];
end
end 
axis = lowerbound:dTxPower:upperbound;
result = totalTime;
end
