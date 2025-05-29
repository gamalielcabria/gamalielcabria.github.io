# Intro to ARC and SLURM JOB submissions


## Getting Started with ARC (Advanced Research Computing) at the University of Calgary

This tutorial provides a quick-start guide for accessing and using ARC systems at the University of Calgary for high-performance computing tasks such as bioinformatics analysis, data processing, and simulations.

---

### 1. Getting Access

To access ARC:

1. Register for an ARC account at: [https://rcs.ucalgary.ca/How_to_get_an_account](https://rcs.ucalgary.ca/How_to_get_an_account)
2. You will receive login credentials and instructions after approval.

---

### 2. Connecting to ARC

Use SSH (Secure Shell) to log in from your terminal:

```bash
ssh <your user name>@arc.ucalgary.ca
```
Username is the same name you use for your University email (**john.doe** for an email with **john.doe@ucalgary.ca**).

If using Windows, install a terminal like Git Bash or use [MobaXterm](https://mobaxterm.mobatek.net/) or [Putty](https://www.putty.org/). Alternatively, you can connect to the **SHELL TERMINAL** of ARC through your local browser. Just use the [Open On-Demand ARC Shell Access](https://ood-arc.rcs.ucalgary.ca/pun/sys/shell/ssh/arc.ucalgary.ca)

Link for UCalgary ARC Open On-Demand Website: [OOD Dashboard](https://ood-arc.rcs.ucalgary.ca/pun/sys/dashboard)  
<br>
<div>
    <img src="https://rcs.ucalgary.ca/images/d/d9/Open_OnDemand_Dashboard.jpg">
</div>

---

### 3. Transferring Files

Use `scp` or `rsync` to move data between your local machine and ARC.

#### Upload a file to ARC:

```bash
scp myfile.txt yourusername@arc.ucalgary.ca:/home/yourusername/
```

#### Download a file from ARC:

```bash
scp yourusername@arc.ucalgary.ca:/home/yourusername/results.csv .
```

---

### 4. Modules and Software

ARC uses **Environment Modules** to manage software. Load what you need:

```bash
module avail        # List all available modules
module load fastqc  # Load a specific tool
```

### 5. Softwares through Package Managers and environment management systems

ARC allows the usage of software installed in environment management systems.

What are environments?

```{note}
Package Manager (i.e. PIP and Conda) allows you to install softwares. Meanwhile, environment management system (Python Env and Conda)  allows you to manage software in isolated environments. For example, one workflow requires PERL 5.41 but another needs PERL 6.1. An environment management system allows you to install different versions of software concurrently onto two different environments.
```

The most common you will encounter are Python Virtual Environment (Python VENV) and CONDA. For detail installation please follow the following links:
[CONDA in ARC](https://rcs.ucalgary.ca/Conda_on_ARC)
[Python Virtual Environment in ARC](https://rcs.ucalgary.ca/Python#Virtual_environments)

---

### 6. File Storage

- To check your space in ARC use `arc.quota`
- Your home directory has limited quota (typically 500GB).
- For large files, use `/scratch` or `/project` space.
- Use `du -sh *` to check folder sizes.

---


## Introduction to SLURM for Bioinformatics Workflows

### 1. What is SLURM?

SLURM (Simple Linux Utility for Resource Management) is an open-source job scheduler used by many high-performance computing (HPC) clusters. It manages and allocates resources like CPUs, memory, and GPUs for your computational jobs.

<div class=image>
<img src="https://carinadocs.stanford.edu/sites/g/files/sbiybj23026/files/styles/responsive_large/public/media/image/slurm-chart_0.png?itok=f6XRiBsr">
</div>div>

### 2. Key Concepts

- **Job**: A script or command submitted to the queue.
- **Node**: A physical machine in the cluster.
- **Partition**: A queue of nodes, usually grouped by capabilities (e.g., `short`, `long`, `gpu`).
- **Scheduler**: The system that decides when and where jobs run.

---

### 3. Basic SLURM Commands

```bash
squeue             # View all running and queued jobs
sbatch job.slurm   # Submit a batch job
scancel 12345      # Cancel a job by its ID
sinfo              # Show partition and node status
```

---

### 4. Sample SLURM Script

```bash
#!/bin/bash
#SBATCH --job-name=fastqc_job       # Job name
#SBATCH --output=logs/fastqc_%j.out # Output file
#SBATCH --error=logs/fastqc_%j.err  # Error file
#SBATCH --ntasks=1                  # Number of tasks (processes)
#SBATCH --cpus-per-task=4           # CPUs per task
#SBATCH --mem=8G                    # Total memory
#SBATCH --time=01:00:00             # Time limit (hh:mm:ss)
#SBATCH --partition=short           # Partition name

# Load necessary modules
module load fastqc

# Run your command
fastqc -t $SLURM_JOB_CPUS_PER_TASK raw_reads/sample1.fastq -o results/
```

> 💡 `%j` is replaced by the job ID automatically.

---

### 5. Monitoring Your Job

```bash
squeue -u your_username       # Check your jobs
sacct -j JOBID                # Get job accounting details
```



---

## Tips

- Always test scripts with small data first.
- Use `--mail-type=END,FAIL` and `--mail-user=email@example.com` to get job status emails.
- Use `module avail` to see available tools on your cluster.
- Use `screen` or `tmux` if running interactive sessions.
- Clean up old files to avoid storage overuse.

---

## 9. Support

For help or custom software installs, contact ARC support:
📧 arc.support@ucalgary.ca  
🔗 [ARC Website](https://rcs.ucalgary.ca/arc)

---

## References

- [SLURM Documentation](https://slurm.schedmd.com/documentation.html)
- [Cheat Sheet (by Ohio Supercomputer Center)](https://www.osc.edu/sites/osc.edu/files/images/SLURM-Cheat-Sheet.pdf)
- [ARC Getting Started](https://rcs.ucalgary.ca/arc/getting-started)
- [SLURM Documentation](https://slurm.schedmd.com/documentation.html)
