function [lengths,failMember,failLoad] = maxtheoreticalload(C,x,y,T,L)
%F(l) = C/l^2
%C = 1277.78 N cm^2
%Here l is the length of the member and C is the constant found by experimentation

%Gets the number of joints and members
[numJoints,numMems]=size(C);

%Initializes vectors and variables
distance = zeros(numJoints,numJoints); %prepares a matrix for the distances between joints
vec = [];
count = 1;
CONS = 1277.78;
lengths=[];
bucklingLoad = zeros(1,numMems);
SR = zeros(1,numMems);
Failnum = 0;
Failval = 0;
failMember=[];

%Makes the square matrix of distances
for i = 1:numJoints
    for j = 1:numJoints
        distance(i,j) = findr(x(i),x(j),y(i),y(j));
    end
end

%Produces the joints that each member is connected to
for k=1:numMems
    for w=1:numJoints
        if(C(w,k) == 1)
            vec(count) = w;
            count = count + 1;
        end
    end
end

%Loop through vector with joints to produce vector with lengths
for b=1:2:(numMems*2)
    lengths = [lengths distance(vec(b),vec(b+1))];
end

% Calculate the Buckling Force for each member
for g=1:numMems
    bucklingLoad(g) = CONS/(lengths(g).*lengths(g));
end

disp(bucklingLoad)

% Calculates correction factor for buckling loads
for i = 1:numMems
    bucklingLoad(i) = ((lengths(i)/(lengths(i)-0.5))^2)*bucklingLoad(i);
end

disp(bucklingLoad)

% Calculates uncertainty for each member
unc = zeros(1, numMems);
for g=1:numMems
    unc(g) = 643.7125/(lengths(g)*lengths(g)*lengths(g));
end

% Calculate the SR ratio for all the members
for u=1:numMems
    SR(u)= T(u)/bucklingLoad(u);
end

% Find the member that fails first
for m =1:numMems
    if SR(m) < Failval
        Failnum = m;
        Failval = SR(m);
    end 
end

%Checking if more than one member fails first
for m=1:numMems
    if SR(m)==Failval
        failMember=[failMember m];
    end
end

%Calculate the Force of failure
failLoad = sum(L)/abs(SR(Failnum));

end
function r = findr(x1,x2,y1,y2)
r = sqrt((x2-x1).^2 + (y2-y1).^2);
end

