%This script will create the .mat input file

j=input('How many joints are in the truss: ');
m=input('How many members are in the truss: ');

C=zeros(j,m);

for i = 1:j
    question = sprintf('Which members are connected to joint %d?: ',i);
    tempm = input(question);
    for k = 1:length(tempm)
        C(i, tempm(k)) = 1;
    end
end

Sx=zeros(j,3);
Sy=zeros(j,3);

supports=input('Enter all joint numbers that have support forces in a vector: ');
for i=1:length(supports)
    question=sprintf('Is support %d a pin(p) or roller(r)?: ',supports(i));
    p_or_r=input(question,'s');
    if p_or_r=='p'
        Sx(supports(i),1)=1;
        Sy(supports(i),2)=1;
    elseif p_or_r=='r'
        Sy(supports(i),3)=1;
    else
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

X=zeros(1,j);
Y=zeros(1,j);
for i=1:j
    question=sprintf('What are the coordinates of joint %d?: ',i);
    coords=input(question);
    X(i) = coords(1);
    Y(i) = coords(2);
end

L=zeros(2*j,1);

L_index=input('Which joint is the load applied at?: ');
L_dir = input('Is the force in the vertical direction or horizontal? ','s');
L_val=input('What is the Force value (N) of the load?: ');

if (L_dir == 'v')
    L_index = L_index + j;
end

L(L_index)=L_val;

save('PrattTruss','C','Sx','Sy','X','Y','L')