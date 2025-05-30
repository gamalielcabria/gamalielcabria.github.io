---
title: Lesson 3 - The commands to rule them all 
parent: Intro to Bioinfo
nav_order: 3
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

<br>

---
## Concatenate `cat`

The `cat` (short for *concatenate*) command is used to display the contents of a file or combine multiple files into one. It's especially useful for quickly checking small files or merging sequencing data.

{:.activity}
```
cat file1 file2 > combined_file
# Merges two or more files into one combined_file.
```

{:.note}
Without the redirector `>` symbol, concatenate `cat` will display the concatenated file to `STDOUT` only. 

{:.activity}
>**<ins>Try this command:</ins>**
>
>```
># Download files to be concatenated
>wget -P ./destination https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/data.tsv
>wget -P ./destination https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/genes.tsv
>
># Run cat to visually concatenate:
>cat data.tsv genes.tsv
>
># Run it again but different order
>cat genes.tsv data.tsv
>```
> Have you notice any difference?



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

<br>

---
## Wordcount `wc [-c|-m|-w|-l]`
The wordcount commands `wc` print out the number of bytes `-c`, characters `-m`, word `-w`, and lines `-l` within a text file. It is often useful in counting the number of items in your file or a list. 

One examples is counting the number of genes being analyse in gene count table:

{:.activity}
>**<ins>Try this command:</ins>**
>
>```bash
># Download Test Data
>wget -P ./destination https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/gene_counts.tsv
>
># count the number of genes
>wc -l gene_counts.tsv
>```

Is it the same when you open the file using `less|more` and counted the genes?

{:.notice}
Files often have a header that you need to account for. It will be counted by `wc`

<br>

---
## Column Extraction Command: `cut`
The `cut` command is used to extract columns (fields) from tabular files, like `.tsv` or `.csv`, which is common in bioinformatics data such as gene tables or expression matrices.

{:.activity}
>**<ins>Try this command:</ins>**
>
>```bash
>more ./destination/data.tsv
>cut -f 1 ./destination/data.tsv
>cut -f 1,3 ./destination/data.tsv
>```

`cut` command cuts the table based on delimiters. The default delimiter is the **tab character** (`\t`). To change delimiter, just use the option `-d`:

{:.activity}
>**<ins>Try this command:</ins>**
>
>```bash
>cut -d'e' -f 3 ./destination/data.tsv
>```

To permanently combine a cut file, you need to redirect it to an output file.

{:.highlight}
>**<ins>!!DO THIS COMMAND!!</ins>**
>
>Save cut files to different text files
>``` bash
>cut -f 1,3 ./destination/data.tsv > score.txt
>cut -f 1,2 ./destination/data.tsv > value.txt
>```

<br>

---
## Line-by-line paste command `paste`

The `paste` command merges lines of multiple files horizontally, inserting a delimiter (default: tab). It's useful for joining columns from separate files into one table.

{:.activity}
>**<ins>Try this command:</ins>**
>
>```
># Joins corresponding lines from two files side by side.
>`paste score.txt value.txt`
>
># Compare it to the opposite order
>`paste value.txt score.txt`
>```

Now compare it to a `cat` command. What did you observe

<br>

---
## Regular expression search command `grep`

`grep` is a powerful command-line tool used to search text using **regular expressions (regex)** — patterns that describe sets of strings. It's widely used in bioinformatics to extract specific sequence IDs, gene names, or annotations from large text-based files.

It's basic command is as such:

{:.activity}
>```bash
>grep "<pattern>" <input file>
>```

<br>
What is regular expression?

