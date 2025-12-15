---
title: Lesson 5A - Metagenomic Data Analysis
parent: Lesson 5 - GLGY699 Project
nav_order: 1
---

# Exercise 4A - Annotate a metagenome sequence
Let us apply all the experiences we built over the course of the semester to analyze an actual metagenomic sample.

This part of the exercise will teach you how to search, access, and download metagenome data that has been submitted to databases such as the European Nucleotide Archive (ENA) or the US' National Center for Biotechnology Infromation (NCBI).

<br>

## Goals
In this section, we have several goals:
1. Search the [NCBI Database](www.ncbi.nlm.nih.gov) for data
2. Download metagenome data from database 
3. Cleaning and Processing raw shotgun metagenome data
4. Identify reads or genes belonging to your functional protein

This section requires several programs:
1. [SRAToolkit](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit)
2. CutAdapt, Trimmomatic, and BBDuk
3. FastQC
4. \[Optional\] SPAdes, Prodigal, DIAMOND BLAST
5. HMMer
6. MMSeqs
7. SeqTK

{: .info }
> During installation, check if the abovementioned programs can be installed using `conda`. It makes life easier. I also suggest to follow the version code displayed above as some older versions can still exists and might have some differences in runnning the abovementioned softwares.
>
> Always verify if they have been properly installed! For SRA-Toolkit, check it using `vdb-config --version` and/or `fasterq-dump --version`

<br>

## **Step 1**. Downloading Metagenome Data

1. Search the [www.ncbi.nlm.nih.gov](www.ncbi.nlm.nih.gov) a dataset you choose 
- Select the **BioProject** category and search for specific dataset (i.e. `hot springs`, `volcano`, `alkaline springs`)
- Check the `Metagenome` under **Data Types**
- Choose **Three** **Bioproject** of your choosing

>{: .info }
>>Here is usual heirarchy of NCBI accession numbers:
>>
>>| Type                | Prefix         | Example        | Description                          |
>>| ------------------- | -------------- | -------------- | ------------------------------------ |
>>| **Study / Project** | PRJNAxxxx      | PRJNA384123    | Overall project submission           |
>>| **Experiment**      | SRXxxxxxxx     | SRX2403769     | Experimental setup (library, method) |
>>| **Sample**          | SRSxxxxxxx     | SRS2137452     | Biological sample metadata           |
>>| **Sequence Read Archive (SRA) / Run** | **SRRxxxxxxx** | **SRR6260347** | Specific sequencing run (FASTQ data) |


2. Download the SRA Accession Numbers for each Bioproject you chose
- Click each **Bioproject** you choose
- Copy the **SRA** accession numbers present
- Create a text file and paste all the SRA in that file, let's say `accessions.txt`:
    ```
    SRR6260347
    SRR6260348
    SRR6260349
    ```

3. Use the `prefetch` command from SRAToolkit to download the list of accessions
- Run `prefetch` using the option `--option-file` with the list of accession as its parameter. 
    - Additionally, you can specify where it can be save using `--output-directory` option

>{: .note }
>> - Prefetch saves the `*.sra` archive locally for later conversion
>> - You can resume even after an interrupted download by running the same file and same output directory
>> - You can limit space using `--max-size 100G` if files are too large

4. Convert the downloaded `*.sra` files to fastq
- Run `fasterq-dump` to convert them

>{: .note }
>>- I suggest using options `--split-files` so if there are multiple entry in a `*.sra` they will be save in separate `fastq` file
>>- Other options to look out are `--threads` for number of cores to use and `-O` which is the output directory to save the fastq
>>- Remember the main **argument** for `fasterq-dump` is the sra file, so to run multiple ones automatedly, I suggest create a **BASH** `for-loop`
>>    - If you forgot what an **argument** is, check [Intro to Bionfo](../Intro2Bioinfo/Lesson1.md) and the program's `help` file

5. Check your output if they have the correct sizes and matches the data from the database

