function up_fd=loop_finder(file,RefNet)
% Extract the nodes
ufile=unique(file);

%% Feedbacks
% Find rows with the elements in the first column

% Initialize up_fd as a cell array
up_fd = cell(size(ufile, 1), 1);

for itr = 1:size(ufile, 1)
    a1 = find(RefNet(:, 1) == ufile(itr, 1));
    a11 = RefNet(a1, 2);
    store_here_target = {};

    for j = 1:size(a11, 1)
        b1 = find(RefNet(:, 1) == a11(j));
        b11 = RefNet(b1, 2);

        for k = 1:size(b11, 1)
            c1 = find(RefNet(:, 1) == b11(k));
            c11 = RefNet(c1, 2);

            if any(c11 == ufile(itr, 1))
                disp('requirements met')
                entry = [ufile(itr, 1), a11(j, 1), b11(k, 1), ufile(itr, 1)];
                store_here_target{end+1} = entry;  % Add the current entry to the cell array
            else
                unique_c11 = unique(c11);

                for ii = 1:size(unique_c11, 1)
                    d1 = find(RefNet(:, 1) == unique_c11(ii));
                    d11 = RefNet(d1, 2);

                    if any(d11 == ufile(itr, 1))
                        disp('requirements met')
                        entry = [ufile(itr, 1), a11(j, 1), b11(k, 1), unique_c11(ii, 1), ufile(itr, 1)];
                        store_here_target{end+1} = entry;  % Add the current entry to the cell array
                    else
                        unique_d11 = unique(d11);

                        for jj = 1:size(unique_d11, 1)
                            e11 = find(RefNet(:, 1) == unique_d11(jj));
                            f11 = RefNet(e11, 2);

                            if any(f11 == ufile(itr, 1))
                                disp('requirements met')
                                entry = [ufile(itr, 1), a11(j, 1), b11(k, 1), unique_c11(ii, 1), unique_d11(jj, 1), ufile(itr, 1)];
                                store_here_target{end+1} = entry;  % Add the current entry to the cell array
                            end
                        end
                    end
                end
            end
        end
    end

    % Store the cell array in up_fd
    up_fd{itr, 1} = store_here_target;
end