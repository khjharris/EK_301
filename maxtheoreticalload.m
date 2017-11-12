function [failMember,failLoad] = maxtheoreticalload(C,x,y,T)
%F(l) = C/l^2
%C = 12277.78 N cm^2
%Here l is the length of the member and C is the constant found by experimentation

%Gets the number of joints and members
[numJoints,numMems]=size(C);

%Initializes vectors and variables
distance = zeros(numJoints,numJoints); %prepares a matrix for the distances between joints
vec = [];
count = 1;
CONS = 12277.78;
lengths=[];
bucklingLoad = zeros(1,numMems);
SR = zeros(1,numMems);
Failnum = 0;
Failval = 0;

%Makes the square matrix of distances
for i = 1:numJoints
    for j = 1:numJoints
        distance(i,j) = findr(x(i),x(j),y(i),y(j));
    end
end

%Prints out the square matrix of distances
fprintf('Square matrix of distances: \n');
disp(distance);
fprintf('\n');

%Produces the joints that each member is connected to
for k=1:numMems
    for w=1:numJoints
        if(C(w,k) == 1)
            vec(count) = w;
            count = count + 1;
        end
    end
end

%Prints out the joints each member is connected to
fprintf('Joints connected to each member: \n');
disp(vec);
fprintf('\n');

%Loop through vector with joints to produce vector with lengths
for b=1:2:(numMems*2)
    lengths = [lengths distance(vec(b),vec(b+1))];
end

%Prints the lengths of the members
fprintf('Lengths of the members: \n');
disp(lengths);
fprintf('\n');

%Calculate the Buckling Force for each member
for g=1:numMems
    bucklingLoad(g) = CONS/(lengths(g)*lengths(g));
end

%Prints the buckling force
fprintf('Buckling Force for each member: \n');
disp(bucklingLoad);
fprintf('\n');

%Calculate the SR ratio for all the members
for u=1:numMems
    SR(u)= T(u)/bucklingLoad(u);
end

%Prints the SR ratios
fprintf('SR ratios: \n');
disp(SR);
fprintf('\n');

%Find the member that fails
for m =1:numMems
    if SR(m) < Failval
        Failnum = m;
        Failval = SR(m);
    end 
end


%Calculate the Force of failure
failLoad = 1/SR(Failnum);
failMember = Failnum;

%Print the failmember and value
fprintf('Failure Load: \n');
disp(failLoad);
fprintf('\n');

fprintf('Failure Member: \n');
disp(failMember);
fprintf('\n');

end
function r = findr(x1,x2,y1,y2)
r = sqrt((x2-x1).^2 + (y2-y1).^2);
end

