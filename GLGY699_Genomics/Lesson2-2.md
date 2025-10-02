---
title: Lesson 2A - Neighbor Joining
parent: Lesson 2 - Tree Building
nav_order: 1
---

# An example of tree building: Neighbor Joining 
To demonstrate the process of calculating a Neighbor-Joining (NJ) score using a simple example, we can employ a set of DNA sequences consisting of five bases. Let’s consider the following four sequences:

```
>Sequence A
ACGTA
>Sequence B
ACGTC
>Sequence C
AAGTA
>Sequence D
AGGTA
```

## Step 1: Generate a Distance Matrix
First, we need to compute a distance matrix using a straightforward method, such as the number of positions at which the corresponding bases are different (commonly referred to as Hamming distance). Here is how the pairwise distances are calculated:

```
Distance(A, B): 1 (different at 1 position)
Distance(A, C): 1 (different at 1 position)
Distance(A, D): 1 (different at 1 position)
Distance(B, C): 2 (different at 2 positions)
Distance(B, D): 2 (different at 2 positions)
Distance(C, D): 1 (different at 1 position)
```

Using these calculations, we can construct the distance matrix as follows:

| | A |	B	| C	| D |
|--|--|--|--|--|
|A	|0	|1	|1	|1|
|B	|1	|0	|2	|2|
|C	|1	|2	|0	|1|
|D	|1	|2	|1	|0|

<br>

## Step 2: Apply the Neighbor-Joining Algorithm
Now, we apply the NJ algorithm, which involves the following steps:

1. Find the smallest distance in the distance matrix. Here, the smallest distance is 1, corresponding to either (A, B), (A, C), (A, D), or (C, D).

2. Join the pair of sequences with the smallest distance. Let’s join A and B. The new node will be labeled as AB.

3. Update the distance matrix by averaging the distances of sequences A and B to all other sequences. The distances to sequences C and D will be recalculated based on the formula:

<p align="center">
  <img src="https://latex.codecogs.com/svg.latex?d_{AB,X}=\frac{d_{A,X}+d_{B,X}}{2}" alt="equation"/>
</p>

```
Distance(AB, C) = (Distance(A, C) + Distance(B, C)) / 2 = (1 + 2) / 2 = 1.5
Distance(AB, D) = (Distance(A, D) + Distance(B, D)) / 2 = (1 + 2) / 2 = 1.5
```

<div style="margin-left:40px">
The new distance matrix becomes:

| |AB|	C|	D|
|--|--|--|--|
|AB	|0	|1.5	|1.5|
|C	|1.5	|0	|1|
|D	|1.5	|1	|0|

</div>

4. Repeat the process by finding the smallest distance again until all nodes are merged into a single tree. Joining C and D next leads to the construction of the final tree.

<br>

## Step 3: Construct the Phylogenetic Tree
The resulting tree will depict the evolutionary relationships, with branches indicating the distances (total branch lengths) based on the calculations above. You can build this tree using a ruler if you want to!

In summary, this example illustrates a simple yet effective method for calculating Neighbor-Joining scores from basic sequences. It is crucial to recognize that while we have simplified the mathematics here, the same algorithm can be applied to more extensive and complex datasets spanning multiple species or genes. Using methods like NJ provides an efficient way to infer phylogenetic relationships in comparative genomics.