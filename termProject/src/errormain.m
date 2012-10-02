close all
clear all

setparams;

for i = 1:1
    [totalLinearErrorSquare(i, :), totalEquationErrorSquare(i, :)] = errorvsselectnum();
end

linearResult = mean(totalLinearErrorSquare, 1);
equationResult = mean(totalEquationErrorSquare, 1);

figure
plot(selectedNum:recept.n - 1, linearResult);
xlabel('selectedNum');
ylabel('totalLinearErrorSquare');
% xlim([selectedNum, recept.n - 1]);
figure
plot(selectedNum:recept.n - 1, equationResult);
xlabel('selectedNum');
ylabel('totalEquationErrorSquare');
% xlim([selectedNum, recept.n - 1]);