{: .highlight }
>### 🧩 Regular Expressions (Regex)
>
>Regular expressions are powerful patterns used to match strings of text. They are essential for searching, filtering, and extracting data in large bioinformatics files like FASTA, GTF, or VCF.
>
>For example:
>- `^gene` — matches lines that **start(^)** with "gene"
>- `\.gz$` — matches filenames that **end($)** with `.gz`.
> >- The backward slash `\` here forces the program to treat `.` as a **dot** character
> >- Otherwise, `.` in regex can signal any character or whitespace
>- `[ATCG]{10,}` — matches sequences with **10 or more** A/T/C/G characters
>
>Regex is used with tools like `grep`, `sed`, `awk`, and even within programming languages like Python or R.
>
>{: .note}
>> Learn more about how regular expressions work using the following [cheatsheet](https://media.datacamp.com/legacy/image/upload/v1665049611/Marketing/Blog/Regular_Expressions_Cheat_Sheet.pdf).
>>
>> If you want to check out and practice how it works, visit the website [regex101.com](https://regex101.com/).
>>
>> For now let us stick to the basics.

<br>
<br>
**GREP** most known function in bioinformatics is the counting of reads in a fasta file. If you recall, fasta file consists of a header starting with `>` followed by some text and a sequence file. To know the number of fasta sequences within a fasta file, simply use the following:

{: .activity }
>**<ins>Try this command:</ins>**
>
>```bash
>#Download a fasta file
>wget -P ./destination https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/random.fasta
>
>#Count the number of headers using `-c` option
>grep -c "^>" ./destination/random.fasta
>```

The `-c` is used to count the number of reoccurrence of the pattern within `"<pattern>"`. Again, `^` signifies start of a line. Thus, `"^>"` counts the number of `>` in the file that is at the start of the line (i.e. headers).

Can you compare it without the `-c` option?

{: .activity }
>**<ins>Try this command:</ins>**
>
>```bash
>grep "^>" ./destination/random.fasta
>```

It should display the lines that match and color the pattern that matches.
<br>
<br>
<br>
**GREP** can be used only on text files. To read compressed or binary files such as `*.gz`. However, you do not to decompress to process them but you can use pipe to chain the commands. An example for counting all non-comment files in `gtf` file:

{: .activity }
>**<ins>Try this command:</ins>**
>
>```bash
>zcat ./destination/Homo_sapiens.GRCh38.110.gtf.gz | grep -c -v "^#"
>```

The `gtf` file often has commented text in top of the file such as this:
```
#!genome-build GRCh38.p14
#!genome-version GRCh38
#!genome-date 2013-12
#!genome-build-accession GCA_000001405.29
#!genebuild-last-updated 2023-03
1       havana  gene    182696  184174  .       +       .       gene_id "ENSG00000279928"; gene_version "2"; gene_name "DDX11L17"; gene_source "havana"; gene_biotype "unprocessed_pseudogene";
1       havana  transcript  182696      184174  .       +       .       gene_id "ENSG00000279928"; gene_version "2"; transcript_id "ENST00000624431"; transcript_version "2"; gene_name "DDX11L17"; gene_source "havana"; gene_biotype "unprocessed_pseudogene"; transcript_name "DDX11L17-201"; transcript_source "havana"; transcript_biotype "unprocessed_pseudogene"; tag "basic"; tag "Ensembl_canonical"; transcript_support_level "NA";
1       havana  exon    182696  182746  .       +       .       gene_id "ENSG00000279928"; gene_version "2"; transcript_id "ENST00000624431"; transcript_version "2"; exon_number "1"; gene_name "DDX11L17"; gene_source "havana"; gene_biotype "unprocessed_pseudogene"; transcript_name "DDX11L17-201"; transcript_source "havana"; transcript_biotype "unprocessed_pseudogene"; exon_id "ENSE00003759020"; exon_version "2"; tag "basic"; tag "Ensembl_canonical"; transcript_support_level "NA";
```
The `-v` option in the `grep` command skip all files that matches the pattern: lines that starts with `#`.

We can also chain `grep` commands to search more thoroughly within the file. For example, if we want to find a line that is a **rRNA gene** and its **gene** description in the `gtf` file, we can run this:

{:.activity}
```bash
zcat ./destination/Homo_sapiens.GRCh38.110.gtf.gz | grep -P '\tgene\t' file.gtf | grep 'gene_biotype "rRNA"'
```

Now, can you count the number of **tRNA exons** in these gtf file?

---
## The Stream Editor Command `sed`

The `sed` command is a powerful tool for editing text in files or streams. It's often used for find-and-replace operations, especially when working with large datasets or automated scripts.

{:.activity}
>`sed [options: -i|-E] 's/<old pattern or text>/<new replacement>/g' <file>`

Several options can be used when running `sed`, check `--help` for more info. Without any options declared, the `sed` output will just be displayed in `STDOUT`. The command `-i`, means in-line replacement, can be use to edit the input file without displaying.

