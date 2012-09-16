function [ HM selection ] = crossEntropy( SIGMA , sigma, delta, G, P, W, N0, H_limit)
% optimize the infromation we would like to transfer
% and return the solution string

% t = (1/2)*(log2(2*pi*exp(1)*sigma.*sigma./(delta.*delta)))./(W*log2(1+(G.*P)./(W.*N0)));


% initialize p
N = length(sigma);
alpha = 0.5;
p(1:N) = 1/2;
HM = 0;
S(1:N) = 0;

while( all( p < 0.05 | p > 0.95) == false )
    x = rand(8*N, N);
    pp = repmat(p,8*N,1);
    x = floor( x - pp) * (-1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The constraint
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % totalTime = x*transpose(t); 
    % notGood = find(totalTime > T);
    S = SIGMA(find(x(i,:)==1),find(x(i,:)==1));
    normS = size(S,1);
    HXs = log2((2*pi*exp(1)/(delta^2))^(normS)*det(S))/2;
    notGood = find(HXs < H_limit); 

    for i = 1 : length(notGood)
        S = SIGMA(find(x(i,:)==1),find(x(i,:)==1));
        normS = size(S,1);
        HXs = log2((2*pi*exp(1)/(delta^2))^(normS)*det(S))/2;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % calculate the total entropy
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        while ( HXs <  H_limit)
            % x(notGood(i),find(t == max(x(notGood(i),:).*t),1, 'first')) = 0;
            SIGMA_tmp = SIGMA;
            SIGMA_tmp(find(x(i,:)==1),find(x(i,:)==1))=0;
            max(SIGMA_tmp) = 1;
            
            x(notGood(i),) = 1;
        end
    end

    for i = 1 : 8*N
        %S = SIGMA(find(x(i,:)==1),find(x(i,:)==1));
        %normS = size(S,1);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % The objectvie function 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % HXs(i) = log2((2*pi*exp(1)/(delta^2))^(normS)*det(S))/2;
        % Calculate the total transmission time
        sum(log2(2*pi*exp(1)*sigma.*sigma)./(delta.*delta))./(W*log2(1+(G.*P)./(W.*N0)));
    end

    [ HXs indices] = sort(HXs,'descend');
    x = x(indices,:);
    indices = ceil(0.2*N*8);
    p = alpha*p + (1-alpha).*(sum(x(1:indices,:),1)/indices); 
end


HM = HXs(1);
selection = x(1,:);
end
