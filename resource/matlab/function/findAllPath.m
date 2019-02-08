function [all_path,all_path_t] = findAllPath(old_all_path,tasks)
    
    all_path = [];

    for job_done=old_all_path
        
        remaining_tasks = checkRemainingTasks(job_done,tasks);
        [len_rm_tasks,~] = size(remaining_tasks);
        
        if len_rm_tasks > 0
            current_position = job_done(end);
            next_nodes = startOrEnd(current_position, remaining_tasks);
            job_matrix = nextJobsMatrix(job_done, next_nodes);
        else
            job_matrix = { strcat(job_done', '***') };
        end
        all_path = [ all_path; job_matrix ];
    end
        
    is_done = lastPostionIsZero(all_path);
    if ~is_done
        all_path_t = char(all_path)';
        all_path = findAllPath(all_path_t,tasks);
    end

end