## **Step 2**. Clean the Sequencing Data

1. Download and install cleaning program of your choice.
    - I suggest between `Cutadapt`, `FastP`, `Trimmomatic`, and `BBDuk`

2. Check the quality of your reads using `FastQC`
    - Run the program on both your before and after cleaning reads
    - Make note of the number of Reads before and After cleaning

{: .note }
> It is always a good habit to change the name of your process reads per step of cleaning. I personally use extensions to change their names.
>
> For example, if a raw read is `SRA0000_R1.fastq.gz`, I name files after trimming, `SRA0000_R1.trim.fastq.gz`, after error corrected as `SRA0000_R2.errcorr.fastq.gz`, or after quality filtering as `SRA0000_R1.errcorr.clean.fastq.gz`. You can name it in anyway as long as you can track it.

<br>

## **Step 3**. Find Reads that belong to your protein of choice
There are several ways to do this. It can be **(A) assembly-based** or **(B) read-based analysis** or a **(C) hybrid mix** of both.

### **Step 3A**. Assembly-based Analysis
In here, we will `assemble your reads` > `predict Open Reading Frames (ORFs)` > `classify ORFs matching to your HMMs`

1. Assemble your read using your assembler of choice. I suggest `SPAdes`
    - You can run spades like this: `spades.py -1 left.fastq.gz -2 right.fastq.gz --meta -o output_folder`

2. Predict your open reading frames using `Prodigal`
    - `Prodigal` can predict orf and output both nucleotide fasta `*fna` and predicted protein fasta `*.faa` files.
    - An example: `prodigal -i my.metagenome.fna -o my.genes -a my.proteins.faa -p meta`

3. We can now identify ORFs belonging to your functional protein using HMMer
    - You can run a `hmmsearch` using your protein `hmm` to your predicted protein `faa` file.
    - Be sure to prove that the selected proteins really belong to your desired group!
        -Match the ORFS with different `hmm` profile you made

<br>

