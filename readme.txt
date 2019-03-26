1. start VM
2. ssh
3. $ cd /home/kan/vehicle-routing-arrangement/script/
4. $ chmod +x main.py
5. $ nohup python3 main.py &
6. $ ps ax | grep main.py (ไว้ check ว่ายัง run อยู่)
7. (Local) $ gcloud compute scp standard-python-runner:/home/kan/vehicle-routing-arrangement/script/output/info.log $(pwd)/info.log
8. (Local) $ gcloud compute scp standard-python-runner:/home/kan/vehicle-routing-arrangement/script/output/all_path.npy $(pwd)/all_path.npy