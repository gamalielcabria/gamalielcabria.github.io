---
title: Lesson 2
parent: Intro to Bioinfo
nav_order: 2
---

# Lesson 2: Basic Operations in Terminal and BASH

## Auto-completion

Let us return to our home directory `cd ~`. In this directory, create three folders named `test11`, `test20`, and `test21` using the `mkdir` command. Check your folder using `ls`. 

Afterwards, try typing `head te` and tap the **tab button** once. As you can see, it should auto-complete it to test as it is the next complete `string` without conflict in our folder. Now, that we have `head test` in our line, try tapping the **tab button** twice. It should ring a bell and prompt all possible matches with our initial user input.

>```test11   test20   test21```

<br>

## Wildcards
Sometimes, we need to work on multiple files folders at the same time but they have different names (e.g. the test1, test 20 and test21). The default command-line shell that we are using allows manipulation of the files through the use of special characters called wildcards `*`. 
>***<ins>Try running this command:</ins>***
>
>```ls te*```

The above command results in listing all files in the folder that starts with `te`. This can be used also in a more specific manner. 
>***<ins>Try running this command:</ins>***
>
>```ls test*1```

Using the wildcard within the string matches anyword that starts with `test` and ends with `1`.  It is useful also when runnning commands of files with the same file extension: ```cp *.fasta ./folder/```

{: .note }
> 📝 **Note:** At the command line, the * means any character, any number of times (including 0 times).


Let us try removing all the folder we made earlier that start with `test` simultaneously:
>***<ins>Try running this command:</ins>***
>
>```rm -r test*```

{: .warning }
> ⚠️ Removing files using wildcards should be done carefully as use of wildcards can result in unintended results (e.g. using `rm *` to delete all files within the folder)


---
### **The Question Mark**
Another type of wildcard is the use of `?` mark. Unlike the `*` which can match 1 or more strings e.g. (`test11111` and `test11`), the use of `test*1` will match both files while use of `test?1` will only match `test11`.

>***<ins>Try running this command:</ins>***
>
>```ls test?1```

Which one matches your query?

---
<br>

## Redirectors
The redirection symbols allow the change of destination of outputs (oe even inputs in some instances). Rather than outputs directly showing to your terminal screen, it can be redirected to another command or file. Additionally, redirectors can also be use to push an input to a command.

---
### **The '>' and '<'**
The '>' redirector indicates that the output of any command or process on its left will be transferred to a file indicated on its right. It's most basic structure follows this: ```[command] [any arguments] > [output file]```
>***<ins>Try running this command:</ins>***
>
>```ls -all > list.txt```
>
>then, open `list.txt`

```{warning}
Be warned that using an `>` output redirector with an output file that already exists in the destination will lead to the overwriting of that file. To append an existing file (adding output on the end of the file), please use the append `>>` redirector instead.
```