### **Step 3B**. Read-base Analysis: Diamond BLAST
Here, we will use the pfam proteins you download as a database to match the reads using DIAMOND BLAST. Tutorial for DIAMOND BLAST can be seen [here](https://github.com/bbuchfink/diamond/wiki/1.-Tutorial).

Briefly, we will `BLASTx reads that matches NarrowProtDB` > `Aligned Reads is run again (BLASTx) against WideProtDB` > 

1. Create a Database targeting all your proteins, we will call this **WideProtDB**
    - Briefly, to make a database we will run: `diamond makedb --in proteinsequnece.faa -d WideProtDB`
    - It should generate a `WideProtDB.dmnd` file

2. Using the proteins only from your desired clade, we will create a smaller database called **NarrowProtDB**
    - To select the fasta sequences that match to your clade, find the header of the clade and use `seqtk` to subset if from the larger fasta file.
    - See an example [here](https://github.com/lh3/seqtk?tab=readme-ov-file#seqtk-examples)
    - Create a database similar to **Step 3B #1**

3. Run `diamond blastx` to determine reads closely aligned to *NarrowProtDB*
    - This will filter the reads that belongs only to your **target clade**
    - Use `--outfmt 6` to show matches in tabular format
    - Use the `--al` and `--alfmt` option so DIAMOND can segregate aligned queries to a separate file
        - The `--alfmt` be either `fasta` or `fastq` format
    - I suggest using `--ultra-sensitive` and set `--max-target-seqs` to `1`
        - This sets highest matches of protein sequences per reads to be the one only shown
    - An example:
        ```
        diamond blastx --db NarrowProt.dmnd --query SRR0000_1.clean.fastq.gz \
        --alfmt fastq --al NarrowProtDBaligned_SRR0000_1.clean.fastq \
        --max-target-seqs 1 --threads 30 --ultra-sensitive \
        --outfmt 6 --out WideProtDBaligned_SRR0000_1.out
        ```

4. The output of above's `WideProtDBaligned_SRR0000_1.clean.fastq` will be used as input for another BLASTx but with the **WideProtDB**.
    - This will filter the reads that are mistakenly aligned to your target clade but are more closely associated to other clades.
    - Similar above, we will run `diamond blastx` with similar options and parameters except `--db` set to `WideProtDB`.

5. Check the tabular formatted output. Number of reads matches to your **target clade** is the **read abundance** to that sequence.
    - You can use that input to plot in your tree.

<br>

### **Step 3C**. Hybrid Analysis using MMSeqs2

Identify abundance of your predicted proteins **\[Extra\]** using `mmseqs`. Follow this [MMSeqs 2 Tutorial](https://github.com/soedinglab/MMseqs2/wiki/Tutorials#abundance-analysis) for more details.

1. Create a database for your **clean reads** `cleanreadsdDB` and another for your **predicted ORF from STEP 3A #3** `PredictedProtDB`
    - An example: `mmseqs createdb SRA0000_concatenated.clean.fastq cleanreadsDB`

2. Extract ORFs and translate nucleotideORFs from `cleanreadsDB`
    - Use `mmseqs extractorfs` and `mmseqs translatenucs` to do this

3. Prefilte the reads by running `mmseqs prefilter -s 2 translatedreadsDB PredictedProtDB prefilteredreadsDB`
    - This removes redundancy in the inputs

4. Rescore the prefilter using the `mmseqs rescorediagonal` to have significant hits that fully covered the protein sequence
    - Check the help file on how to do this!!!
    - This uses `translatedreadsDB`, `PredictedProtDB`, and `prefilteredreadsDB`
    - Use the options `-c 1 –cov-mode 2 –min-seq-id 0.95 –rescore-mode 2 -e 0.000001 –sort-results 1`

5. Keep the best mapping target for each read to the protein sequence database using `mmseqs filterdb`
    - An example: `mmseqs filterdb rescoredreadsDB filteredreadsDB --extract-lines 1`

6. We will invert the database so we can count the reads per predicted protein
    - Use `mmseqs swapresults translatedreadsDB PredictedProtDB rescoredreadsDB`

7. We convert the DB to readable table:
    - Use `mmseqs convertalis <i:queryDb> <i:targetDb> <i:alignmentDB> <o:alignmentFile> --format-mode 2`

8. The table can be open and read using `R` and `tidyverse` pacakge
    -We can run `summarise` to find the number of reads per Predicted Protein

<br>

## **Step 4**. Find abundance of a housekeeping gene (i.e. rpoB)
You can do this through two ways: Repeating the above process (Step 3) but focusing on RpoB sequences only.
1. For a housekeeping gene, you can just create a single database using all reviewed rpoB from pFAM database. RpoB is highly conserved and thus should
2. I would suggest using DIAMOND BLAST as it can be more straightforward.

<br>

## Step 5. Plug the Abundance as annotation to your phylogenetic tree
You can annotate your tree using both `R GGTree` or `TVBOT`

{: .funfact }
> I believe you can do this! Look up old class material or documentation of those programs to do this.
>
> At this specific point, I will not help you. :P


# Tips and Tricks
1. **Always Check the Help File**. Try `<program> --help` or `<program> -h`
2. **Read the DOCS**. Look up the documentation for each program you use
3. **Name your file and folders by order**. For better organization, it is ideal to name your `slurm`, `folder` in a sequential manner so you will not get confused.
    - An example:
    ```
    /root/home/
    |
    |_10-trimming
    |    |_01-trimming.slurm
    |    |_02-fastqc.slurm
    |
    |_20-assembly
    |    |_01-spades-error-correction.slurm
    |    |_02-spades-assembly.slurm
    |
    |_30-abundance-analyis
        |_01-read-base
        |    |_01-step1.slurm
        |    |_02-step2.slurm
        |
        |_02-hybrid
        |    |_01-hybstep1.slurm
        |
        |_03-assembly
            |_01-assembly-step1.slurm
    ```