{:.info}
`sed` command utilizes *regular expression* for matching text. The `sed` has so many options than what I can easily discuss in this beginner guide. Please look up this **[SED cheatsheet](https://quickref.me/sed.html)** for more details.

One example of `sed` usage in bioinformatics is quick renameing of headers of fasta file.

{: .activity }
>**<ins>Try this command:</ins>**
>
>```bash
># Visualize the content of fasta file
>head ./destination/random.fasta
>
># Let us replace the header name `seq` by including the species they are from
>sed 's/^>seq/>Bacillus subtillis \| gene /g' ./destination/random.fasta
>```

Did it change the contents of the file? What do you need to do to change the content of the file **permanently**?

<br>
`sed` is also useful when removing or replacing unwanted targets. For example, I want to remove sequences that has adenosine homopolymer count of **4 or more** and replace them with **N's**:

{: .activity }
>**<ins>Try this command:</ins>**
>
>```bash
># See how many matches using `grep`
>grep -E "A{4,}" ./destination/rando.fasta
># run replacement and visualize it using
>sed -E 's/A{4,}/NNNNNNNN/g' ./destination/random.fasta | grep -E "N{8}" -B1 
>```
>
>{:.notice}
>>Remember this does not invoke `-i` which means the sed replacement is not save in the file.

Lastly, one other use of `sed` is changing file delimtiers. Converting a `tsv` file to `csv` in which the `\t` is replaced by `,`:

{:.highlight}
>**<ins>!!DO THIS COMMAND!!</ins>**
>
>```bash
>sed 's/\t/,/g' data.tsv > data.csv
>```

<br>

---
## Pattern scanning and text processing language `awk`

`awk` is a powerful command-line tool for pattern scanning, text processing, and column-wise operations in structured files like TSV or CSV.

It reads input line by line, splits lines into fields, and lets you perform calculations, filtering, or formatting.

{:.activity}
>`awk '$3 > 150' gene_counts.tsv`
>
>> - This prints lines from gene_counts.tsv where the third column is greater than 100.

It can also perform more complicated task such as filtering based on values for multiple columns:

{:.activity}
>```bash
awk '
BEGIN {OFS = "\t"}
$2 > 180 && $7 < 300 { print }
' < ./destination/gene_counts.tsv
```

<br>
`awk` is indispensable in bioinformatics pipelines for filtering large tabular files like GTFs, count matrices, and sequence stats.

### Other common uses:
```
awk '{print $1, $3}' data.tsv         # Print columns 1 and 3
awk -F',' '{print $2}' data.csv       # Use comma as delimiter
awk 'NR > 1' file.tsv                 # Skip header (print after 1st row)
```
Remember earlier that we count the rows of the table using `wc` command? Now, we can also combine it with awk to count the number of columns of `data.csv`

{:.activity}
>**<ins>Try this command:</ins>**
>
>```
wc -l < gene_counts.tsv
head -1 gene_counts.tsv | awk -F'\t' '{print NF}'
```
>- `wc -l`: counts the number of lines (i.e., rows)
>- `head -1`: grabs the header row
>- `awk -F'\t' '{print NF}'`: prints the number of fields/**NF** (columns), assuming tab-delimited

<br>

---
## Translate `tr`

The `tr` (translate) command is used to replace, squeeze, or delete characters from input. It works only on character-by-character transformations and reads from standard input.

An example, let us change the **[AGCT]** nucleotides in this fasta to lowercase. We can use:

{:.activity}
>```bash
tr 'A-Z' 'a-z' < random.fasta
```

We can use `tr` also to remove all digits in the file

{:.activity}
>```bash
tr -d '0-9' < random.fasta
```

<br>

---
## Display text or variable command `echo`

The `echo` command prints text or variables to the terminal. It’s often used in scripts to show messages, output variable values, or create files on the fly.

- **Prints a simple message**:

{:.activity}
>```bash
>echo "Hello, bioinformaticians!"
>```

- **Show the value of a variable**:

{:.activity}
>```bash
>sample="sample1"
>echo "Currently processing: $sample"
>```
Values to the **variables** in bash is assigned using the `=` symbol. The **variable** name to the left of it and the values from the right. 

{:.note}
There should be no space between the **variable**, `=`, and the assigned **value** to the left.

We can use it also to write FASTA or any text to a file!

- **Write FASTA content to a file**:

{:.activity}
>```bash
>echo -e ">geneX\nATGCGTACGTA" > geneX.fasta
>```

- **Add content to a file**:

{:.activity}
>```bash
>echo -e ">geneX\nATGCGTACGTA" > geneX.fasta
>```

<br>
<br>

# Summary

| Command  | Description | Example | Use Case |
|----------|-------------|---------|----------|
| `history` | Shows recently used commands | `history 20` | Recall past terminal commands |
| `wget` | Downloads files from the web | `wget <url>` | Retrieve datasets/scripts |
| `cat` | Displays or combines files | `cat file1 file2 > merged.txt` | Merge sequencing files |
| `gzip` / `gunzip` | Compress/decompress files | `gzip file.txt` / `gunzip file.gz` | Save storage on large files |
| `wc` | Counts lines, words, etc. | `wc -l gene_counts.tsv` | Count rows in tables |
| `cut` | Extracts columns | `cut -f1,3 data.tsv` | Subset tabular data |
| `paste` | Merges files line-by-line | `paste file1 file2` | Combine columns from files |
| `grep` | Searches using regex | `grep "^>" fasta.fna` | Count sequences or search patterns |
| `sed` | Stream editor for text | `sed 's/old/new/g' file.txt` | Replace or clean text |
| `awk` | Processes text by column | `awk '$2 > 100' file.tsv` | Filter tabular data |
| `tr` | Translates/deletes characters | `tr 'A-Z' 'a-z' < file` | Change case or strip characters |
| `echo` | Prints text/variables | `echo "Hello!"` | Display info or write files |



# Acknowledgement
This tutorial is adapted from *Intro to Unix* from Happy Belly Bioinformatics by Michael D. Lee or known as [AstroBioMike in github](https://astrobiomike.github.io/unix/).

# Citation
[1] Lee, M. (2019). Happy Belly Bioinformatics: an open-source resource dedicated to helping biologists utilize bioinformatics. Journal of Open Source Education, 4(41), 53, https://doi.org/10.21105/jose.00053