Meanwhile, the '<' redirector indicates  that the file in the right of the `<` will be used as an input to the command to its left: ```[command][options/arguments] < [input file]```
>***<ins>Example:</ins>***
>
>```mail -s "News Today" gccab@ymail.com < NewsFlash.zip
>

In this example, we can add the attachment `NewsFlash.zip` to the command line `mail` command rather than just sending plain text for email. 

```{note}
The `mail` command is command-line command used to send email. It is useful to incorporate in programs or scripts that need immediate notification to the user if they have errors or the run have finished.
```

---
### **The pipe '|'**
If you want your output to be redirected not into a file but to another process or command, the `|` or pipe redirector is primarily used. It can be used not only once on a line but can be used to chain several commands to gether. A basic structure would look like this: `[command 1] | [command 2] | [command 3] > [output file or STDOUT]`
>***<ins>Try running this command:</ins>***
>
>```ls ./data/all | head -n 20 > list.txt```

---
### **Error redirectors**
Several programs often outputed also the errors in STDOUT or terminal screen. You can separate the errors and redirect it to a new distinct file using `2>` redirection. It works similar as the normal output redirection but the difference is it will only filter 'error' outputs designated by the program you use.

The 'error' redirector `2>` can be used alongside a 'output' redirector but designate it as such `1>`. One example would be like this: ```head nonexistentfile.txt 1> file.out 2> file.err```. 

<br>


# Bioinformatic File types and formats
## Sequence File Formats
Sequencing of DNA and RNA often produce signals of light, chromatogram peaks or electric current as an indication of a nucleotide base. These raw signals are converted into ASCII or computer friendly code using a 'basecaller' or basecalling program. Most of the files that we analysed in bioinformatic analysis are already in this ASCII or alphanumeric format that is readable to both machines and humans.

To learn more about basecaller, please look into in this [nanopore guide](https://nanoporetech.com/platform/technology/basecalling).

## The  FASTQ format
The most common file format after basecalling is the ***fastq*** format or colloquially known as *Quality FASTA* format. The fastq files contained both nucleotide sequence information, represented with characters as AGCTN*, and the quality score of each nucleotide, which are represented by different alphanumeric characters. The quality score is based on **Phred Q Score** system in which quality is computed as probabilty of error *Pe* [2], as computed by this equation: 
>`Qphred=-10 x log10(Pe)`

The fastQ file format is composed of four lines:
1. Line 1 is the sequence identifier and description and commonly known as *header*. It often starts with '@' symbol and followed with sequencing information such as sequencer and flow cell lane used.
2. The second line contains the RAW sequence data and denoted using `AGCT` characters used in FASTA file.
3. Line 3 contains the `+` symbol that separates sequences and quality
4. The fourthe line meanwhiles contains the quality score of the file in Phred Score Format

<div class="image3">
<img src="https://biocorecrg.github.io/RNAseq_course_2019/images/fastq_format.png" alt="Sourced from https://biocorecrg.github.io/RNAseq_course_2019/fastq.html">
</div>

### Phred Score
The quality scores ranges from 0-40 with 40 indicating the highest level of quality. Phred quality score can be interpreted as a factor of accuracy as shown in this table:
<center>Quality Scores and Accuracy</center>

|Phred Score|Probability of incorrect call|Base Call Accuracy|
|---|---|---|
|10|1 in 10|90%|
|20|1 in 100|99%|
|30|1 in 1,000|99.9%|
|40|1 in 10,000|99.99%|

The ASCII representation of this quality score in fastq files can be seen in this image adapted from [NYU](https://learn.gencore.bio.nyu.edu/ngs-file-formats/quality-scores/):
<br>
<div class="image">
<img src="https://learn.gencore.bio.nyu.edu/wp-content/uploads/2018/01/Screen-Shot-2018-01-07-at-1.34.33-PM-768x492.png">
</div>
<br>

```{note}
Phred-64 format is only used by Illumina sequencers while Phred-33 is primarily used by other sequencing file format.
```

## The  FASTA format

FASTA files are the most common file format you will encounter when doing bioinformatic analysis. Unlike FASTQ files with quality score, FASTA files primarily contains only the sequence information using `AGCT` characters for nucleotides. Aside from this, the `N` and `*` are also used as unspecified based and stop character.

<br>
<div class="image3">
<center>
    <img src="https://www.researchgate.net/profile/Jiangning-Song/publication/331702618/figure/fig2/AS:745823247810566@1554829527399/An-example-of-the-FASTA-format-used-in-iLearn.ppm">
</center>
</div>
<center><ins>A nucleotide FASTA File</ins></center>
<br>

The ***FASTA*** file format is composed of two lines per sequence. The first line starts with `>` composes the header line. It often has the sequence name and other properties depending on the program used. The second line is composed of the nucleotide sequence file. This can be on capital or small characters.

When reading FASTA format of protein sequences, we use single amino acid representations.
<div class="image3">
<center>
    <img src="https://www.integratedbreeding.net/courses/genomics-and-comparative-genomics/www.generationcp.org/UserFiles/Image/genomics/amino.gif">
</center>
</div>

Here is a sample of a protein FASTA file:
<br>
<div class="image">
<center>
    <img src="https://training.galaxyproject.org/training-material/topics/proteomics/images/Fasta_sequence.png">
</center>
<center><ins>Protein FASTA File</ins></center>
</div>

```{warning}
The two formats should not be used at the same file as the nucleotide fasta format can be interpreted as a protein fasta file.
```

<br>

## Alignment Format
In many downstream analysis, fasta/fastq files are aligned to create a large genome sequence file. Among the most common alignment format used here are the **SAM** and **BAM** format. 'BAM' is the binary file format of 'SAM' and often used for its smaller file size. 

### The SAM or Sequence Alignment Map format



```python
%%script false --no-raise-error
1:497:R:-272+13M17D24M	113	1	497	37	37M	15	100338662	0	CGGGTCTGACCTGAGGAGAACTGTGCTCCGCCTTCAG	0;==-==9;>>>>>=>>>>>>>>>>>=>>>>>>>>>>	XT:A:U	NM:i:0	SM:i:37	AM:i:0	X0:i:1	X1:i:0	XM:i:0	XO:i:0	XG:i:0	MD:Z:37
19:20389:F:275+18M2D19M	99	1	17644	0	37M	=	17919	314	TATGACTGCTAATAATACCTACACATGTTAGAACCAT	>>>>>>>>>>>>>>>>>>>><<>>><<>>4::>>:<9	RG:Z:UM0098:1	XT:A:R	NM:i:0	SM:i:0	AM:i:0	X0:i:4	X1:i:0	XM:i:0	XO:i:0	XG:i:0	MD:Z:37
19:20389:F:275+18M2D19M	147	1	17919	0	18M2D19M	=	17644	-314	GTAGTACCAACTGTAAGTCCTTATCTTCATACTTTGT	;44999;499<8<8<<<8<<><<<<><7<;<<<>><<	XT:A:R	NM:i:2	SM:i:0	AM:i:0	X0:i:4	X1:i:0	XM:i:0	XO:i:1	XG:i:2	MD:Z:18^CA19
9:21597+10M2I25M:R:-209	83	1	21678	0	8M2I27M	=	21469	-244	CACCACATCACATATACCAAGCCTGGCTGTGTCTTCT	<;9<<5><<<<><<<>><<><>><9>><>>>9>>><>	XT:A:R	NM:i:2	SM:i:0	AM:i:0	X0:i:5	X1:i:0	XM:i:0	XO:i:1	XG:i:2	MD:Z:35

