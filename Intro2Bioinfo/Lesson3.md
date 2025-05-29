# Bioinformatics Training: Lesson 3

## Basic bioinformatics commands: 

There are tons of built-in commands within Linux OSes that are very useful for bioinformatic analysis. In this section, we will examine a few of the most commonly used commands in bioinformatics. We will adapt content from the Happy Belly Bioinformatics.

### `cut`

Extract specific columns from tab-delimited files.

```bash
cut -f1,3 data.tsv
# Extracts columns 1 and 3 from a tab-separated file.
```

### `grep`

Search for patterns in a file. Very useful for filtering sequences or logs.

```bash
grep "^>" sequences.fasta
# Shows all FASTA headers.
```

### `paste`

Combine files line by line.

```bash
paste genes.txt lengths.txt
# Joins corresponding lines from two files side by side.
```

### `cat`

Concatenate and display file contents.

```bash
cat sample1.fq sample2.fq > combined.fq
# Merges two FASTQ files into one.
```

### `sed`

Stream editor for simple substitutions and line operations.

```bash
sed 's/chr/Chr/' genome.txt
# Replaces 'chr' with 'Chr' in each line.
```

### `awk`

Pattern scanning and processing tool. Useful for complex column-based filtering.

```bash
awk '$3 > 100' gene_counts.tsv
# Shows lines where the third column is greater than 100.
```

### `tr`

Translate or delete characters.

```bash
tr 'a-z' 'A-Z' < seq.txt
# Converts lowercase bases to uppercase.
```

---

## BASH scripting

### Variables

Variables store and reuse values like filenames or parameters.

```bash
#!/bin/bash

# Define a variable
sample="sample1"

# Use the variable
echo "The current sample is: $sample"
```

### Loops

Loops are used to repeat tasks over multiple items like files or values.

```bash
#!/bin/bash

# Loop through all FASTQ files
for file in *.fastq; do
  echo "Processing file: $file"
  # Example: run FastQC
  fastqc "$file"
done
```

### If-Else Statements

Conditional logic is helpful to check file presence or handle errors.

```bash
#!/bin/bash

file="genome.fasta"

if [ -f "$file" ]; then
  echo "$file exists. Proceeding with analysis."
else
  echo "$file not found. Exiting."
  exit 1
fi
```

### Scripting

A basic pipeline script to organize tasks.

```bash
#!/bin/bash

indir="raw_data"
outdir="qc_results"

# Create output directory if it doesn't exist
mkdir -p "$outdir"

# Loop through all FASTQ files and run FastQC
for file in "$indir"/*.fastq; do
  if [ -s "$file" ]; then
    echo "Running FastQC on $file"
    fastqc "$file" -o "$outdir"
  else
    echo "Warning: $file is empty or missing. Skipping."
  fi
done

echo "Quality check complete for all files."
```



# Acknowledgement
This tutorial is adapted from *Intro to Unix* from Happy Belly Bioinformatics by Michael D. Lee or known as [AstroBioMike in github](https://astrobiomike.github.io/unix/).

# Citation
[1] Lee, M. (2019). Happy Belly Bioinformatics: an open-source resource dedicated to helping biologists utilize bioinformatics. Journal of Open Source Education, 4(41), 53, https://doi.org/10.21105/jose.00053

