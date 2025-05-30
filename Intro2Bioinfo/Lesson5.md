---
title: Lesson 5 - BASH Scripting
parent: Intro to Bioinfo
nav_order: 6
---

# BASH Scripting Tutorial

This tutorial introduces the basics of BASH scripting, useful for automating tasks in bioinformatics.

**BASH** stands for **Bourne Again SHell** — it is a command-line interpreter or shell used in most Unix-based systems (like Linux and macOS). It allows users to interact with the system by typing commands and running scripts to automate tasks.

Key Points:
- **Shell**: A shell is a program that interprets your commands. BASH is one of the most popular Unix shells.
- **Command-line Interface (CLI)**: BASH runs in a terminal where you type commands to interact with files, run programs, and manage systems.
- **Scripting**: You can write BASH scripts (text files ending in .sh) that contain sequences of commands, logic, loops, and functions.

{:.note}
>**Why BASH is Important in Bioinformatics and Research Computing:**
>- Automates repetitive tasks (like running tools on hundreds of files)
>- Manages HPC jobs (e.g., submitting jobs via SLURM)
>- Enables reproducible workflows (especially when version-controlled)
>- Integrated in nearly every Unix-based server, cluster, or cloud environment



## Basic BASH Scripting

A BASH script is a plain text file with commands executed sequentially by the BASH shell.

### 📝 Creating a Script

```bash
nano my_script.sh
```

Add the following:

```bash
#!/bin/bash
echo "Hello from your first script!"
```

Then make it executable and run it:

```bash
chmod +x my_script.sh
./my_script.sh
```

`#!/bin/bash` is called a **shebang line**, and it tells the operating system which interpreter to use when executing the script.

Breakdown:
- `#!` is the shebang symbol. It must be at the very start of the script.
- `/bin/bash` is the full path to the **BASH shell**: this tells the system to run the script using BASH.

{:.note}
>**Why it's important:**
>
>Without the **shebang line**, the system might use the wrong shell or fail to interpret the script correctly. For example, different shells like `sh`, `zsh`, or `dash` interpret some commands differently.

---

## 🛠️ Variables and Input

Variables help reuse values and pass arguments.

```bash
#!/bin/bash
sample="Sample1"
echo "Processing data for $sample"
```

| Line                                 | Description                                                                                                   |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------- |
| `#!/bin/bash`                        | **Shebang** — tells the system to use the Bash shell to interpret the script.                                 |
| `sample="Sample1"`                   | Defines a **variable** named `sample` and assigns it the value `"Sample1"`.                                   |
| `echo "Processing data for $sample"` | **Prints** the message with the value of the variable. The output will be: <br> `Processing data for Sample1` |


### **Using arguments**:
Try making this script in `nano` or `vim`:

```bash
#!/bin/bash
echo "This script was called with: $1 and $2"
```

Afterwards, run it using this command.

```bash
./my_script.sh file1.txt file2.txt
```
What is the output?


{:.note}
>What it means:
>
>In Bash scripts, arguments are values passed to the script when it's run from the command line.
- `$1` refers to the **first** argument
- `$2` refers to the **second** argument

---

## 🔁 Loops
**BASH loops** let you repeat commands over a list of values, files, or a sequence of numbers — essential for automating tasks.

Use `for`, `while`, and `until` loops to handle different automation scenarios in your scripts.

### For Loops
This loop will print "Processing ..." for every `*.fastq` file in the directory.

```bash
for file in *.fastq; do
    echo "Processing $file"
done
```

### While Loops
This script uses a `while` loop to print numbers from 1 to 5. It initializes a counter `count=1`, checks that `count` is less than or equal to 5, prints the **value**, **increments it**, and **repeats the process** until the condition is false.

```bash
count=1
while [ $count -le 5 ]; do
  echo "Count is $count"
  ((count++))
done
```

The expected output would look like:
```
Count is 1
Count is 2
Count is 3
Count is 4
Count is 5
```

---

## ⚙️ Conditional Statements
**Conditional statements** in Bash let you make decisions in your scripts based on file checks, variable values, or command outputs.

**Example**:
```bash
if [ -f "genome.fasta" ]; then
    echo "Genome file found!"
else
    echo "Genome file is missing!"
fi
```
This checks whether the file genome.fasta exists:
- `-f` tests if it's a regular file.
- If the condition is **true**, it *prints a confirmation*.
- If **false**, it *prints a warning*.

Use `if`, `else`, and `elif` to add logic and control flow to your scripts.


---

## Real-World Example
Explain what this script does:

```bash
#!/bin/bash

indir="raw_data"
outdir="qc_results"
mkdir -p "$outdir"

for file in "$indir"/*.fastq; do
    if [ -s "$file" ]; then
        echo "Running FastQC on $file"
        fastqc "$file" -o "$outdir"
    else
        echo "Skipping $file, it is empty."
    fi
done

echo "All files processed."
```


<details>
<summary>Click for the answer</summary>

<pre><code class="language-bash">
This script automates quality control on `.fastq` files using FastQC:
- Declares the script as a Bash script.
- Sets input (raw_data) and output (qc_results) directories.
- `mkdir -p` ensures the output directory exists (creates it if it doesn't).
- Loops through all `.fastq` files in the input directory.
- Checks if the file is non-empty `-s "$file"` means file size greater than zero).
- When TRUE, Runs FastQC on the file and saves the result to the output directory.
- ELSE, if the file is empty, it prints a warning and skips processing.
- "done" ends the loop and prints a completion message.
</code></pre>
</details>

---

## Try It Yourself!

Create a script that checks if a `.gz` file exists, unzips it, and prints how many lines it has.

<details>
<summary>Click for the answer</summary>

<pre><code class="language-bash">
#!/bin/bash
file="example.gz"
if [ -f "$file" ]; then
    echo "Unzipping $file"
    gunzip -c "$file" | wc -l
else
    echo "$file not found."
fi
</code></pre>
</details>

---

## Summary

You’ve now learned how to:
- Create and execute BASH scripts
- Use variables and arguments
- Run loops and conditionals
- Process real data automatically

Enjoy scripting! :D

