function [job_matrix] = nextJobsMatrix(job_done, next_nodes)
    current_position = job_done(end);
    job_matrix = job_done + next_nodes;
    
end

