function [ solution ] = crossEntropy( covaranceMatrix , theta, delta)
% optimize the infromation we would like to transfer
% and return the solution string

% calculate the minimum transfer time
t = (1/2)*log2(2*pi*exp(1).*theta/delta)/(log2(1+(G*P)/(W*N0)));

end
