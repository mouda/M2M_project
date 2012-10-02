function [ X ] = CorrelatedGaussian( means, stds, channel, sigma, NumPerNode )  
%Here we use 3 uncorrelated gaussian noise as input, whose mean's are 0 and Std's are 1.
R=normrnd(means , stds,[channel,NumPerNode]);
%Here is your covariance matrix, if all channels of signals have a Std of 1, then it is your correlation coefficient matrix.
%Do the Cholesky Decomposition of your covariance matrix sigma.
C=chol(sigma);
%Transform the input to 3 channels of correlated output.
X=C'*R;
X=X';
size(X)
% Let's see whether the covariance matrix of X now.
cov(X);
% Write Data to binary file

end
