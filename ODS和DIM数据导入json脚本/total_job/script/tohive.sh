#!/bin/bash

# 定义任务配置文件的目录
JOB_DIR="/export/server/datax/job/total_job"

# 获取任务配置文件列表
JOB_FILES=$(ls $JOB_DIR/*.json)

# 遍历任务配置文件列表
for JOB_FILE in $JOB_FILES; do
  echo "Running DataX job: $JOB_FILE"
  python /export/server/datax/bin/datax.py $JOB_FILE 
  echo "DataX job finished: $JOB_FILE"
  echo ""
done



