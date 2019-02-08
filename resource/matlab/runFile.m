% ==== Clear old variable & Add function path ====
clear all;
close all;
clc;
addpath('function/');

% ==== Input Variable ====
% job_done = ['A']; % start_point
job_done = ['A-B','B-H','H-A','A-F','F-A','A-F'];
% job_done = ['A-B','B-H','B-I','B-I','K-L','A-F','A-F','A-J','C-F','D-E','D-G','A-F','A-I','A-I','K-L','K-L'];

node_names = readtable('data/node_names.csv'); % node_names
distances = csvread('data/distances_matrix.csv'); % distances
tasks_with_nodes = readtable('data/tasks.csv');
tasks = tasks_with_nodes(:,{'Start','End','Count'});
tasks.Path = strcat(tasks.Start, '-', tasks.End); % tasks

% ==== Programing ====
remaining_tasks = checkRemainingTasks(job_done,tasks);
[len_rm_tasks,~] = size(remaining_tasks);

if len_rm_tasks > 0
    current_position = job_done(end);
    next_nodes = startOrEnd(current_position, remaining_tasks);
%     job_matrix = 
else
    job_matrix = job_done;
end