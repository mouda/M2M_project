close all
clear all

setparams;

warning('OFF', 'MATLAB:divideByZero');
glc = ermak(xmesh - source.x, ymesh - source.y, 0.0, source.z, source.Q, Uwind, Wdep, Wset);
dep = A * dt * Wdep * ermak(recept.x - source.x, recept.y - source.y, recept.z, source.z, source.Q, Uwind, Wdep, Wset);

clist = [0.001, 0.01, 0.02, 0.05, 0.1];
[c2, h2] = contourf(xmesh, ymesh, glc * 1e6, clist);
clabel(c2, h2, 'FontSize', 8);
colorbar;
set(gca, 'XLim', xlim);
set(gca, 'YLim', ylim);
xlabel('x (m)');
ylabel('y (m)');
title('Zn concentration (mg/m^3)');

hold on
plot(source.x, source.y, 'ro', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
greencolor = [0, 0.816, 0];
plot(recept.x, recept.y, 'g^', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', greencolor);
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
tri = delaunay(recept.x, recept.y);
trisurf(tri, recept.x, recept.y, dep);
colorbar;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num = recept.n;
while num > selectedNum
    linearErrorSquare = 99999999;
    equationErrorSquare = 99999999;
    for i = 1:recept.n
        if ~recept.linearDroped(i)
            tmpDroped = recept.linearDroped;
            tmpDroped(i) = true;
            tmpx = recept.x(~tmpDroped);
            tmpy = recept.y(~tmpDroped);
            tmpz = dep(~tmpDroped);
            tmpErrorSquare = (griddata(tmpx, tmpy, tmpz, recept.x(i), recept.y(i)) - dep(i)) ^ 2;
            if tmpErrorSquare < linearErrorSquare
                linearErrorSquare = tmpErrorSquare;
                tmpLinearIndex = i;
            end
        end
        if ~recept.equationDroped(i)
            tmpDroped = recept.equationDroped;
            tmpDroped(i) = true;
            inter.x = recept.x(i);
            inter.y = recept.y(i);
            inter.z = recept.z(i);
            tmpRecept.x = recept.x(~tmpDroped);
            tmpRecept.y = recept.y(~tmpDroped);
            tmpRecept.z = recept.z(~tmpDroped);
            tmpRecept.dep = dep(~tmpDroped);
            tmpErrorSquare = (myinterpolation(inter, tmpRecept, source, expectUwind, Wdep, Wset, A, dt) - dep(i)) ^ 2;
            if tmpErrorSquare < equationErrorSquare
                equationErrorSquare = tmpErrorSquare;
                tmpEquationIndex = i;
            end
        end
    end
    recept.linearDroped(tmpLinearIndex) = true;
    recept.equationDroped(tmpEquationIndex) = true;
    num = num - 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[totalLinearErrorSquare, totalEquationErrorSquare] = calculateErrorSquare(recept, source, dep, expectUwind, Wdep, Wset, A, dt);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
tri = delaunay(recept.x(~recept.linearDroped), recept.y(~recept.linearDroped));
trisurf(tri, recept.x(~recept.linearDroped), recept.y(~recept.linearDroped), dep(~recept.linearDroped));
colorbar;
myplot(recept.x, recept.y, dep, recept.linearDroped);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
tri = delaunay(recept.x(~recept.equationDroped), recept.y(~recept.equationDroped));
trisurf(tri, recept.x(~recept.equationDroped), recept.y(~recept.equationDroped), dep(~recept.equationDroped));
colorbar;
axis([-500, 500, -500, 500]);
myplot(recept.x, recept.y, dep, recept.equationDroped);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('totalLinearErrorSquare = %e\n', totalLinearErrorSquare);
fprintf('totalEquationErrorSquare = %e\n', totalEquationErrorSquare);