```


As shown above, it is composed of several columns that describes a reads position in the genome. The meaning of each column can be seen here:


<img src="https://bioinformatics.media.uconn.edu/wp-content/uploads/sites/15/2017/01/format2-768x247.png">

We will not discuss this in detail but will tackle in the future. 

<br>

## Other File formats
Multiple other file formats are used in Bioinformatics. We will tackle them in detail when we encounter them in our analysis. Here are some of the file formats that are common in a bioinformatic workflow.
<center><em><b>Bioinformatic files</b></em></center> 
    
|**File Formats**|**Extension**|**Definitions**|
|---|---|---|
|FASTQ|.fastq or .fq|contains sequence information and the quality of the sequences|
|FASTA|.fasta or .fa|basic file containing description and sequence information|
||.fna|an alternative extension used to denote a nucleotide fasta format|
||.faa|an alternative extension used to denote a protein fasta format|
||.fa.gz or .fasta.gz or .fq.gz|gunzipped compressed format of FASTA or FASTQ for smaller file size|
|SAM|.sam|a sequence alignment format that details position of each nucleotide. May include quality score and other options depending on the program used|
|BAM|.bam|a compressed or binary form of SAM to lower file size|
|General Feature Format|.gff or .gff2 or .gff3|is a file format used to describe genes and other general feature of the genome|
|||It is consisting of several columns describing the genes, gene names, position and orientation of the genes|
|Gene Transfer format|.gtf|Similar to GFF files but may containe gene structure data|
|Variant Calling File|.vcf|VCf is the standard format when storing gene variation data such as *indels* and *single nucleotide polymorphisms (SNPs)*|

<br>


# Summary
## Common operations in Terminal
 

|**Terminologies**|**Definitions**|
|---|---|
|`tab`|Auto-completion of files or programs available in the terminal|
|`*`|A catch-all wildcard that matches 0 or more instances|
|`?`|A single character wildcard that matches just 1 character instance|
|`>`|Output redirector that allows both STDOUT and STDERR to be save to a file|
|`<`|Input redirector that allows files to fill in as STDIN to the command or program|
|`>>`|Append redirector add STDOUT to the end of the file rather than replacing it|
|`2>`|error redirection separates STDERR outputs to a file|
|`1>`| STDOUT only redirection to a file|
|`\|`|Pipe redirection allows to chain a STDOUT as STDIN to another program|
|STDIN|Standard input are inputs that are often provided to a program or command via terminal|
|STDOUT|Standard output are output of programs and commands and are often shown into the terminal rather than a file|
|STDERR|Standard errors are error outputs of programs and commands that is also often shown in terminal|


# Acknowledgement
This tutorial is adapted from *Intro to Unix* from Happy Belly Bioinformatics by Michael D. Lee or known as [AstroBioMike in github](https://astrobiomike.github.io/unix/).

# Citation
[1] Lee, M. (2019). Happy Belly Bioinformatics: an open-source resource dedicated to helping biologists utilize bioinformatics. Journal of Open Source Education, 4(41), 53, https://doi.org/10.21105/jose.00053

[2] Cock, P.J.A, C.J. Fields, N. Goto, M.L. Heuer, & P.M. Rice (2010). The Sanger FASTQ file format for sequences with quality scores, and the Solexa/Illumina FASTQ variants. Nucleic Acids Research, 38(6):1767-1771, https://doi.org/10.1093%2Fnar%2Fgkp1137


