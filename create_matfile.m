%This script will create the .mat input file

j=input('How many joints are in the truss: ');
m=input('How many members are in the truss: ');

% Preallocates C matrix to hold joint and member connections
C=zeros(j,m);

% While loop runs until user is satisfied with entries and entries are
% correct
right = true;
while right
    for i = 1:j
        question = sprintf('Which members are connected to joint %d?: ',i);
        % User inputs vector with members
        tempm = input(question);
        
        % Sets corresponding value of C to 1 to indicate connection
        for k = 1:length(tempm)
            C(i, tempm(k)) = 1;
        end
    end
    
    % Checks values
    
    % Checks that every column in C adds to 2 (because each member should
    % only be connected to 2 joints)
    Csum = sum(C);
    twos = ones(1,m)*2;
    if (~isequal(Csum,twos))
        right = true;
    else
        % Checks with user for correct input
        right = input('Are all these values correct? ','s');
        if right == 'y'
            right = false;
        else
            right = true;
        end
    end
end

Sx=zeros(j,3);
Sy=zeros(j,3);

supports=input('Enter all joint numbers that have support forces in a vector: ');

right = true;
while right
    for i=1:length(supports)
        question=sprintf('Is support %d a pin(p) or roller(r)?: ',supports(i));
        p_or_r=input(question,'s');
        % A pin support indicates a support force in the x and y directions
        if p_or_r=='p'
            Sx(supports(i),1)=1;
            Sy(supports(i),2)=1;
            
        % A roller support only has a support force in the y direction
        elseif p_or_r=='r'
            Sy(supports(i),3)=1;
        else
            % Error checks for values other than pin or roller
            while (p_or_r ~= 'p' && p_or_r ~= 'r')
                disp('Try again. Input p for pin or r for roller: ')
                p_or_r = input();
                if P_or_r=='p'
                    Sx(supports(i),1)=1;
                    Sy(supports(i),2)=1;
                elseif p_or_r=='r'
                    Sy(supports(i),3)=1;
                end
            end
        end
    end
    
    % Checks with user for correct inputs
    right = input('Are all these values correct? ','s');
    if right == 'y'
        right = false;
    else
        right = true;
    end
end

X=zeros(1,j);
Y=zeros(1,j);

right = true;
while right
    for i=1:j
        question=sprintf('What are the coordinates of joint %d?: ',i);
        % Receives a vector input with coordinates of each joint
        coords=input(question);
        X(i) = coords(1);
        Y(i) = coords(2);
    end
    
    % Checks with user for correct input
    right = input('Are all these values correct? ','s');
    if right == 'y'
        right = false;
    else
        right = true;
    end
end

L=zeros(2*j,1);

right = true;
while right
    L_index=input('Which joint is the load applied at?: ');
    L_val=input('What is the Force value (N) of the load?: ');
    
    % Corrects L_index to vertical force instead of horizontal
    L_index = L_index + j;

    L(L_index)=L_val;
    
    % Checks with user for correct input
    right = input('Are all these values correct? ','s');
    if right == 'y'
        right = false;
    else
        right = true;
    end
end

% Saves matfile to be tested later!
save('PrattTruss','C','Sx','Sy','X','Y','L')