function [output] = lastPostionIsZero(allPath)

    last_str = cellfun(@(x) x(end-2:end), allPath, 'UniformOutput', false);
    one_arr = strcmp(last_str,'***');
    
    % all is ***
    if sum(one_arr) == length(last_str)
        output = 1;
    else
        output = 0;
    end
    
end

