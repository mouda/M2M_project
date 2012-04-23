function [ HM selection ] = crossEntropy( SIGMA , sigma, delta, G, P, W, N0, T)
% optimize the infromation we would like to transfer
% and return the solution string

% calculate the minimum transfer time
t = (1/2)*(log2(2*pi*exp(1)*sigma.*sigma./(delta.*delta)))./(W*log2(1+(G.*P)./(W.*N0)));
% initialize p
N = length(sigma);
alpha = 0.5;
p(1:N) = 1/2;
HM = 0;
S(1:N) = 0;
while( isempty(find( p > 0.95 ))  || isempty(find( p < 0.05 )) )
x = rand(8*N, N);
pp = repmat(p,8*N,1);
x = ceil( x - pp);
totalTime = x*transpose(t); 
notGood = find(totalTime > T);
for i = 1 : length(notGood)
    while ( x(notGood(i),:)*transpose(t) > T)
        x(notGood(i),find(t == max(x(notGood(i),:).*t),1, 'first')) = 0;
    end
end
for i = 1 : 8*N
    S = SIGMA(find(x(i,:)==1),find(x(i,:)==1));
    normS = size(S,1);
    HXs(i) = log2((2*pi*exp(1)/(delta^2))^(normS)*det(S))/2;
end
[ HXs indices] = sort(HXs,'descend');
x = x(indices,:);
indices = ceil(0.2*N*8);
p = alpha*p + (1-alpha).*(sum(x(1:indices,:),1)); 
end


HM = HXs(1);
selection = x(1,:);

end
