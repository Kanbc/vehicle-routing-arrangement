function [output] = getTaskName(task_path, node_names, distances, tasks)
    
    name_arr = char(node_names.name);

    task_cell  = cellstr(reshape(task_path,3,[])');
    only_task = task_cell(~strcmp(task_cell,'***'));
    
%     active_path = tasks.Path;
%     [~,idx] = ismember(only_task, active_path);
    
    task_arr   = char(only_task);
    start_node = task_arr(:,1);
    end_node   = task_arr(:,3);
    
    [row_num,~] = size(task_arr);
    
    % node name    
    name = cell(row_num,1);
    distance = zeros(row_num,1);
    for i = 1:row_num
        % name        
        start_name = node_names(strcmp(node_names.name, start_node(i)),:).node;
        end_name = node_names(strcmp(node_names.name, end_node(i)),:).node;
        name(i) = strcat(start_name, '-', end_name);
        
        % distance
        start_node_num = find(name_arr == start_node(i));
        end_node_num   = find(name_arr == end_node(i));
        
        before_path = task_path(1:3*(i-1)); 
        remaining_tasks = checkRemainingTasks(before_path,tasks);
        current_task = {task_path(3*(i-1)+1:3*i)}; 
        % -- if current task in remaining_tasks
        if ismember(current_task, remaining_tasks.Path)
            distance(i) = distances(start_node_num,end_node_num);
        else
            distance(i) = -distances(start_node_num,end_node_num);
        end
    end
        
    output = table(name, distance);    
end

