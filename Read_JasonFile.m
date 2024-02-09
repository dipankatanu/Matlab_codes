% Specify the path to your JSON file
json_file_path = 'path_to_your_file.json';

% Use jsondecode to read the JSON file
try
    json_data = jsondecode(fileread(json_file_path));
    
    % Display or process the JSON data as needed
    disp(json_data);
    
catch ME
    % Display error message if unable to read the JSON file
    disp(['Error reading JSON file: ' ME.message]);
end