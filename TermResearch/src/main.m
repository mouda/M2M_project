close all
clear all

setparams;

C = gplume(recept.x, recept.y, recept.z, source.z, source.expectQ, Uwind);



%m(1:300) = false;
%myplot(recept.x, recept.y, C, m);

covmatrix = covariance(recept.x, recept.y, source.expectQ, Uwind, source.z);
%[ minInfo nodeSelect] = crossEntropy;
