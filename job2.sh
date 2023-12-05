#!/bin/bash
#SBATCH --job-name=your-job-name
#SBATCH --partition=debug
#SBATCH --time=72:00:00

### e.g. request 2 nodes with 2 gpu each, totally 4 gpus (WORLD_SIZE==4)
### Note: --gres=gpu:x should equal to ntasks-per-node
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --gpus=7
#SBATCH --cpus-per-task=2
#SBATCH --mem=2gb
#SBATCH --chdir=/storage/qlin_data/nml-slurm-testing
#SBATCH --output=/storage/qlin_data/nml-slurm-testing/out/%x-%j.out

### change 5-digit MASTER_PORT as you wish, slurm will raise Error if duplicated with others
### change WORLD_SIZE as gpus/node * num_nodes
export MASTER_PORT=12340
export WORLD_SIZE=4

### get the first node name as master address - customized for vgg slurm
### e.g. master(gnodee[2-5],gnoded1) == gnodee2
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR

### init virtual environment if needed
source /opt/anaconda3/etc/profile.d/conda.sh
conda activate base

### the command to run
srun python torchrun_test.py