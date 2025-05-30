---
title: Lesson 4 - Installing New Commands
parent: Intro to Bioinfo
nav_order: 5
---

# Lesson 4: Installing New Commands

Most Unix-based systems come with a set of core commands (like `ls`, `cd`, `cp`, `mv`, etc.). However, as your work becomes more specialized—especially in fields like bioinformatics, you’ll often need to install additional tools and commands.

## 💡 How It Works

Commands become available when you install new programs. These programs typically place their executable files in directories like `/usr/bin`, `/usr/local/bin`, or your user’s `~/bin`. Once installed and added to your system’s `PATH`, you can run them from the terminal just like built-in commands.

## ✅ Ways to Install Commands

- **Using a package manager**:
  - On Debian/Ubuntu:
    
    {:.activity}
    >```bash
    >sudo apt install fastqc
    >```

  - On macOS (with Homebrew):
    
    {:.activity}
    >```bash
    >brew install fastqc
    >```

- **With Conda (recommended for bioinformatics)**:
  
  {:.activity}
  >```bash
  >conda install -c bioconda fastqc
  >```

- **From source** (if no package is available):

  {:.activity}
  >```bash
  >git clone https://github.com/example/tool.git
  >cd tool
  >make && sudo make install
  >```

---

# 🎈 Example of installing new commands with Whimsical and Fun Linux Commands

Add some humor to your Linux terminal with these quirky and delightful commands! Below is a step-by-step guide to install and verify some of the most popular fun tools.

---

## 🐄 `cowsay`: Make a Cow Talk

An ASCII cow (or other creature) that repeats your message.

- **Install**
Depending on your OS (check your OS using `uname -a`), you can install using the following commands:

{:.activity}
>```bash
>sudo apt install cowsay        # Debian/Ubuntu
>sudo yum install cowsay        # RHEL/CentOS
>sudo pacman -S cowsay          # Arch
>```

- **Verify Installation**
Verify first where it is installed using `which` and then try running it!

{:.activity}
>```bash
>which cowsay      # Shows the path if installed
>cowsay "Hello!"   # Outputs: <Hello!> from a cow
>```

---

## 🖥️ `cmatrix`: Matrix Terminal Animation

Wanna be Nero? Try this. It mimics the "falling code" from The Matrix

- **Install**
Depending on your OS (check your OS using `uname -a`), you can install using the following commands:

{:.activity}
>```bash
>sudo apt install cmatrix
>sudo yum install cmatrix
>sudo pacman -S cmatrix
>```

- **Verify Installation**
Verify first where it is installed using `which` and then try running it!

{:.activity}
>```bash
>cmatrix        # Start the animation
>```
>Stop the animation using `Ctrl+c`

<br>

---

# 🐍 Installing and using Conda via Miniforge
Conda is a powerful package manager widely used in data science and bioinformatics. It can manage Python/R environments and install tools like `fastqc`, `samtools`, and more.

## Download and Install Miniconda
### For Linux/macOS:
Download lates conda installer from either Anaconda or Conda-Forge (Github).

{:.activity}
>```bash
>wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
>bash Miniforge3-Linux-x86_64.sh
>```

### For macOS:
- **Using macOS(Intel)**:

{:.activity}
>```
>wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-x86_64.sh
>bash Miniforge3-MacOSX-x86_64.sh
>```

- **Using macOS(M1/ARM)**:

{:.activity}
>```
>wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-MacOSX-arm64.sh
>bash Miniforge3-MacOSX-arm64.sh
>```

