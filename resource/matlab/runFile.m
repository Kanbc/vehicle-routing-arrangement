% ==== Clear old variable & Add function path ====
clear all;
close all;
clc;
addpath('function/');

% ==== Input Variable ====
% -- real data
% job_done = ['A']; % start_point
% node_names = readtable('data/node_names.csv'); % node_names
% distances = csvread('data/distances_matrix.csv'); % distances
% tasks_with_nodes = readtable('data/tasks.csv');
% tasks = tasks_with_nodes(:,{'Start','End','Count'});
% tasks.Path = strcat(tasks.Start, '-', tasks.End); % tasks

% -- demo data
job_done = ['A']; % start_point
node_names = readtable('data/demo/node_names.csv'); % node_names
distances = csvread('data/demo/distances_matrix.csv'); % distances
tasks_with_nodes = readtable('data/demo/tasks.csv');
tasks = tasks_with_nodes(:,{'Start','End','Count'});
tasks.Path = strcat(tasks.Start, '-', tasks.End); % tasks

% ==== Programing ====
tic
all_path = findAllPath(job_done, tasks);
toc
% distance_path