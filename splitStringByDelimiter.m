function separatedVariables = splitStringByDelimiter(inputString, delimiter)
    % SPLITSTRINGBYDELIMITER Splits an input string using a specified delimiter
    % 
    % Usage:
    % separatedVariables = splitStringByDelimiter(inputString, delimiter)
    %
    % Inputs:
    %   - inputString: A string with variables separated by a delimiter
    %   - delimiter: The delimiter used to separate the variables
    %
    % Outputs:
    %   - separatedVariables: A cell array containing the separated variables
    
    % Split the input string using the specified delimiter
    separatedVariables = split(inputString, delimiter);
end
