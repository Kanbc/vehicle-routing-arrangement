function [remaining_tasks] = checkRemainingTasks(job_done,tasks)
    
    if length(job_done) > 1
        active_path = tasks.Path;
        job_arr = cellstr(reshape(job_done,3,[])');
        [~,idx] = ismember(job_arr, active_path);
        row_nums = idx(idx > 0); % [1,1,6,2,1]
        
        % decrease job that done   
        unique_num = unique(row_nums);
        n_of_unique_num = histc(row_nums,unique_num);
        tasks(unique_num,:).Count = tasks(unique_num,:).Count - n_of_unique_num;

        remaining_tasks = tasks(tasks.Count > 0,:);
    else
        remaining_tasks = tasks;
    end
    
end

