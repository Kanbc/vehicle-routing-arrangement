function [job_matrix] = findPath(job_done,tasks)
    
    remaining_tasks = checkRemainingTasks(job_done,tasks);
    [len_rm_tasks,~] = size(remaining_tasks);

    if len_rm_tasks > 0
        current_position = job_done(end);
        next_nodes = startOrEnd(current_position, remaining_tasks);
        job_matrix = nextJobsMatrix(job_done, next_nodes);
    else
        job_matrix = strcat(job_done, '***');
    end
    
end

