function [totalLinearErrorSquare] = calculateLinearErrorSquare(recept, dep)
    totalLinearErrorSquare = sum((griddata(recept.x(~recept.linearDroped), recept.y(~recept.linearDroped), dep(~recept.linearDroped), recept.x(recept.linearDroped), recept.y(recept.linearDroped)) - dep(recept.linearDroped)) .^ 2);
end