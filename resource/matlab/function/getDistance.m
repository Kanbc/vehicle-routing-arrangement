function [distance_path] = getDistance(all_path, distances, tasks, node_names)
    
    name_arr = char(node_names.name);
    [row_num,~] = size(all_path);

    % Find positive from tasks
    positive = 0;
    [ task_rows , ~ ] = size(tasks);
    for i = 1:task_rows
        start_node = tasks(i,:).Start;
        end_node = tasks(i,:).End;
        start_num = find(name_arr == start_node{1});
        end_num = find(name_arr == end_node{1});
        count_num = tasks(i,:).Count;
        positive = positive + distances(start_num, end_num)*count_num;
    end
    
    pos_arr = zeros(row_num,1) + positive;

    % Find abs_distance from path
    abs_arr = zeros(row_num,1);
    for row = 1:row_num
        str_of_path = cellstr(reshape(all_path{row}, 3, [])');
        only_task = str_of_path(~strcmp(str_of_path,'***'));
        
        % get distance number
        task_arr   = char(only_task);
        start_node = task_arr(:,1);
        end_node   = task_arr(:,3);
        start_node_num = arrayfun(@(x) find(name_arr == x),start_node);
        end_node_num   = arrayfun(@(x) find(name_arr == x),end_node);
        
        abs = 0;
        distance_pos = [start_node_num, end_node_num]';
        for t=distance_pos
            distance_num = distances(t(1),t(2));
            abs = abs + distance_num;
        end
        
        abs_arr(row) = abs_arr(row) + abs;
        
    end
    
    % Negative
    neg_arr = -(abs_arr - pos_arr);
    
    % All
    all_arr = pos_arr + neg_arr;
    
    distance_path = [pos_arr, neg_arr, all_arr, abs_arr];
    
end

