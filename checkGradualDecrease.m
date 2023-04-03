function isGraduallyDecreasing = checkGradualDecrease(matrix)
% Check if the numbers in the input matrix are gradually decreasing

% Get the dimensions of the matrix
[numRows, numCols] = size(matrix);

% Initialize the output variable to true
isGraduallyDecreasing = true;

% Iterate over each column of the matrix
for col = 1:numCols
    
    % Get the values in the current column
    columnValues = matrix(:, col);
    
    % Check if the values are in decreasing order
    if ~issorted(columnValues, 'descend')
        % If the values are not in decreasing order, set the output variable
        % to false and break out of the loop
        isGraduallyDecreasing = false;
        break;
    end
    
end

% Print the result
if isGraduallyDecreasing
    fprintf('The matrix values are gradually decreasing.\n');
else
    fprintf('The matrix values are NOT gradually decreasing.\n');
end

end
