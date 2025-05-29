---
title: Lesson 3
parent: Intro to Bioinfo
nav_order: 2
---

# Lesson 3: The commands to rule them all

## Basic bioinformatics commands: 

There are tons of built-in commands within Linux OSes that are very useful for bioinformatic analysis. In this section, we will examine a few of the most commonly used commands in bioinformatics. We will adapt content from the [Happy Belly Bioinformatics](https://astrobiomike.github.io/unix/six-glorious-commands). 

---
## History: `history <n>`

Look into the recent commands run in the terminal for the past `n` lines. Useful for backtracking the commands you have previously run. 

{:.activity}
>**<ins>Try this command:</ins>**
>
>```history 20```

This should display the last 20 files you have entered in the command-line. If you are searching a specific command, you can also combine `history` with `grep`(see below) to search a specific command you've previously used.

{: .activity}
>**<ins>Try this command:</ins>**
>
> ``` history | grep "ls"```

It should be noted that you can recall also previous commands using your up ⬆️ and down ⬇️ arrow key.

---
## Wordcount `wc [-c|-m|-w|-l]`
The wordcount commands `wc` print out the number of bytes `-c`, characters `-m`, word `-w`, and lines `-l` within a text file. It is often useful in counting the number of items in your file or a list. 

One examples is counting the number of genes being analyse in gene count table:




{:.activity}
>**<ins>Try this command:</ins>**
>
>


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




# Acknowledgement
This tutorial is adapted from *Intro to Unix* from Happy Belly Bioinformatics by Michael D. Lee or known as [AstroBioMike in github](https://astrobiomike.github.io/unix/).

# Citation
[1] Lee, M. (2019). Happy Belly Bioinformatics: an open-source resource dedicated to helping biologists utilize bioinformatics. Journal of Open Source Education, 4(41), 53, https://doi.org/10.21105/jose.00053

