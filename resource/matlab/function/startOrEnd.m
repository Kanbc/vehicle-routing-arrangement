function [next_nodes] = startOrEnd(current_position, remaining_tasks)
    start_set = unique(remaining_tasks.Start);
    
    if ismember(current_position,start_set)
        next_nodes = remaining_tasks(strcmp(remaining_tasks.Start, current_position),:).End;
    else
        next_nodes = start_set;
    end
        
end

