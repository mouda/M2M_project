function [ covMatrix ]  = covariance( theta, d , a )
%this function is used to generate the converance matrix

covMatrix = transpose(theta)*theta.*exp(-d.*d/a);

end
