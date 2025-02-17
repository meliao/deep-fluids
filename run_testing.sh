#!/bin/bash

#SBATCH --job-name=test_smoke3_vel_buo3_f250
#SBATCH --time=4:00:00
#SBATCH --output=00_test_smoke3_vel_buo3_f250.out
#SBATCH --error=00_test_smoke3_vel_buo3_f250.err
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
--is_train=False \
--load_path=predictions/2021-03-22_preds-10-epochs \
--model_path=log/smoke3_vel5_buo3_f250/0317_123909_de_tag/ \
--test_batch_size=5 \
--is_3d=True \
--dataset=smoke3_vel5_buo3_f250 \
--res_x=112 \
--res_y=64 \
--res_z=32 \
--batch_size=4 \
--num_worker=1 \
--test_params 0 0

python main.py \
--is_train=False \
--load_path=predictions/2021-03-22_preds-10-epochs \
--model_path=log/smoke3_vel5_buo3_f250/0317_123909_de_tag/ \
--test_batch_size=5 \
--is_3d=True \
--dataset=smoke3_vel5_buo3_f250 \
--res_x=112 \
--res_y=64 \
--res_z=32 \
--batch_size=4 \
--num_worker=1 \
--test_params 0 1
