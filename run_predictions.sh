#!/bin/bash

#SBATCH --job-name=smoke3_vel_buo3_f250
#SBATCH --time=4:00:00
#SBATCH --output=00_smoke3_vel_buo3_f250.out
#SBATCH --error=00_smoke3_vel_buo3_f250.err
#SBATCH --partition=general
#SBATCH --mem-per-gpu=8G           # memory per GPU required by your script. This is NOT GPU memory
#SBATCH --gpus=1            # total number of GPUs required: gpu-type:qty
#SBATCH --gpus-per-task=1   # gpu-type:qty
#SBATCH --cpus-per-task=1           # number of cpus (not hyperthreaded) per task

echo "`date` Starting Job"
echo "SLURM Info: Job name:${SLURM_JOB_NAME}"
echo "    JOB ID: ${SLURM_JOB_ID}"
echo "    Host list: ${SLURM_JOB_NODELIST}"


source /opt/conda/bin/activate deep_fluids
python main.py \
  --is_3d=True \
  --dataset=smoke3_vel5_buo3_f250 \
  --res_x=112 \
  --res_y=64 \
  --res_z=32 \
  --batch_size=100 \
  --max_epoch=50 \
  --num_worker=1 \
  --log_step=100 \
  --test_step=20
