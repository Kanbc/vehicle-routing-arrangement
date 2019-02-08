function [remaining_tasks] = checkRemainingTasks(job_done,tasks)
    
    job_done = job_done';
    if length(job_done) > 1
        active_path = tasks.Path;
        job_arr = cellstr(reshape(job_done,3,[])');
        [~,idx] = ismember(job_arr, active_path);
        row_nums = idx(idx > 0);

        % decrease job that done    
        for row_num = row_nums(:)'
            tasks.Count(row_num) = tasks.Count(row_num) - 1;
        end

        remaining_tasks = tasks(tasks.Count > 0,:);
    else
        remaining_tasks = tasks;
    end
    
end

