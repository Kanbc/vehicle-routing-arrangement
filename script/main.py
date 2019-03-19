import numpy as np
import pandas as pd
import time
import multiprocessing as mp
import logging
import os
print('Number of Core :', mp.cpu_count())

ROOT_DIR = os.getcwd()
logging.basicConfig(
    filename=ROOT_DIR + '/output/info.log',
    level=logging.WARNING,
    format='%(asctime)s | %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
)

class VehicleRoutingArrangement:
    def __init__(self, node_names, distances_matrix, tasks):
        self.full_node_names = node_names
        self.node_names = node_names['name'].values
        self.distances = distances_matrix
        self.tasks = tasks

    def checkRemainingTasks(self, job_done):
        remaining_tasks = self.tasks.copy()
        if len(remaining_tasks) > 0:
            active_path = tasks['path'].values
            job_done = job_done[np.isin(job_done, active_path)]

            job_unique, job_counts = np.unique(job_done, return_counts=True)
            job_done_df = pd.DataFrame(
                {'path': job_unique, 'Count': job_counts})

            merged_df = remaining_tasks.merge(
                job_done_df, on='path', how='outer')
            merged_df.loc[merged_df['Count_y'].isnull(), 'Count_y'] = 0
            merged_df['Count'] = merged_df['Count_x'] - merged_df['Count_y']
            output = merged_df[merged_df['Count'] >
                               0][['Start', 'End', 'path', 'Count']]
            return output
        else:
            return remaining_tasks

    def startOrEnd(self, current_position, rm_task):
        start_set = rm_task['Start'].unique()
        if current_position in start_set:
            return rm_task[rm_task['Start'] == current_position]['End'].values
        else:
            return start_set

    def nextJobsMatrix(self, job_done, next_nodes):
        current_position = job_done[-1].split('-')[-1]
        next_jobs = current_position + '-' + next_nodes

        if len(job_done[0]) > 1:
            ini_mat = np.tile(job_done, (len(next_jobs), 1))
            output = np.hstack((ini_mat, np.array([next_jobs]).T))
        else:
            output = np.array([next_jobs]).T
        return output

    def jobMatrix(self, each_row):
        remaining_jobs = self.checkRemainingTasks(each_row)
        if len(remaining_jobs) == 0:
            job_matrix = np.append(each_row, '0')
        else:
            current_position = each_row[-1].split('-')[-1]
            next_nodes = self.startOrEnd(current_position, remaining_jobs)
            job_matrix = self.nextJobsMatrix(each_row, next_nodes)
        return job_matrix

    def allPath(self, before_path):
        start_time = time.time()

        # Pool Multiple Processing
        pool = mp.Pool(processes=16)
        output_list = pool.map(self.jobMatrix, before_path)
        output = np.vstack(output_list)

        last_column = output[:, -1]
        all_zero = sum(last_column == '0')
        stop_time = time.time() - start_time
        logging.warning('Output Matrix Shape :' + str(output.shape) +', Use Time :' + str(stop_time) + 's')
        if all_zero == len(last_column):
            return output
        else:
            return self.allPath(output)

    def getDistance(self, startEndStr):
        tasks_arr = self.tasks['path'].values
        if startEndStr == '0':
            return 0
        else:
            start, end = startEndStr.split('-')
            i, j = np.where(self.node_names == start)[
                0][0], np.where(self.node_names == end)[0][0]
            return self.distances[i, j] if startEndStr in tasks_arr else -1*self.distances[i, j]

    def sumDistance(self, distance_arr):
        all_distances = sum(distance_arr)
        pos_distances = sum(distance_arr[distance_arr > 0])
        neg_distances = sum(distance_arr[distance_arr < 0])
        abs_distances = pos_distances + abs(neg_distances)
        return pos_distances, neg_distances, all_distances, abs_distances

    def allDistancePath(self, all_path):
        getDistanceAllElement = np.vectorize(self.getDistance)
        result_array = getDistanceAllElement(all_path)
        all_distance_path = np.apply_along_axis(
            self.sumDistance, 1, result_array)
        return all_distance_path

    def getTaskName(self, task_path):
        name_arr = self.full_node_names['name'].values
        only_task = task_path[task_path != '0']

        # แยกจุดเริ่ม-จบ
        def start_f(x): return x.split('-')[0]
        start_vf = np.vectorize(start_f)
        start_node = start_vf(only_task)

        def end_f(y): return y.split('-')[1]
        end_vf = np.vectorize(end_f)
        end_node = end_vf(only_task)

        row_num = len(only_task)

        name_list = []
        distance_list = []
        for i in range(row_num):
            # name
            start_name = self.full_node_names[self.full_node_names['name']
                                              == start_node[i]]['node'].values[0]
            end_name = self.full_node_names[self.full_node_names['name']
                                            == end_node[i]]['node'].values[0]
            name = start_name + '-' + end_name
            name_list.append(name)

            # distance
            start, end = start_node[i], end_node[i]
            m, n = np.where(name_arr == start)[
                0][0], np.where(name_arr == end)[0][0]
            before_path = only_task[0:i]
            remaining_tasks = self.checkRemainingTasks(before_path)
            current_task = task_path[i]
            if current_task in remaining_tasks['path'].values:
                distance_list.append(self.distances[m, n])
            else:
                distance_list.append(-self.distances[m, n])

        return pd.DataFrame({'Name': name_list, 'Distance': distance_list})


start_point = np.array([['A']])  # start_point
node_names = pd.read_csv('data/node_names.csv')
distances = pd.read_csv('data/distances_matrix.csv', header=None).values
tasks = pd.read_csv('data/demo_tasks.csv')[['Start', 'End', 'Count']]
tasks['path'] = tasks['Start'] + '-' + tasks['End']

vehicleObj = VehicleRoutingArrangement(node_names, distances, tasks)
all_path = vehicleObj.allPath(start_point)
np.save('output/all_path.npy', all_path)
