---
title: Lesson 2 - Tree Building
parent: Intro to GLGY699 Genomics and Bioinformatics
nav_order: 2
---

# What are Phylogenetic Trees
Phylogenetic trees serve as vital tools in biology, providing a structured visual representation of the evolutionary relationships among various biological entities, including species, genes, and viruses. These trees are grounded in the principles of common ancestry and depict how different organisms or genes have diverged from shared ancestors over time (Bordewich et al., 2017; Gregory, 2008). They are constructed using various forms of data, primarily genetic sequences such as DNA, RNA, or protein alignments, which allows for detailed comparative analyses.

Given that phylogenetic trees shows evolutionary relations, aligning DNA, RNA and/or protein sequences is a must step to properly score for any changes in the sequence, may it be substitution, deletion, insertion and/or duplication. Alignment is a crucial step in building trees as errors can skew evolutionary interpretation.

<br>

## Goals
In this section, we have several goals:
1. Build a phylogenetic tree using MSA fasta file
2. Visualize a phylogenetic tree
3. Cluster proteins to build a Tree

This section requires several programs:
1. FastTree v2.2
2. mmseqs2
3. R and R Packages: Tidyverse, TreeIO and GGTree 

## Building a Tree
Different methodologies for phylogenetic tree construction can be categorized broadly into distance-based, parsimony-based, and likelihood-based approaches. **Distance-based methods**, such as the Neighbor-Joining algorithm, are favored for their simplicity and computational efficiency, especially when dealing with large datasets (Qin et al., 2006). In contrast, **Maximum Likelihood** and **Bayesian inference** methods offer more robust frameworks for considering complex evolutionary models but often require more computational resources (Cerutti et al., 2011; Scott & Gras, 2012). The choice of method can significantly influence the topology and branch lengths of the resultant tree (Liu et al., 2009).

### Measuring Distances and Scoring Tree
**Distance-based** methods measure pairwise distances/differences between sequences to build tree. Meanwhile, **character-based** methods look directly at the characters in the aligned sequences and attribtue a score on the changes or evoloved as depicted in the sequences (i.e. substitution or evolutionary models) to take into account *rate heterogeneity* and *base/amino acid* frequency variations.

{: .note }
> For a simple demonstration of distance based method, please take a look at [Lesson 2A: Neighbor-joining](./Lesson2-2.md)

There are multiple ways in *character-based* methods to build a phylogenetic tree. In **Maximum Parsimony**, it operates on the principle that the *best tree is the one that requires the fewest evolutionary changes across all sites*. It assumes that each character or column in an sequence alignment is independent of each other. It is intuitive and fast and does not need complex evolutionary models but fails when there are fast-evolving sequences as it cannot easily differentiate them and interaction between segments of the sequences.

In contrast, **Maximum Likelihood** methods (ML) takes into accoutn evolutionary models. It tries to find *the best tree or topology of sequences by finding the tree that best explained an evolutionary model*. In ML tree building, it creates multiple trees to match a given topology and branch length to match an evolutionary model and assigns a score for each. The tree with highest score is chosen. It is very rigorous but often are time and computationally consuming. 

>**Bootstrapping** is the resampling from the same input several times to check on the uncertainty of your model or trees. 
>It is used to measure the reliability of clades that were formed after repeated resampling or subsampling of sequences. A clade that occurs 990/1000 times is more certain to occur than a clade that only appears 130/1000 times that a tree was formed

Lastly, similar to ML, **Bayesian Inference** it assignes probability that the tree or topoplogy is correct based on an evolutionary model. However, rather than finding the "best" tree, it estimates the posterior probability distribution of tree/topology. 

> **Posterior probabilities** are conditional probabilities derived from Bayes’ rule. They combine prior knowledge with observational data under a chosen model, reflecting our updated belief about a hypothesis or parameter. Importantly, each posterior can serve as a new prior for further Bayesian updating when new information arrives.
> In *Bayesian inference* made trees, posterior probabilities are used to determine clade worthiness rather than bootstrapping percentage.

### Exercise 2A: Building a tree

Here, we will use the multiple sequence alignments created from previous exercise. We will use the fasta formatted MSA files as input for Tree Building. 

{: .note }
> Build a tree using your MSA files
> 1. Run Fast Tree using the default settings:
> ```
> FastTree <protein_alignment>.msa.fasta > <protein_alignment>.fast.tree
> ```
>
> 2. Check your outputs by using `more` or `less` or `nano`

In addition, let us create a tree with a different evolutionary model. By default, FastTree uses ML and Jones-Taylor-Thorton model for tree-building using amino acids. Another evolutionary model is Le-Gascuel (LG).

{:.note }
> Build a tree using LG model:
> ```
> FastTree <protein_alignment>.msa.fasta > <protein_alignment>.lg.tree
> ```
> Note: that here I change the file extension of the file to denote different trees.


### Tree visualization and interpretation 
There are multiple ways to visualizing a phylogenetic tree. One is  through the program `MEGA11` which we installed previously and another is through the R Package `GGTree` which will be using through `R` or its IDE `RStudio`. 

`GGTree` has robust way of modifying a 




# Tips and Summary

# Acknowledgement
This tutorial uses screenshots from NCBI and EBI/InterProScan websites. Any grievances, please let me know.r

# Citation
[1]Bordewich, M., Deutschmann, I., Fischer, M., Kasbohm, E., Semple, C., & Steel, M. (2017). On the information content of discrete phylogenetic characters. Journal of Mathematical Biology, 77(3), 527-544. https://doi.org/10.1007/s00285-017-1198-2

[2]Gregory, T. (2008). Understanding evolutionary trees. Evolution Education and Outreach, 1(2), 121-137. https://doi.org/10.1007/s12052-008-0035-x

[3]McMahon, M., Deepak, A., Fernández‐Baca, D., Boss, D., & Sanderson, M. (2015). Stbase: one million species trees for comparative biology. Plos One, 10(2), e0117987. https://doi.org/10.1371/journal.pone.0117987

[4]Cerutti, F., Bertolotti, L., Goldberg, T., & Giacobini, M. (2011). Taxon ordering in phylogenetic trees: a workbench test. BMC Bioinformatics, 12(1). https://doi.org/10.1186/1471-2105-12-58
Chan, C. and Ragan, M. (2013). Next-generation phylogenomics. Biology Direct, 8(1). https://doi.org/10.1186/1745-6150-8-3

[5]Liu, S., Ji, K., Chen, J., Tai, D., Jiang, W., Hou, G., … & Huang, B. (2009). Panorama phylogenetic diversity and distribution of type a influenza virus. Plos One, 4(3), e5022. https://doi.org/10.1371/journal.pone.0005022

[6]Qin, L., Luo, J., Chen, Z., Guo, J., Chen, L., & Pan, Y. (2006). Phelogenetic tree construction using self adaptive ant colony algorithm.. https://doi.org/10.1109/imsccs.2006.104

[7]Scott, R. and Gras, R. (2012). Comparing distance-based phylogenetic tree construction methods using an individual-based ecosystem simulation, ecosim.. https://doi.org/10.7551/978-0-262-31050-5-ch015
