function [all_path] = findAllPath(old_all_path,tasks)
    
    all_path = cellfun(@(rows) findPath(rows, tasks), old_all_path, 'UniformOutput', false);
    all_path = vertcat(all_path{:});
    
    if ~iscell(all_path)
        all_path = cellstr(all_path);
    end
    
    [ ~, step ] = size(all_path{1});
    disp( strcat('Step  ',{' '}, string(step/3) ) );
    disp(all_path(1));
    
    is_done = lastPostionIsZero(all_path);
    if ~is_done
        all_path = findAllPath(all_path,tasks);
    end
    
end

