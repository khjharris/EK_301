function [cost, costratio] = calc_costratio(lengths, numjoints, failLoad)

cost=10*numjoints+sum(lengths);
costratio=abs(failLoad/cost);

end

