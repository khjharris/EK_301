% Calculates forces on each member and each support force
function t = findforces(a, l)
inva = inv(a);
t = inva * l;
end