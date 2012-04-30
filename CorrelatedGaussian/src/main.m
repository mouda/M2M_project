
% This is the progrma to test the functionality of the generator Correlated 
% Gausisian
% 
N = 100;
P(1:N)  = 0.01; 
W = 180;%kHz
N0 = 10^(-12);
T = 50; %s
delta = 2^(-8);

%fprintf('hello\n');
[ x, y ] = nodeGenerate(N,300);
G(1:N)  = 10^(-13.11) .* ((sqrt(x.*x + y.*y)*10^(-3)).^(-4.281));


% setting up the scenraio
% construct the distance matrix d
for i = 1 : N
    for j = 1 : N
        d(i,j) = ((x(i) - x(j))^2 + (y(i) - y(j))^2)^(1/2);
    end
end
%disp(d);
% construct the variance vector

sigma(1:length(x)) = 0.5;
%disp(theta);

[ covar] = covariance(sigma,d,2500);


X = CorrelatedGaussian(0, 1 ,N , covar );



% write the data output into the file which we asign the name
fid = fopen('../outputs/RNG.out', 'wb');
fwrite(fid, X, 'double');
