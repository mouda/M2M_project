function interDep = myinterpolation(inter, recept, source, expectUwind, Wdep, Wset, A, dt)
    p = ermak(recept.x - source.x, recept.y - source.y, recept.z, source.z, 1, expectUwind, Wdep, Wset);
    rhs = recept.dep / (A * dt * Wdep);
    [Q, res] = lsqlin(p, rhs);
    interDep = A * dt * Wdep * ermak(inter.x - source.x, inter.y - source.y, inter.z, source.z, Q, expectUwind, Wdep, Wset);
end