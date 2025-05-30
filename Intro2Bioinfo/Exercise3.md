---
title: Exercise 3 - Useful Commands
parent: Intro to Bioinfo
nav_order: 4
---


# 🧪 Bioinformatics Practice Exercise: Linux Command Line

This exercise uses files from [this GitHub folder](https://github.com/gamalielcabria/gamalielcabria.github.io/tree/main/Intro2Bioinfo/files).

To get started, download the files to your terminal using `wget`:

```bash
mkdir -p ~/bioinfo_practice && cd ~/bioinfo_practice

wget -P ./ https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/data.tsv
wget -P ./ https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/gene_counts.tsv
wget -P ./ https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/genes.txt
wget -P ./ https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/lengths.txt
wget -P ./ https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/Intro2Bioinfo/files/random.fasta
```

---

## 📝 Exercises

### Task 1. **Inspecting Files**
- View the first few lines of each file using `head`.
- Count the number of rows and columns in `gene_counts.tsv`.


---

### Task 2. **Extracting and Combining Columns**
- Extract the 1st and 3rd columns from `data.tsv` and save to `score.tsv`.
- Extract the 1st and 2nd columns and save to `value.tsv`.
- Merge them side by side using `paste`.


---

### Task 3. **Grep and Regex**
- Count how many genes start with `geneK` or `geneC` in `gene_counts.tsv`.
- Count how many sequences are in `random.fasta`.


---

### Task 4. **Text Processing with `sed`**
- Replace all instances of `gene` in `gene_counts.tsv` with `GENE`.
- Convert `data.tsv` into a CSV file.


---

### Task 5: **Character-Level Transformations with `tr`**
- Convert all nucleotide sequences in `random.fasta` to lowercase.
- Remove numbers from FASTA sequences.

---

### Task 6: **Count Features in GTF File**
- Download a GTF file from [Ensembl](ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/Homo_sapiens.GRCh38.110.gtf.gz): 
- Count the number of entries that are `gene` and annotated as `rRNA`
- Count the number of entries that are `exon` and annotated as `tRNA`

---

## 🧪 Advanced Practice Tasks

### Task 7: **Filter Genes with High Expression in Multiple Samples**

Using `awk`, filter rows in `gene_counts.tsv` where:
- **Sample3** > 250
- **Sample6** > 250

<details>
<summary>Click to view code</summary>

<pre><code class="language-bash">
awk '$4 > 250 && $7 > 250' destination/gene_counts.tsv
</code></pre>
</details>

---

### Task 8: **Convert FASTA sequences to lowercase and count base composition**

Use `tr` to convert the sequences in `random.fasta` to lowercase, and then use `grep` and `wc` to count how many 'a', 't', 'g', and 'c' characters are present.

<details>
<summary>Click to view code</summary>

<pre><code class="language-bash">
tr 'A-Z' 'a-z' < destination/random.fasta | grep -v "^>" > seq_lc.txt
grep -o "a" seq_lc.txt | wc -l
grep -o "t" seq_lc.txt | wc -l
grep -o "g" seq_lc.txt | wc -l
grep -o "c" seq_lc.txt | wc -l
</code></pre>
</details>

---

# ✅ Submission (Optional)
Summarize your findings or output in a `report.txt` file using `echo` and redirection.

{:.highlight}
>Exampled:
>```bash
>echo "Number of gene rows: $(wc -l < gene_counts.tsv)" > report.txt
>echo "Number of sequences: $(grep -c '^>' random.fasta)" >> report.txt
>```

---

**📂 Files Used:**
- `data.tsv`
- `gene_counts.tsv`
- `genes.txt`
- `lengths.txt`
- `random.fasta`

---

📌 Tip: Try modifying the scripts or extending them. For instance, filter genes with expression above 200, or find sequences longer than 10 bp using `awk`.

---



<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

# Solution

### Tired? Here are the solutions:

<b>Number 1</b>
<details>
<summary>Click to expand code</summary>
<pre><code class="language-bash">
head gene_counts.tsv
wc -l gene_counts.tsv
head -1 gene_counts.tsv | awk -F'\t' '{print NF}'
</code></pre>
</details>

<b>Number 2</b>
<details>
<summary>Click to expand code</summary>
<pre><code class="language-bash">
cut -f1,3 data.tsv > score.tsv
cut -f1,2 data.tsv > value.tsv
paste score.tsv value.tsv > combined.tsv
</code></pre>
</details>

<b>Number 3</b>
<details>
<summary>Click to expand code</summary>
<pre><code class="language-bash">
grep "^gene[KC]" gene_counts.tsv | wc -l
grep -c "^>" random.fasta
</code></pre>
</details>

<b>Number 4</b>
<details>
<summary>Click to expand code</summary>
<pre><code class="language-bash">
sed 's/gene/GENE/g' gene_counts.tsv | head
sed 's/\t/,/g' data.tsv > data.csv
</code></pre>
</details>

<b>Number 5</b>
<details>
<summary>Click to expand code</summary>
<pre><code class="language-bash">
tr 'A-Z' 'a-z' < random.fasta > random_lowercase.fasta
tr -d '0-9' < random.fasta | head
</code></pre>
</details>

<b>Number 6</b>
<details>
<summary>Click to expand code</summary>
<pre><code class="language-bash">
wget ftp://ftp.ensembl.org/pub/release-110/gtf/homo_sapiens/Homo_sapiens.GRCh38.110.gtf.gz

zcat Homo_sapiens.GRCh38.110.gtf.gz | grep -P '\tgene\t' | grep 'rRNA' | wc -l
zcat Homo_sapiens.GRCh38.110.gtf.gz | grep -P '\texon\t' | grep 'tRNA' | wc -l
</code></pre>
</details>



Or not? :D
