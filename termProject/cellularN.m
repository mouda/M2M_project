function [x,y] = cellularN(N,R)

% N is the number of nodes
% R is the cell radius
% The number of node output may smaller than N to not go beyond the cell
% Output [x,y] are the x y coordinates of the nodes

x = zeros(1,N);
y = zeros(1,N);
numN = 1;
numL = 0;

while(numN < N)
    numL = numL+1;
    numN = numN + 6*numL;
end

numlyr = numL;
d = R/(numlyr-1);
numN = 0;
index = 1;

for l=1:numlyr
    for n=1:(6*l)
        index = index +1;
        if(numN > N)
            break;
        end
        
        order = mod(n,l); 
        side = floor(n/l);
        x0 = d*l*cos(side*pi/3) + d*order*cos(side*pi/3+2*pi/3);
        y0 = d*l*sin(side*pi/3) + d*order*sin(side*pi/3+2*pi/3);
        
        if(l<numlyr)
            x(index) = x0;
            y(index) = y0;
            numN = numN +1;
        elseif(x0^2+y0^2<=R^2)
            x(index) = x0;
            y(index) = y0;
            numN = numN +1;
        end
    end
end
fprintf('Number of node is %d \n',numN);
r = -R:R/1000:R;
plot(r,sqrt(R^2-r.^2),'k-',r,-sqrt(R^2-r.^2),'k-',x,y,'o');
axis equal
end