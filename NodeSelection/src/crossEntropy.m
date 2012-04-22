function [ solution ] = crossEntropy( SIGMA , sigma, delta, G, P, W, N0, T)
% optimize the infromation we would like to transfer
% and return the solution string

% calculate the minimum transfer time
t = (1/2)*(log2(2*pi*exp(1)*sigma.*sigma./(delta.*delta)))./(W*log2(1+(G.*P)./(W.*N0)));
% initialize p
N = length(sigma);
p(1:N) = 1/2;
HM = 0;
S(1:N) = 0;
x = rand(8*N, N);

pp = repmat(p,8*N,1);
x = ceil( x - pp);
%for i = 1 : N
%    time = t(find( x(i) == 1);
%     while( sum(time)  > T) 
%         x(i,max(t)) = 0; 
%         time = time - t
%     end
%end
%size(x)
%size(t)
totalTime = x*transpose(t); 
notGood = find(totalTime > T);
for i = 1 : length(notGood)
    while ( x(notGood(i),:)*transpose(t) > T)
        x(notGood(i),find(t == max(x(notGood(i),:).*t),1, 'first')) = 0;
    end
end
for i = 1 : 8*N
    S = SIGMA(find(x(i,:)==1),find(x(i,:)==1));
end




end
