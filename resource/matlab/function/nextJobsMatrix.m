function [job_matrix] = nextJobsMatrix(job_done, next_nodes)

    current_position = job_done(end);
    next_jobs = strcat(current_position, '-', next_nodes);
    
    if length(job_done) > 1
        job_matrix = strcat(job_done, next_jobs);
    else
        job_matrix = next_jobs;
    end

end

