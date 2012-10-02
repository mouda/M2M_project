function [totalEquationErrorSquare] = calculateEquationErrorSquare(recept, source, dep, expectUwind, Wdep, Wset, A, dt)
    p = ermak(recept.x(~recept.linearDroped) - source.x, recept.y(~recept.linearDroped) - source.y, recept.z(~recept.linearDroped), source.z, 1, expectUwind, Wdep, Wset);
    rhs = dep(~recept.linearDroped) / (A * dt * Wdep);
    [Q, res] = lsqlin(p, rhs);
    totalEquationErrorSquare = sum((A * dt * Wdep * ermak(recept.x(recept.linearDroped) - source.x, recept.y(recept.linearDroped) - source.y, recept.z(recept.linearDroped), source.z, Q, expectUwind, Wdep, Wset) - dep(recept.linearDroped)) .^ 2);
end