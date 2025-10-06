---
title: Lesson 2B - Clustering Proteins
parent: Lesson 2 - Tree Building
nav_order: 2
---

# Protein Clustering
Here, we will use `mmseqs2` workflow for clsutering proteins.

## Installing `mmseqs2`
`mmseqs2` can be installed from [source](https://github.com/soedinglab/mmseqs2/wiki#installation) or from [conda](https://anaconda.org/bioconda/mmseqs2). Here, let us installed it from conda:

```
conda create --name mmseqs2       # Wait for it to create an environment
conda activate mmseqs2            # We will install it within this environment

conda install -c bioconda mmseqs2   # Main installation line
```

Full installation of mmseqs2 require the installation of databases to help in identifying its homology from them. For our purposes, our clustering do not need to use such databases. For now, we can skip installing pre-compiled/formatted databases. But if you want to install databases for your own purpose or for the future, you can follow this [guide](https://github.com/soedinglab/mmseqs2/wiki#downloading-databases) or this:

An example if you want to download and formatted `UniProtKB` database:

```
mmseqs databases UniProtKB/Swiss-Prot /home/username/full/path/to/a/folder/named/swissprot tmp
```

## Protein Clustering
The `mmseqs` has two workflows for clustering: `mmseqs cluster` or `mmseqs linclust`. 

The difference between `mmseqs cluster` and `mmseqs linclust` is that the latter operates in linear time, hence much [faster but at the cost of sensitivity](https://github.com/soedinglab/mmseqs2/wiki#clustering-databases-using-mmseqs-cluster-or-mmseqs-linclust). The method `mmseqs cluster` combines the prefiltering, alignment and clustering modules into either a **single-step clustering** or a **cascading clustering**. Cascade cluserting perform grouping [incrementally in three steps](https://github.com/soedinglab/mmseqs2/wiki#clustering-databases-using-mmseqs-cluster-or-mmseqs-linclust). First step is through `linclust` which cluter the sequences into 50% sequence identity in very short time. As the cascading steps increase, representative sequences from previous steps are clustered with higher sensitivity. 

{: .info }
> For more detail on `mmseqs linclust` linear time clustering and k-mer usage, please read their [documentation](https://github.com/soedinglab/mmseqs2/wiki#clustering-databases-using-mmseqs-cluster-or-mmseqs-linclust).

<br>
The `mmseqs cluster` can be run using multiple subcommands:

### Step 1: Making Database 
To run both methods, you need to create first a database of your fasta sequences (i.e. GamaProteins --> `Gama_origDB`). This create an index (i.e. `Gama_origDB.index`) and database file (`GamaDB_clu`) which is used for clustering. 

```
mmseqs createdb /home/examples/GamaProteins.fasta Gam_origDB

# Outputs in the folder:
# Gama_origDB
# Gama_origDB.index
```

### Step 2: Clustering
Second step is clustering itself!

```
mmseqs cluster Gama_origDB Gama_clusteredDB tmp
```

  Here, the `mmseqs cluster` has three inputs:
  1. `Gama_origDB` - The Generated DB filte from `mmseqs createdb`
  2. `Gama_clusteredDB` - Output Clustered Sequence Database
  3. `tmp` - a temporary folder you will name for the temp files to be located. Can be deleted afterwards

There are other `options` you can add to adjust the running parameters of `mmseqs cluster`. To see most of them run `mmseqs cluster -h`. Some `options` that might interest you:

| Options | Description |
| -- | -- |
| `-c FLOAT` | List the fraction of aligned/covered residues with FLOAT ranging from **\[0-1\]** and with default: **\[0.800\]** |
| `-e DOUBLE` | The e-value score of the matches with default **\[1.00E-03\]**, the lower the value the better is the match |
| `--min-seq-id FLOAT` | Sequences with **min-seq-id > FLOAT** are matched. FLOAT ranges **\[0-1.00\]** |
| `--threads INT` | Number of cores to run `mmseqs2 cluster` |


### Step 3: Generating Outpus
The output is in `mmseqs2` format and not easily readable. To output it to readable formats:


#### Generating TSV formatted output file
We want to see which sequence cluster with which. So we will create a table-delimited file (TSV) that shows that:

```
mmseqs createtsv Gama_origDB Gama_origDB Gama_clusteredDB Gama_clustered.tsv
```

  Here, the `mmseqs createtsv` has four inputs:
  1. `Gama_origDB` - The first one is the **query DB** from `mmseqs createdb`
  2. `Gama_origDB` - Since we are matching it to t
  2. `Gama_clusteredDB` - Output Clustered Sequence Database
  3. `Gama_clustered.tsv` - a temporary folder you will name for the temp files to be located. Can be deleted afterwards

An example can be seen [here](./sequences/hypx_clustered.tsv).

#### Generating Representative Sequences from `mmseqs`
The representative sequence is based on the limits of clustering you have inputted in `mmseqs cluster`. The options `--min-seq-id` and `-c` allows for the user to adjust the sequence identity threshold. The `-c` or coverage depends on the [coverage mode use](https://github.com/soedinglab/mmseqs2/wiki#how-to-set-the-right-alignment-coverage-to-cluster). For our purposes, assuming all proteins in the database are full sequence, we will use `--cov-mode 0` and used the default clustering `-c 0.8`. However, you can play with the sequence identity `--min-seq-id` as you like. For more info on sequence identity, read this [section they've provided](https://github.com/soedinglab/mmseqs2/wiki#how-does-mmseqs2-compute-the-sequence-identity).

```
mmseqs createsubdb  Gama_clusteredDB Gama_origDB Gama_repDB
mmseqs convert2fasta Gama_repDB Gama_rep_seqs.fasta
```

  Here, the `mmseqs createsubdb` has **three** inputs:
  1. `Gama_clusteredDB` - The first one is the **output DB** from `mmseqs cluster`
  2. `Gama_origDB` - The second one is the **created DB** from input fasta using `mmseqs createDB`
  2. `Gama_repDB` - Output of `mmseqs createsubdb`listing the representative of each cluster

  In the `mmseqs convert2fasta`, we transform the reps from mmseqs DB format to a readable fasta.

{: .info }
> The output of representative sequences (i.e. `*_reps_seqs.fasta`) can be now used to build your phylogenetic tree!
>
> Make sure **they have enough sequences** but not too many still. Sequence of >500 but <10,000 would be ideal.
>
> Lastly, make sure in your **TREE-BUILDING** the sequence of your annotated protein is included.

## EASY WORKFLOWS
So, you might be wondering why I made you do all the above mentioned steps. It is for you to know the step-by-step of `mmseqs cluster`. However, by the benevolence of the developers of `mmseqs2`, they created workflow to do the abovementioned steps in one step:

```
mmseqs easy-cluster GamaProteins.fasta Gama_clustered tmp [options]
```

  Here, the has **three** arguments:
  1. `GamaProteins.fasta` - The unaligned protein sequneces as input for clustering for `mmseqs cluster`
  2. `Gama_clustered` - The second one is the **prefix** you want to **NAME** your output
  2. `tmp` - Folder for storage of intermediate files while running the workflow. Can be removed afterwards

The output of this run should be like this:
1. `Gama_clustered_all_seqs.fasta` - This is a FASTA-like format of mmseqs DB showing the rep and sequences that clustered to them. Example [here](./sequences/Gama_clustered_all_seqs.fasta).
2. `Gama_clustered_cluster.tsv` - This contains a tab-delimited table similar as describe before. Example can be seen [here](./sequences/Gama_clustered_cluster.tsv).
3. `Gama_clustered_rep_seq.fasta` - This contains the representative sequence as describe before. Example can be seen [here](./sequences/Gama_clustered_rep_seq.fasta).

The options `-c`, `--min-seq-id`, and `--threads` are also usable in this workflow command. **PLEASE SEE TABLE ABOVE** for more details.


# References
1. [Steinegger M and Soeding J. MMseqs2 enables sensitive protein sequence searching for the analysis of massive data sets. Nature Biotechnology, doi: 10.1038/nbt.3988 (2017)](https://www.nature.com/articles/nbt.3988).

2. [Steinegger M and Soeding J. Clustering huge protein sequence sets in linear time. Nature Communications, doi: 10.1038/s41467-018-04964-5 (2018).](https://www.nature.com/articles/s41467-018-04964-5)

3. [Mirdita M, Steinegger M and Soeding J. MMseqs2 desktop and local web server app for fast, interactive sequence searches. Bioinformatics, doi: 10.1093/bioinformatics/bty1057 (2019).](https://academic.oup.com/bioinformatics/article/35/16/2856/5280135)

4. [Mirdita M, Steinegger M, Breitwieser F, Soding J, Levy Karin E: Fast and sensitive taxonomic assignment to metagenomic contigs. Bioinformatics, doi: 10.1093/bioinformatics/btab184 (2021).](https://doi.org/10.1093/bioinformatics/btab184)

5. [Kallenborn F, Chacon A, Hundt C, Sirelkhatim H, Didi K, Cha S, Dallago C, Mirdita M, Schmidt B, Steinegger M: GPU-accelerated homology search with MMseqs2. Nature Methods, doi: 10.1038/s41592-025-02819-8 (2025)](https://www.nature.com/articles/s41592-025-02819-8)

6. https://github.com/soedinglab/mmseqs2/wiki