
% to test the output data we write into file, we need to specisfy number of nodes and  size of data for each node

N = 100; % number of nodes
dataSize = 1000; % size of data for each node

fid = fopen('../outputs/RNG.out','r');
c = fread(fid,'double')
for i = 1 : N
    data(:,i) = c((i-1)*dataSize + 1 : i*dataSize);
end
