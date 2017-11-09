% Truss Analysis Script

% Loads appropriate variables
load TrussDesign1_LauraJoyLucaKenwood_A1.mat

digits(3);

% Calls function to make A matrix
A=makeA(C,Sx,Sy,X,Y);

% Finds forces on each member and all support forces and stores these
% values in T
T=findforces(A,L);

% Converts vector to cell array
T=num2cell(T);

% Rounds values to 3 significant figures
for i = 1:(length(T))
    T{i} = round(T{i}, 3, 'significant');
end

% Assigns tension or compression to each member force
for i=1:(length(T)-3)
    if T{i}<0
        T{i}=strcat(num2str(T{i}),' (C)');
    elseif T{i}>0
        T{i}=strcat(num2str(T{i}),' (T)');
    else
        T{i} = '0.00';
    end
end
    
disp('\% EK301, Section A1, Group 1: Laura Joy Erb, Luca Amorosa, Kenwood Harris, 11/11/2017')

% Prints applied load to truss
fprintf('Load: %.1f N\n',sum(L))

% Prints force on each member
for i=1:(length(T)-3)
    fprintf('m%d: %s\n',i,T{i})
end

disp('Reaction forces in Newtons:')

% Converts support force values to strings
for i = (length(T) - 2):length(T)
    if (T{i})
        T{i} = num2str(T{i});
    else
        T{i} = '0.00';
    end
end

% Prints each support force
fprintf('Sx1: %s\n',T{length(T)-2})
fprintf('Sy1: %s\n',T{length(T)-1})
fprintf('Sy2: %s\n',T{length(T)})

%Cost of truss
%Theoretical max load/cost ration A1, Group 1: Laura Joy Erb, Luca Amorosa, Kenwood Harris, 11/11/2017')