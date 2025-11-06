---
title: Lesson 3 - Hidden Markov Models
parent: GLGY699 Intro to Genomics and Bioinformatics
nav_order: 3
---

# What are Hidden Markov Models
- A Hidden Markov Model (HMM) is a statistical model that represents systems with unobserved (hidden) states, where the observable outputs are probabilistically linked to these hidden states. 
- In an HMM, the system is assumed to follow a Markov process with a set of hidden states, and observations at each time step are dependent solely on the current hidden state. 

## Hidden Markov Model and Bioinformatics
In biology, nucleotide and protein sequences are under the influence of certain properties (i.e. rotational conformation, polarity, size) to form a functional product. Evolution shape this processes through mutation, insertion and deletion. However, we are mostly left only with the present sequences we can have. 

Given these unobserved hidden states, we can deduce a protein coming from the same clustering based on their current sequence. Profile HMMs made from multiple sequence alignments encapsulates information about amino acid distributions at certain position of the sequence alignment. These profile HMMs can account for hidden states such as insertions and deletions that typically occur during evolution.

Using these profile HMMs, we can make probabilits models to label whether a certain sequence matches the profile HMMs for a particular protein alignment, such as protein families, conserved domain sequences, or intron-exon junctions and more.

An example can be seen [Eddy, (2004)](https://media.springernature.com/lw685/springer-static/image/art%3A10.1038%2Fnbt1004-1315/MediaObjects/41587_2004_BFnbt10041315_Fig1_HTML.jpg?as=webp).

For proteins, we can model states such as amino acit position (M), insertions or region of variability (I), and deletions (D) for a certain protein alignment. The probability made here can be use to label whether a certain is homologous to the alignment. Here is a state diagram:

![Figure 1. A profile HMM modelling a multiple sequence alignment](https://www.ebi.ac.uk/training/online/courses/pfam-creating-protein-families/wp-content/uploads/sites/84/2023/03/Screen-Shot-2018-03-26-at-11.04.21-1024x539.png)

<br>

## Goals
In this section, we have several goals:
1. Build HMM profiles 
2. Identify proteins homologous to your functionally annotated protein

This section requires several programs:
1. Clustal Omega
2. [HMMer v3.4](https://github.com/EddyRivasLab/hmmer)
3. [Seqtk v1.5](https://github.com/lh3/seqtk) for subsetting

{: .info }
> During installation, check if the abovementioned programs can be installed using `conda`. It makes life easier. I also suggest to follow the version code displayed above as some older versions can still exists and might have some differences in runnning the abovementioned softwares.

<br>

# Exercise 3A:
Building a profile HMM for a particular clade or protein families requires the creation of multiple sequence alignment.

## Step 1: Subset Clade of Interest
An example from the previous tree building exercise, I will subset sequences that only belong to the clade that is closest to my annotated protein (Figure 2 - Purple).
![Figure 2. HypX Tree](hypx_tvbot_tree)

To fetch only the leaves or sequences from the fasta file:
1. Create a list of leaves of interest
    - `Right-click` in TVBOT 
    - Use the `get_taxa_name()` function in GGTree
2. Create a list of those tip or leaves in a `*txt` file. An example is my [hypx_clade1.txt](./sequences/hypx_clade1.txt):
    ```
    A0A916ADM4|unreviewed|Formyl
    A0A4U0GNT2|unreviewed|Formyl
    A0A938PGD7|unreviewed|Hydrogenase
    A0A7C4E8R8|unreviewed|Hydrogenase
    A0A7V2M9U8|unreviewed|Hydrogenase
    A0A2Z6DYR7|unreviewed|Hydrogenase
    H5SEZ0|unreviewed|Formyl
    A0A3N1Y112|unreviewed|Putative
    A0A372BYN7|unreviewed|Formyl
    ...
    ```
3. Run `seqtk` to subset your tips of interest:
    ```
    seqtk subseq input.fa list.txt > output.subset.fa
    ```

## Step 2: Create a multiple sequence alignment file
From the subset sequences, build a multiple sequence alignment file.

{: .note }
> Consortiums that create profile HMMs often recommends `stockholm` format for multiple sequence alignment. This format allows rich and extensible annotation.
>
>```
># STOCKHOLM 1.0
>HBB_HUMAN  ........VHLTPEEKSAVTALWGKV....NVDEVGGEALGRLLVVYPWTQRFFESFGDLSTPDAVMGNPKVKAHGKKVL
>HBA_HUMAN  .........VLSPADKTNVKAAWGKVGA..HAGEYGAEALERMFLSFPTTKTYFPHF.DLS.....HGSAQVKGHGKKVA
>MYG_PHYCA  .........VLSEGEWQLVLHVWAKVEA..DVAGHGQDILIRLFKSHPETLEKFDRFKHLKTEAEMKASEDLKKHGVTVL
>GLB5_PETMA PIVDTGSVAPLSAAEKTKIRSAWAPVYS..TYETSGVDILVKFFTSTPAAQEFFPKFKGLTTADQLKKSADVRWHAERII
>
>HBB_HUMAN  GAFSDGLAHL...D..NLKGTFATLSELHCDKL..HVDPENFRLLGNVLVCVLAHHFGKEFTPPVQAAYQKVVAGVANAL
>HBA_HUMAN  DALTNAVAHV...D..DMPNALSALSDLHAHKL..RVDPVNFKLLSHCLLVTLAAHLPAEFTPAVHASLDKFLASVSTVL
>MYG_PHYCA  TALGAILKK....K.GHHEAELKPLAQSHATKH..KIPIKYLEFISEAIIHVLHSRHPGDFGADAQGAMNKALELFRKDI
>GLB5_PETMA NAVNDAVASM..DDTEKMSMKLRDLSGKHAKSF..QVDPQYFKVLAAVIADTVAAG.........DAGFEKLMSMICILL
>
>HBB_HUMAN  AHKYH......
>HBA_HUMAN  TSKYR......
>MYG_PHYCA  AAKYKELGYQG
>GLB5_PETMA RSAY.......
>//
>```

<br>

## Step 3: Building a HMM profile
To build a profile we are gonna use `hmmbuild` command in HMMer. 

```
hmmbuild hypx_clade1.hmm hypx_clade1.sto
```

A typical output `hmm` file would look like this:

```
HMMER3/f [3.4 | Aug 2023]
NAME  hypx_clade1
LENG  570
ALPH  amino
RF    no
MM    no
CONS  yes
CS    no
MAP   yes
DATE  Thu Oct 16 14:32:05 2025
NSEQ  188
EFFN  0.806091
CKSUM 3274014947
STATS LOCAL MSV      -11.9194  0.69743
STATS LOCAL VITERBI  -12.8151  0.69743
STATS LOCAL FORWARD   -6.0762  0.69743
HMM          A        C        D        E        F        G        H        I        K        L        M        N        P        Q        R        S        T        V        W        Y   
            m->m     m->i     m->d     i->m     i->i     d->m     d->d
  COMPO   2.33543  4.36112  2.93031  2.69498  3.35346  2.83257  3.60955  2.90152  2.76726  2.44590  3.66567  3.11116  3.34319  3.10823  2.84293  2.70122  2.88079  2.64601  4.33372  3.55538
          2.68614  4.42231  2.77523  2.73129  3.46359  2.40515  3.72497  3.29357  2.67746  2.69360  4.24608  2.90346  2.73727  3.18150  2.89802  2.37886  2.77515  2.98520  4.58483  3.61508
          0.10973  2.36967  4.56463  1.18892  0.36320  0.00000        *
      1   3.20968  4.63833  4.54727  4.01666  3.13030  4.32502  4.64623  2.26619  3.79160  1.42502  1.38848  4.29916  4.60873  4.05710  3.97105  3.68426  3.45416  2.33088  5.12702  3.96243     29 m - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      2   3.12513  5.12446  3.56981  2.95258  4.55972  3.69681  3.72402  3.95322  1.90651  3.42608  4.33836  3.32258  4.10825  2.88072  1.00581  3.15186  3.31707  3.65303  5.46542  4.30693     30 r - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      3   3.18734  4.51938  4.79469  4.31734  3.45285  4.47299  4.98943  0.97372  4.14138  1.87925  3.29913  4.54426  4.78457  4.42791  4.32437  3.87525  3.45556  1.72687  5.45683  4.23034     31 i - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      4   3.39095  4.79555  4.51553  4.16096  3.22539  4.23845  4.75327  2.44524  3.92680  0.65975  3.19304  4.41668  4.64177  4.24597  4.06765  3.84019  3.67758  2.53455  5.17364  3.94239     32 L - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      5   3.32887  4.65408  4.87435  4.32849  2.10240  4.53389  4.63258  2.13812  4.19299  0.96664  2.91909  4.52395  4.72810  4.26589  4.29086  3.87871  3.54834  2.38734  4.88907  3.59019     33 l - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      6   3.27992  4.66112  4.71263  4.18680  3.07885  4.45781  4.78497  2.10279  4.00414  0.83802  2.98066  4.45721  4.70922  4.20946  4.16747  3.82268  3.44675  2.20145  5.17601  4.00985     34 l - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      7   2.20040  2.27489  3.91248  3.45920  3.81156  3.14991  4.24734  2.98373  3.35421  2.86335  3.77292  3.48532  3.82946  3.63358  3.59919  2.53213  1.57377  2.58624  5.27621  4.08553     35 t - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      8   2.98346  4.95238  3.11085  2.80013  3.54613  3.55290  1.23189  3.75593  2.49775  3.26422  4.22779  3.23077  4.05883  3.07438  2.65901  3.02876  3.25157  3.46922  4.97706  3.47007     36 h - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
      9   1.61146  4.24901  3.32474  3.05053  4.29450  2.83464  4.15863  3.69617  3.11765  3.37863  4.19981  3.27721  3.73407  3.40627  3.46812  1.42852  2.60894  3.18245  5.62764  4.39809     37 s - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
     10   3.54844  4.85667  4.55341  4.23487  0.86822  4.33826  3.66741  3.08637  4.09007  2.39518  3.72138  4.12255  4.68065  4.14236  4.16341  3.74474  3.79327  3.07009  3.83490  2.03044     38 f - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
     11   2.90573  4.90074  2.84198  2.75051  4.29773  3.33145  4.10505  4.05724  3.02880  3.68210  4.63977  0.84241  3.99540  3.38212  3.38700  2.96762  3.29673  3.65851  5.58042  4.23452     39 n - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
     12   2.31970  4.29569  3.22820  3.02170  4.42102  2.44422  4.21289  3.90327  3.17831  3.56342  4.38441  3.17533  3.74660  3.46910  3.51435  1.06066  2.80430  3.32626  5.73952  4.48760     40 s - - -
          2.68618  4.42225  2.77519  2.73123  3.46354  2.40513  3.72494  3.29354  2.67741  2.69355  4.24690  2.90347  2.73739  3.18146  2.89801  2.37887  2.77519  2.98518  4.58477  3.61503
          0.02554  4.07601  4.79836  0.61958  0.77255  0.48822  0.95119
     
```

The hmm profile is composed of a matrix of states (columns) against position (rows). The 'relative entropy` per position is the values within the matrix.

## Step 4: Search a sequence database that matches your HMM profile
To search a given protein sequence database (i.e. fasta with protein sequences), we can run `hmmsearch`:

```
hmmsearch hypx_clade1.hmm uniprot_sprot.fasta > hypx_vs_uniprot.out
```

The output file contains the summary of matched proteins and domains to your profile HMM.

```
# hmmsearch :: search profile(s) against a sequence database
# HMMER 3.4 (Aug 2023); http://hmmer.org/
# Copyright (C) 2023 Howard Hughes Medical Institute.
# Freely distributed under the BSD open source license.
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# query HMM file:                  hypx_clade1.hmm
# target sequence database:        hypx_ncbi-WP011153943_1.fasta
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Query:       hypx_clade1  [M=570]
Scores for complete sequences (score includes all domains):
   --- full sequence ---   --- best 1 domain ---    -#dom-
    E-value  score  bias    E-value  score  bias    exp  N  Sequence       Description
    ------- ------ -----    ------- ------ -----   ---- --  --------       -----------
   2.7e-282  923.5   4.3   3.2e-282  923.3   4.3    1.0  1  WP_011153943.1  hydrogenase maturation protein [Cupriavidus n
```

Important to note:
- Col1: *Sequence E-value* which is the expected number of false positive (non-homologous sequence) that scored well or better. E-values < 10^-3 as significant hits
- Col2: *Sequnce bit score* is the log-odds score for the complete sequence. This is the basis for *e-values* but independent of the size of the whole database
- Col3: *bias* is biased composition correction.
- Col4-6: Similar scores but for best hit domain or section of the sequence
    - Score in Col1-3 is based on all domains
    - We can score matches based on either 1 strong domain or multiple weak ones

{: .note }
> If both E-values are significant (<<1), the sequence has higher chance to be homologous to the query.
>
>If full sequence E-value is significant but the single best domain E-value is not, the target probably contain multiple domain that is remotely homolog to the query. However, repetitive sequences can skew this result

# TO DO:

1. Create a HMM profile for your clade of interest and other neighboring clades
2. Run `hmmsearch` for the each outgroup and ingroup HMMs to your annotated protein sequence
3. Defend that it is likely functionally similar to your protein.

# Acknowledgement
This tutorial uses screenshots from GGTree and iTOL wikis/websites. Any grievances, please let me know.

# Citation
[1]Finn RD, Clements J, Eddy SR. HMMER web server: interactive sequence similarity searching. Nucleic Acids Res. 2011 Jul;39(Web Server issue):W29-37. doi: 10.1093/nar/gkr367. Epub 2011 May 18. PMID: 21593126; PMCID: PMC3125773.

[2]Eddy, S. What is a hidden Markov model?. Nat Biotechnol 22, 1315–1316 (2004). https://doi.org/10.1038/nbt1004-1315