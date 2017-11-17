% Truss Analysis Script

% Loads appropriate variables

filename=input('Enter the name of the .mat file with extension: ','s');
load(filename);

% Calls function to make A matrix
A=makeA(C,Sx,Sy,X,Y);

% Finds forces on each member and all support forces and stores these
% values in T
T=findforces(A,L);

% Converts vector to cell array
T2=num2cell(T);

% Rounds values to 3 significant figures
for i = 1:(length(T2))
    T2{i} = round(T2{i}, 3, 'significant');
end

% Assigns tension or compression to each member force
for i=1:(length(T2)-3)
    if T2{i}<0
        T2{i}=strcat(num2str(abs(T2{i})),' (C)');
    elseif T2{i}>0
        T2{i}=strcat(num2str(abs(T2{i})),' (T)');
    else
        T2{i} = '0.00';
    end
end
    
disp('\% EK301, Section A1, Group 1: Laura Joy Erb, Luca Amorosa, Kenwood Harris, 11/11/2017')

% Prints applied load to truss
fprintf('Load: %.1f N\n',sum(L))

% Prints force on each member
for i=1:(length(T2)-3)
    fprintf('m%d: %s\n',i,T2{i})
end

disp('Reaction forces in Newtons:')

% Converts support force values to strings
for i = (length(T2) - 2):length(T2)
    if (T2{i})
        T2{i} = num2str(T2{i});
    else
        T2{i} = '0.00';
    end
end

% Prints each support force
fprintf('Sx1: %s\n',T2{length(T2)-2})
fprintf('Sy1: %s\n',T2{length(T2)-1})
fprintf('Sy2: %s\n',T2{length(T2)})

%Cost of truss
[lengths,failMember,failLoad]=maxtheoreticalload(C,X,Y,T,L);

[numjoints, nummemembs]=size(C);
[cost,costratio]=calc_costratio(lengths, numjoints, failLoad);

fprintf('Cost of truss: $%.2f\n',cost)
fprintf('Theoretical max load/cost ratio in N/$: %.4f\n',costratio)