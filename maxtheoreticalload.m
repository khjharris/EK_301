function [failMember,failLoad] = maxtheoreticalload(C,x,y,T)
%F(l) = C/l^2
%C = 12277.78 N cm^2
%Here l is the length of the member and

%Gets the number of joints and members
[numJoints,numMems]=size(C);

%Initializes vectors and variables
distance = zeros(numJoints,numJoints); %prepares a matrix for the distances between joints
vec = [];
lengths = zeros(numMems);
count = 1;
CONS = 12277.78;
bucklingLoad = zeros(numMems);
SR = zeros(numMems);
Failnum = 0;

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
    lengths(b) = distance(vec(b),vec(b+1));
end

%Calculate the Buckling Force for each member
for g=1:numMems
    bucklingLoad(g) = CONS/(lengths(g)*lengths(g));
end

%Calcualte the SR ration for all the members
for u=1:numMems
    SR(u)= T(u)/bucklingLoad(u);
end

%Find the member that fails
for m =1:numMems
    if SR(m) > Failnum
        Failnum = m;
    end 
end

%Calcualte the Force of failure
failLoad = 1/SR(Failnum);
failMember = Failnum;

end
function r = findr(x1,x2,y1,y2)
r = sqrt((x2-x1).^2 + (y2-y1).^2);
end

