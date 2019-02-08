function [output] = getTasksName(task_path, node_names)
    
    task_cell  = cellstr(reshape(task_path,3,[])');
    only_task = task_cell(~strcmp(task_cell,'***'));
    
    task_arr   = char(only_task);
    start_node = task_arr(:,1);
    end_node   = task_arr(:,3);
    
    [row_num,~] = size(task_arr);
    all_name = [];
    for i = 1:row_num
        start_name = node_names(strcmp(node_names.name, start_node(i)),:).node;
        end_name = node_names(strcmp(node_names.name, end_node(i)),:).node;
        all_name = [all_name; strcat(start_name, '-', end_name)];
    end
    
    output = all_name;
    
end

