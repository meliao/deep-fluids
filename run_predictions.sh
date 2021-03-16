#!/bin/bash

#SBATCH --job-name=smoke3_vel_buo3_f250
#SBATCH --time=24:00:00
#SBATCH --partition=general
#SBATCH --gres=gpu:1
#SBATCH --output=smoke3_vel_buo3_f250.out
#SBATCH --error=smoke3_vel_buo3_f250.err

echo "`date` Starting Job"
echo "SLURM Info: Job name:${SLURM_JOB_NAME}"
echo "    JOB ID: ${SLURM_JOB_ID}"
echo "    Host list: ${SLURM_JOB_NODELIST}"


python main.py \
  --is_3d=True \
  --dataset=smoke3_vel5_buo3_f250 \
  --res_x=112 \
  --res_y=64 \
  --res_z=32 \
  --batch_size=4 \
  --num_worker=1 \
  --log_step=100 \
  --test_step=20