### Installing in HPC
If you are installing inside a high-performance computer (HPC), follow the specific guidelines your administrator recommends. For example here is a link for the installation of conda in [University of Calgary's HPC](https://rcs.ucalgary.ca/Conda_on_ARC).

{:.note}
>University of calgary suggest to **Decline** the option to initialize Conda/Miniforge in your shell startup. This prevents automatic activation, which can cause issues on shared systems.
>
>They suggest to **intialize conda manually**:
>```bash
># Create a script based on where conda is installed
>echo 'source ~/software/miniforge3/etc/profile.d/conda.sh' > ~/software/init-conda
>
># Run init-conda when using the server or put into job manager scripts:
>source ~/software/init-conda
>```

## Check Conda Installation
Check its version or find where it is installed:

{:.activity}
>```
>conda --version     # Version check
>which conda         # Find installation path
>```

Expected output for version check should look like this:

{:.activity}
>```
>conda 24.x.x
>```

You can activate an environment (i.e. `base` ) using the command:
```
conda activate <environment name>
```

Meanwhile, to deactivate the environment, run the following:
```
conda deactivate
```

{:.info}
>A **Conda environment** is an isolated workspace that allows you to manage specific packages and dependencies for a project without affecting your system or other projects. This is especially useful in bioinformatics, where different tools often require conflicting versions of libraries.
>
>To check the list of installed environments, run:
>```
>conda env list
>```


## Install Packages
Let us try installing the **fastq** file quality checker program, `fastqc`.

To install the `fastqc` in your current environment
```
conda install -c bioconda fastqc
```

{:.note}
>`-c` specifies from which channels the `fastqc` package can be found. For bioinformatics programs, it is usually in **bioconda** and/or **conda-forge**.

<br>

It is often recommended that you install programs of the same pipeline with no conflict with each other in the same environment. However, you can also create one environment per program you are installing.

{:.activity}
>```bash
>conda create -n bioinfo_env python=3.10
>conda activate bioinfo_env
>conda install -c bioconda fastqc
>```
>>{:.note}
>>You can specify the version of programs you install manually or else it would default to the latest version in the repository. 

<br>

## More Conda?
To learn more on how Conda/Miniforge/Mamba works, please check the following link for the [cheat sheet of conda](https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf). 

---
# Other tools for Bioinformatics

{:.highlight}
>Other than `conda`, there are several other package and environment manager you might use in bioinformatics.

| Tool                | Type                  | Description                                                                                            |
| ------------------- | --------------------- | ------------------------------------------------------------------------------------------------------ |
| **Conda**           | ✅ Both                | Manages packages and creates isolated environments. Widely used in bioinformatics with `bioconda`.     |
| **Mamba**           | ✅ Both                | A faster implementation of Conda using C++; handles environments and packages.                         |
| **pip**             | ✅ Package Manager     | Installs Python packages. Doesn’t handle environments by itself. Often used inside Conda environments. |
| **Bioconda**        | ✅ Package Source      | A Conda channel for bioinformatics packages. Works with Conda/Mamba.                                   |
| **CRAN**            | ✅ Package Manager     | R's base package system. Installs R packages.                                                          |
| **Bioconductor**    | ✅ Package Manager     | Extension of CRAN for bioinformatics in R.                                                             |
| **virtualenv**      | ✅ Environment Manager | Python tool for creating isolated environments. Doesn’t manage non-Python packages.                    |
| **Homebrew**        | ✅ Package Manager     | macOS/Linux system-level package manager. Installs bioinformatics tools like `samtools`, `blast`.      |
| **APT (apt-get)**   | ✅ Package Manager     | Debian/Ubuntu package manager for installing system software including bio tools.                      |
| **YUM / DNF**       | ✅ Package Manager     | Red Hat/CentOS/Fedora equivalent of APT.                                                               |
| **Nix**             | ✅ Both                | Purely functional manager for packages and environments. Focuses on reproducibility.                   |
| **Guix**            | ✅ Both                | Similar to Nix but GNU-based. Ideal for reproducible bioinformatics pipelines.                         |
| **Docker**          | ✅ Environment Manager | Containerizes full environments. Useful for reproducibility.                                           |
| **Singularity**     | ✅ Environment Manager | Container platform often used in HPC. Supports Docker-compatible containers.                           |
| **Galaxy Toolshed** | ✅ Package Manager     | Galaxy platform’s tool/package repository. Focused on workflows.                                       |
