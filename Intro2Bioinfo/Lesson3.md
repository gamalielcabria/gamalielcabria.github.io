---
title: Lesson 3
parent: Intro to Bioinfo
nav_order: 2
---

# Lesson 3: The commands to rule them all

## Basic bioinformatics commands: 

There are tons of built-in commands within Linux OSes that are very useful for bioinformatic analysis. In this section, we will examine a few of the most commonly used commands in bioinformatics. We will adapt content from the [Happy Belly Bioinformatics](https://astrobiomike.github.io/unix/six-glorious-commands). 

{: .note }
> The following lesson and activity should be tried using a **linux terminal**. Please use your WSL2 and/or register an account to [Webminal](https://webminal.org/).

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
## GNU Wget `wget <url>`

`wget` is a command-line utility for downloading files from the web. It supports HTTP, HTTPS, and FTP protocols and is useful for retrieving datasets, software packages, or scripts directly into your working directory.

{:.activity}
>**<ins>Try this command:</ins>**
>
>`wget https://github.com/gamalielcabria/gamalielcabria.github.io/blob/main/Intro2Bioinfo/files/gene_counts.tsv`

The previous command will download the `gene_counts.tsv` directly into your current working directory. If you want it to be located in a **different directory**, you can use the command:

`wget <url> -P <destination path>`.

To download a folder with multiple files inside, it would be suggested to zip the files or if not possible do a recursive download:

{:.activity}
>**<ins>Try this command:</ins>**
>
>```
># Create a destination folder
>mkdir -p ./destination
>
>#download recursively to the destination folder
>wget -r -np -nH --cut-dirs=5 -A "*.gtf.gz" ftp://ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/ -P ./destination
>```
>
>{: .info }
>>This command will download all `*gtf.gz` files from ENSEMBL
>>- `-r`: Recursive download  
>>- `-np`: No parent: don't go to parent directories  
>>- `-nH`: No host directory: avoid creating `ftp.ensembl.org/`  
>>- `--cut-dirs=5`: Skip 5 directory levels (so files save cleanly)  
>>- `-A "*.gtf.gz"`: Only download files ending in `.gtf.gz`
>>- `-P`: Destination folder of the file

---
## Gunzip Compression `gzip [-d|-k] <file>`

`gzip` is a widely used command-line tool for compressing text files, such as FASTA, FASTQ, GTF, or VCF files, into `.gz` format. This is especially useful in bioinformatics, where raw data files can be very large.

This command compresses data.txt into data.txt.gz and removes the original file by default.

{:.activity}
>``` gzip data.txt ```

The plaing `gzip` command will remove the original file and be replaced with `data.txt.gz`. Use `-k` to keep the original file: 

{:.activity}
>`gzip -k data.txt`

Meanwhile, decompressing a file uses `-d` option or `gunzip` command.

{:.activity}
>```gzip -d data.txt.gz```

To retain the original `gz` file:

{:.activity}
>```gunzip -c data.txt.gz > data.txt```

Compare the sizes of the files between the compressed and uncompressed files. Did you notice any difference?

| File Type | Compression Ratio | Notes                                                      |
| --------- | ----------------- | ---------------------------------------------------------- |
| FASTA     | 2–4× smaller      | Compresses well due to repetitive sequences                |
| FASTQ     | 3–6× smaller      | Especially efficient for raw reads                         |
| GTF/GFF   | 3–5× smaller      | Mostly text-based, highly compressible                     |
| VCF       | 4–8× smaller      | Works well but block compression (`bgzip`) often preferred |


{:.notice}
>Gunzip compressed files cannot be read by normal text editor or text file view commands such as `more`, `cat`, and `nano`. They will appear gibberish because they are binary. However, `less` command are able to interpret them.

{: .note }
>**zcat** `zcat <gzipped file>`
>
>Given that concatenate `cat` command does not work with gzipped files. The `zcat` command replaces it and allows viewing and concatenation of `gz` files.


---
## Wordcount `wc [-c|-m|-w|-l]`
The wordcount commands `wc` print out the number of bytes `-c`, characters `-m`, word `-w`, and lines `-l` within a text file. It is often useful in counting the number of items in your file or a list. 

One examples is counting the number of genes being analyse in gene count table:

{:.activity}
>**<ins>Try this command:</ins>**
>
>```
># Download Test Data
>wget -P ./destination https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/gene_counts.tsv
>
># count the number of genes
>wc -l gene_counts.tsv
>```

Is it the same when you open the file using `less|more` and counted the genes?

{:.notice}
Files often have a header that you need to account for. It will be counted by `wc`

---
### `grep`

Search for patterns in a file. Very useful for filtering sequences or logs.

```bash
grep "^>" sequences.fasta
# Shows all FASTA headers.
```




### `cut`

Extract specific columns from tab-delimited files.

```bash
cut -f1,3 data.tsv
# Extracts columns 1 and 3 from a tab-separated file.
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

