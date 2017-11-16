function a = makeA (c, sx, sy, x, y)

% Finds sizes of relevant matrices
[rowC, colC] = size(c);
[rowSx, colSx] = size(sx);
[rowSy, colSy] = size(sy);

% Preallocates array to hold indices of two joints that each member is
% connected to
ind = zeros(1,2);

% Preallocates the A matrix to zeroes
a = zeros(2*rowC,colC+colSx);


% Calculates values for the top half of A that is concerned with the x
% forces
% Outer for loop loops over columns (ie, members)
for j = 1:colC
    counter = 1;
    % Loops over rows (ie, joints)
    for i = 1:rowC
        % If the value in c is a one, then the corresponding member and
        % joint are connected
        if (c(i,j))
            % Saves the number of the joint that this particular member is
            % connected to
            ind(1,counter) = i;
            counter = counter + 1;
        end
    end
    
    % Adds values to the two locations in each column that should have a
    % value
    % Each column (member) is connected to 2 joints, so each column has two
    % rows that have values
    a(ind(1), j) = x(ind(1))*(-1) + x(ind(2));
    a(ind(2), j) = x(ind(2))*(-1) + x(ind(1));
    r = findr(x(ind(1)), x(ind(2)), y(ind(1)),y(ind(2)));
    a(:,j) = a(:,j)/r;
end

% Calculates values for the top half of A that is concerned with the y
% forces

% Outer for loop loops over columns (ie, members)
for j = 1:colC
    counter = 1;
    % Loops over bottom half of A rows (for y values)
    for i = (rowC+1):(2*rowC)
        % If the member and joint are connected, then c(i-j, j) will have a
        % 1
        if (c(i-rowC,j))
            ind(1,counter) = i;
            counter = counter + 1;
        end
    end
    
    % Sets values for y forces in bottom half of A
    a(ind(1), j) = y(ind(1)-rowC)*(-1) + y(ind(2)-rowC);
    a(ind(2), j) = y(ind(2)-rowC)*(-1) + y(ind(1)-rowC);
    r = findr(x(ind(1)-rowC), x(ind(2)-rowC), y(ind(1)-rowC),y(ind(2)-rowC));
    
    % Only divides bottom half by the distance
    a((rowC+1):(2*rowC),j) = a((rowC+1):(2*rowC),j)/r;
end

% Adds support matrices to the end of A
a(1:2*rowC, (colC+1):(colC+colSx)) = [sx;sy];

end

% Finds distance between 2 points given all four coordinates
function r = findr(x1,x2,y1,y2)
r = sqrt((x2-x1).^2 + (y2-y1).^2);
end
            
