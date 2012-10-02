function [ nodeX, nodeY ] = nodeGenerate( N, r )
%to generate n nodes distributing a circle with radius as r uniformally

r = r*sqrt(rand(1,N)); 
theta = 2*pi*rand(1,N);

nodeX = r.*cos(theta);
nodeY = r.*sin(theta);
end
