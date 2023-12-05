import torch
# import torch.distributed as dist


def main():
    # Initialize the distributed environment.
    # dist.init_process_group(backend='nccl')

    # Get the current rank (node/process number in the cluster)
    # rank = dist.get_rank()

    # Get the number of GPUs available on the current node
    num_gpus = torch.cuda.device_count()

    print(f"Rank {1} has {num_gpus} CUDA devices available.")


if __name__ == "__main__":
    main()
