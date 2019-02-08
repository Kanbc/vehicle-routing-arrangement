function [distance_path] = getDistance(all_path, distances, tasks, node_names)
    
    name_arr = char(node_names.name);
    active_path = tasks.Path;
    [row_num,~] = size(all_path);
    
    all_arr = [];
    pos_arr = [];
    neg_arr = [];
    
    for row = 1:row_num
        str_of_path = cellstr(reshape(all_path{row}, 3, [])');
        only_task = str_of_path(~strcmp(str_of_path,'***'));
        positive_tasks = ismember(only_task, active_path);
        
        % get distance number
        task_arr   = char(only_task);
        start_node = task_arr(:,1);
        end_node   = task_arr(:,3);
        start_node_num = arrayfun(@(x) find(name_arr == x),start_node);
        end_node_num   = arrayfun(@(x) find(name_arr == x),end_node);
        
        distance_pos = [positive_tasks, start_node_num, end_node_num]';
        positive = 0;
        negative = 0;
        
        for t=distance_pos
            distance_num = distances(t(2),t(3));
            if t(1) == 1
                positive = positive + distance_num;
            else
                negative = negative - distance_num;
            end
        end
        
        all_arr = [ all_arr; positive+negative ];
        pos_arr = [ pos_arr; positive ];
        neg_arr = [ neg_arr; negative ];
        
    end
    
    distance_path = [pos_arr, neg_arr, all_arr];
    
end

