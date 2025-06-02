---
title: Lesson 4 - Some Bioinfo Packages
parent: Data Wrangling with R
nav_order: 4
---

# 🎓 Useful Visualization Packages for Bioinformatics

There are a lot of visualization tools in **R** that are often used in Bioinformatics. They are too many to list, but we will tackle some few examples on this page.

## Useful R Packages for Bioinformatics Visualization
Here’s a list of R packages commonly used for visualization in bioinformatics:

- **ComplexHeatmap**  
  Advanced heatmaps with annotation and clustering, widely used for omics data.

- **pheatmap**  
  Simple and elegant heatmaps, often used for gene expression data.

- **ggpubr**  
  Publication-ready plots built on top of ggplot2, with easy statistical annotation.

- **plotly**  
  Interactive plots for exploring data, including 3D and web-based graphics.

- **EnhancedVolcano**  
  Easy creation of volcano plots for differential expression analysis.

- **circlize**  
  Circular visualizations, such as chord diagrams and circos plots.

- **Gviz**  
  Visualization of genomic data and tracks, useful for genome browsers.

- **cowplot**  
  Streamlined plot composition and annotation for ggplot2 graphics.

- **ggtree**  
  Visualization and annotation of phylogenetic trees.

- **VennDiagram**  
  Creation of Venn and Euler diagrams for set analysis.

- **UpSetR** and **Complex Upset**
  Visualization of intersecting sets, an alternative to Venn diagrams.

- **RColorBrewer** and **viridis**  
  Color palettes for making plots accessible and visually appealing.

These packages cover a wide range of visualization needs in bioinformatics, from basic plots to specialized genomic and omics data visualizations.

## Learning New Data Analysis and Visualization Packages

It can be overwhelming to learn a new Package, especially in Bioniformatics. But how do you proceed?

{:.info}
>First, if you are looking for a visualization tool. Make sure you first check that it cannot easily be done by **base R** or **ggplot2** commands. For more infor on basic graphs they can present. Please check the **[R Graph Gallery](https://r-graph-gallery.com/)**

Here some helpfule guide:

- **Read the official documentation:**  
  Start with the package’s README, vignettes, and reference manual to understand its main functions and workflow.

{:.activity}
> Most packages in CRAN (R Package Repositories) requires documentation (like help files for each function). Vignettes (long-form guides or tutorials) are optional but highly recommended.
>
> Here is an example of a vignette for R: [ComplexUpset Vignette](https://cran.r-project.org/web/packages/ComplexUpset/ComplexUpset.pdf)

- **Check for tutorials and blog posts:**  
  Look for tutorials, blog posts, or YouTube videos that demonstrate real-world use cases.

{:.save}
> Most package developers also publish an online guide or tutorial. Check the package's Github site or Readthedocs.io for **ofetn** a beginner friendly guide to use their packages.
> 
> Check this tutorial on the package **[ComplexUpset](https://krassowski.github.io/complex-upset/index.html)**
> >They often shows:
> >- **Installation Guide**
> >- **Documentation**
> >- **R examples**

- **Experiment with your own data:**  
  Apply the package to your own datasets to reinforce your understanding and discover practical challenges.


- **Review function arguments:**  
  Use `?function_name` or `help(function_name)` in R to see all arguments and options for each function.

{:.note}
>Remember that you can check the usage of a function or package within R.
>
>Check it out **[here](https://gamalielcabria.github.io/DataAnalysis/Lesson1.html#the-help-system)**.


- **Consult the community:**  
  Search for questions and answers on Stack Overflow, GitHub issues, or RStudio Community if you get stuck.
> Bugs and common issues are often talked in the package's *Github Issue Page**
>
> An Example: **[https://github.com/krassowski/complex-upset/issues/186](https://github.com/krassowski/complex-upset/issues/186)**
>
>{:.warning}
>>You can opt to paste your error or issue to a GenAI (i.e. ChatGpt or Copilot). But do not trust that they will solve the issue as they still often hallucinate. 
>>
>>**Check the Package Website and developer if issues persists!** We do not bite.

- **Keep your R and packages updated:**  
  Make sure you are using the latest versions to access new features and bug fixes.

- **Practice reproducibility:**  
  Document your code and workflow so you (and others) can reproduce your analysis later.

{:.save}
> Double check the version you install and used. Newer version could have problematic update that can change the syntax of the your code. 

- **Start simple, then go deeper:**  
  Begin with basic functionality before exploring advanced features and customizations.

By following these steps, you’ll efficiently learn and apply new R packages to your bioinformatics projects.

## The R Markdown 
**R Markdown** is a powerful documentation tool that allows you to combine text, code, and results in a single, reproducible document. You can write reports, presentations, and even websites that include both your analysis and its explanation. R Markdown documents are easy to write and can be converted to HTML, PDF, or Word formats.

Here is a sample of an R Markdown code:

![R Markdown Code](https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/rmd_sample.png)

As you might have notice it is written like a code or a text file. Because, it is!

The **Markdown** is a lightweight markup language that makes it easy to format text using plain readble characters. With simple symbols, you can create headings, lists, links, images, code blocks, and more—without needing complex formatting tools. Markdown is widely used for documentation, README files, and reproducible research because it is both human- and machine-readable. 

The input `.md` or markdown file (`.Rmd` or R markdown, too) is renderred along the code that needs to be executed inside it. Here is an example output of a renderred **R Markdown** html:

![Knitted R Markdown]((https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/rmd_knit_sample.png)

## 🙇🏻‍♀️ More Packages to Follow
Unfortunately, we will end here for now. We will update this page with more examples of **R Packages** that you might need to start your Bioinformatics journey!

For the meantime: Read more papers, identify the analyses, graphs, and plots you want, Lookup the package use in the Methodology and 🔍**Google Away!!!**