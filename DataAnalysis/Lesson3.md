---
title: Lesson 3 - Tidying with TidyR
parent: Data Wrangling with R
nav_order: 3
---

# Tidying Data with `tidyr`

The `tidyr` package is designed to help you create tidy data, which is a
standardized way of organizing data that makes it easier to work with.
Tidy data has the following characteristics: - Each variable forms a
column. - Each observation forms a row. - Each type of observational
unit forms a table.

Tidy data is essential for efficient data analysis and visualization, as
it allows you to easily manipulate and visualize your data using the
tidyverse packages.

## Example Dataset with `tidyr`

In this section, we will use another Bioinformatics dataset to
demonstrate the use of `tidyr` for tidying data. The dataset is a
summarised table listing the instances that the program `virsorter`
predicted a viral sequence in a metagenomic dataset. The dataset
contains the following columns: - **Genome**: The name of the genome
file. - It is divided by the **Site**, **Timepoint** (i.e. SE046),
**Sample Name** (i.e. G07\_cluster\_2), and **Population**(i.e. Blue). -
**Viral Type**: The predicted viral sequence is either **dsDNAPhage** or
**ssDNAPhage**.

To download the data, run the following code:

```bash
wget https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/virsorter/virsorter_output.csv
```

Let us load the dataset and take a look at its structure:

```{r}
library(tidyverse)

virsorter_data <- read_csv("./virsorter_output.csv",
  col_types = cols(
    ...1 = col_skip(),              # Skip the first unnamed column
    Genome = col_character(),       # The genome file name
    Phage_Type = col_character()    # The predicted viral sequence type
  )
)
head(virsorter_data)
```

    ## # A tibble: 6 × 2
    ##   Genome                             Phage_Type
    ##   <chr>                              <chr>     
    ## 1 KRP1_SE046_G07_cluster_2_Blue_vs2  dsDNAphage
    ## 2 KRP1_SE046_G11_cluster_3_Blue_vs2  dsDNAphage
    ## 3 KRP1_SE046_G25_cluster_1_Green_vs2 dsDNAphage
    ## 4 KRP1_SE046_G26_cluster_1_Blue_vs2  dsDNAphage
    ## 5 KRP1_SE055_G02_cluster_2_Brown_vs2 dsDNAphage
    ## 6 KRP1_SE055_G02_cluster_2_Brown_vs2 dsDNAphage

------------------------------------------------------------------------

## Separate: Expanding a column into multiple columns

Sometimes, a single column contains multiple pieces of information that
can be separated into distinct columns. The `separate()` function from
`tidyr` allows you to do this easily.

In our dataset, the **Genome** column contains multiple pieces of
information separated by underscores. We can use `separate()` to split
this column into multiple columns.

```{r}
virsorter_data_separated <- virsorter_data %>%
  separate(Genome, 
            into = c("Site", "Timepoint", "Sample_Name"), 
            sep = "_", 
            remove = TRUE,
            extra = "merge",
            fill = "right"
            )
head(virsorter_data_separated, n = 20)
```

    ## # A tibble: 20 × 4
    ##    Site  Timepoint Sample_Name                       Phage_Type
    ##    <chr> <chr>     <chr>                             <chr>     
    ##  1 KRP1  SE046     G07_cluster_2_Blue_vs2            dsDNAphage
    ##  2 KRP1  SE046     G11_cluster_3_Blue_vs2            dsDNAphage
    ##  3 KRP1  SE046     G25_cluster_1_Green_vs2           dsDNAphage
    ##  4 KRP1  SE046     G26_cluster_1_Blue_vs2            dsDNAphage
    ##  5 KRP1  SE055     G02_cluster_2_Brown_vs2           dsDNAphage
    ##  6 KRP1  SE055     G02_cluster_2_Brown_vs2           dsDNAphage
    ##  7 KRP1  SE055     G02_cluster_2_Brown_vs2           dsDNAphage
    ##  8 KRP1  SE055     G05_cluster_3_Brown_vs2           dsDNAphage
    ##  9 KRP1  SE055     G05_cluster_3_Brown_vs2           dsDNAphage
    ## 10 KRP1  SE055     G06_cluster_2_Brown_vs2           dsDNAphage
    ## 11 KRP1  SE055     G06_cluster_2_Brown_vs2           dsDNAphage
    ## 12 KRP1  SE055     G09_cluster_3_Brown_vs2           dsDNAphage
    ## 13 KRP1  SE055     G09_cluster_3_Brown_vs2           dsDNAphage
    ## 14 KRP1  SE055     G10_cluster_2_Green_vs2           dsDNAphage
    ## 15 KRP1  SE055     G12_cluster_2_cluster_1_Green_vs2 dsDNAphage
    ## 16 KRP1  SE055     G12_cluster_2_cluster_3_Brown_vs2 dsDNAphage
    ## 17 KRP1  SE055     G12_cluster_2_cluster_3_Brown_vs2 dsDNAphage
    ## 18 KRP1  SE057     G07_cluster_2_Brown_vs2           dsDNAphage
    ## 19 KRP1  SE057     G07_cluster_2_Brown_vs2           dsDNAphage
    ## 20 KRP1  SE057     G07_cluster_2_Brown_vs2           dsDNAphage

You might notice that the **Population** column is still missing. It is
hard to extract since some genomes
(i.e. KRP1\_SE055\_G12\_cluster\_2\_cluster\_1\_Green\_vs2) have more
than one extra sets of columns due to extra ’\_’.

We can use the `str_extract()` function from the `stringr` package to
extract the population from the **Sample\_Name** column.

The `extra = "merge"` argument in the `separate()` function allows us to
merge any extra pieces of information into the last column, which is
useful when the number of pieces of information varies across rows. The
`fill = "right"` argument ensures that any missing values are filled
with `NA` on the right side. <br>

### The opposite of `separate()`: `unite()`

The `unite()` function from `tidyr` allows you to combine multiple
columns into a single column. This is useful when you want to create a
new column that contains information from multiple existing columns.

```{r}
virsorter_data_united <- virsorter_data_separated %>%
  unite("Genome", Site, Timepoint, Sample_Name, sep = "_", remove = FALSE)
head(virsorter_data_united)
```

    ## # A tibble: 6 × 5
    ##   Genome                             Site  Timepoint Sample_Name      Phage_Type
    ##   <chr>                              <chr> <chr>     <chr>            <chr>     
    ## 1 KRP1_SE046_G07_cluster_2_Blue_vs2  KRP1  SE046     G07_cluster_2_B… dsDNAphage
    ## 2 KRP1_SE046_G11_cluster_3_Blue_vs2  KRP1  SE046     G11_cluster_3_B… dsDNAphage
    ## 3 KRP1_SE046_G25_cluster_1_Green_vs2 KRP1  SE046     G25_cluster_1_G… dsDNAphage
    ## 4 KRP1_SE046_G26_cluster_1_Blue_vs2  KRP1  SE046     G26_cluster_1_B… dsDNAphage
    ## 5 KRP1_SE055_G02_cluster_2_Brown_vs2 KRP1  SE055     G02_cluster_2_B… dsDNAphage
    ## 6 KRP1_SE055_G02_cluster_2_Brown_vs2 KRP1  SE055     G02_cluster_2_B… dsDNAphage

### Featuring: Tidyverse’s `stringr`

The `stringr` package provides a set of functions for working with
strings in R. It is part of the tidyverse and is designed to make string
manipulation easier and more consistent.

    library(stringr)
    virsorter_data_separated <- virsorter_data_united %>%
      mutate(Population = str_extract(Genome, "Green|Blue|Yellow|Orange|Brown|Purple"))
    head(virsorter_data_separated, n = 20)

    ## # A tibble: 20 × 6
    ##    Genome                      Site  Timepoint Sample_Name Phage_Type Population
    ##    <chr>                       <chr> <chr>     <chr>       <chr>      <chr>     
    ##  1 KRP1_SE046_G07_cluster_2_B… KRP1  SE046     G07_cluste… dsDNAphage Blue      
    ##  2 KRP1_SE046_G11_cluster_3_B… KRP1  SE046     G11_cluste… dsDNAphage Blue      
    ##  3 KRP1_SE046_G25_cluster_1_G… KRP1  SE046     G25_cluste… dsDNAphage Green     
    ##  4 KRP1_SE046_G26_cluster_1_B… KRP1  SE046     G26_cluste… dsDNAphage Blue      
    ##  5 KRP1_SE055_G02_cluster_2_B… KRP1  SE055     G02_cluste… dsDNAphage Brown     
    ##  6 KRP1_SE055_G02_cluster_2_B… KRP1  SE055     G02_cluste… dsDNAphage Brown     
    ##  7 KRP1_SE055_G02_cluster_2_B… KRP1  SE055     G02_cluste… dsDNAphage Brown     
    ##  8 KRP1_SE055_G05_cluster_3_B… KRP1  SE055     G05_cluste… dsDNAphage Brown     
    ##  9 KRP1_SE055_G05_cluster_3_B… KRP1  SE055     G05_cluste… dsDNAphage Brown     
    ## 10 KRP1_SE055_G06_cluster_2_B… KRP1  SE055     G06_cluste… dsDNAphage Brown     
    ## 11 KRP1_SE055_G06_cluster_2_B… KRP1  SE055     G06_cluste… dsDNAphage Brown     
    ## 12 KRP1_SE055_G09_cluster_3_B… KRP1  SE055     G09_cluste… dsDNAphage Brown     
    ## 13 KRP1_SE055_G09_cluster_3_B… KRP1  SE055     G09_cluste… dsDNAphage Brown     
    ## 14 KRP1_SE055_G10_cluster_2_G… KRP1  SE055     G10_cluste… dsDNAphage Green     
    ## 15 KRP1_SE055_G12_cluster_2_c… KRP1  SE055     G12_cluste… dsDNAphage Green     
    ## 16 KRP1_SE055_G12_cluster_2_c… KRP1  SE055     G12_cluste… dsDNAphage Brown     
    ## 17 KRP1_SE055_G12_cluster_2_c… KRP1  SE055     G12_cluste… dsDNAphage Brown     
    ## 18 KRP1_SE057_G07_cluster_2_B… KRP1  SE057     G07_cluste… dsDNAphage Brown     
    ## 19 KRP1_SE057_G07_cluster_2_B… KRP1  SE057     G07_cluste… dsDNAphage Brown     
    ## 20 KRP1_SE057_G07_cluster_2_B… KRP1  SE057     G07_cluste… dsDNAphage Brown

{:.notice}
>The `mutate()` function is still needed to create a new column in the dataset. This is because `str_extract()` returns a character vector of the same length as the input, and we need to assign it to a new column in the dataset.

------------------------------------------------------------------------

## Recode: Replacing values in a column

Sometimes, you may want to replace specific values in a column with new
values. The `recode()` function from `dplyr` allows you to do this
easily.

    virsorter_data_recode <- virsorter_data_separated %>% 
        mutate(Population = recode(Population, 
                        Orange="Hydrogenobacter sp. Cluster 2 Orange", 
                        Blue="Hydrogenobacter sp. Cluster 2 Blue", 
                        Green="Hydrogenobacter sp. Cluster 1 Green", 
                        Yellow="H. thermophilus", 
                        Brown="Sulfurihydrogenibium sp.",
                        Purple="Venenivibrio sp."
                        )
        ) 
    head(virsorter_data_recode)

    ## # A tibble: 6 × 6
    ##   Genome                       Site  Timepoint Sample_Name Phage_Type Population
    ##   <chr>                        <chr> <chr>     <chr>       <chr>      <chr>     
    ## 1 KRP1_SE046_G07_cluster_2_Bl… KRP1  SE046     G07_cluste… dsDNAphage Hydrogeno…
    ## 2 KRP1_SE046_G11_cluster_3_Bl… KRP1  SE046     G11_cluste… dsDNAphage Hydrogeno…
    ## 3 KRP1_SE046_G25_cluster_1_Gr… KRP1  SE046     G25_cluste… dsDNAphage Hydrogeno…
    ## 4 KRP1_SE046_G26_cluster_1_Bl… KRP1  SE046     G26_cluste… dsDNAphage Hydrogeno…
    ## 5 KRP1_SE055_G02_cluster_2_Br… KRP1  SE055     G02_cluste… dsDNAphage Sulfurihy…
    ## 6 KRP1_SE055_G02_cluster_2_Br… KRP1  SE055     G02_cluste… dsDNAphage Sulfurihy…

Let us create a summary table that counts the number of viral sequences
per Phage\_Type and Genome:

    virsorter_summary <- virsorter_data_recode %>%
      group_by(Population, Phage_Type) %>%
      summarise(Count = n()
      ) %>%
      arrange(Population, Phage_Type)
    virsorter_summary

    ## # A tibble: 7 × 3
    ## # Groups:   Population [6]
    ##   Population                           Phage_Type Count
    ##   <chr>                                <chr>      <int>
    ## 1 H. thermophilus                      dsDNAphage     6
    ## 2 Hydrogenobacter sp. Cluster 1 Green  dsDNAphage    42
    ## 3 Hydrogenobacter sp. Cluster 2 Blue   dsDNAphage     3
    ## 4 Hydrogenobacter sp. Cluster 2 Orange dsDNAphage   104
    ## 5 Hydrogenobacter sp. Cluster 2 Orange ssDNA          1
    ## 6 Sulfurihydrogenibium sp.             dsDNAphage    40
    ## 7 Venenivibrio sp.                     dsDNAphage     3

------------------------------------------------------------------------

## Converting long data to wide format: `pivot_wider`

The table `virsorter_summary` is in long format, where each row
represents a unique combination of Population and Phage\_Type. We can
use the `pivot_wider()` function from `tidyr` to convert this table into
wide format, where each Population has its own column for each
Phage\_Type.

    virsorter_wide <- virsorter_summary %>%
      pivot_wider(names_from = Phage_Type, values_from = Count, values_fill = 0)
    head(virsorter_wide)

    ## # A tibble: 6 × 3
    ## # Groups:   Population [6]
    ##   Population                           dsDNAphage ssDNA
    ##   <chr>                                     <int> <int>
    ## 1 H. thermophilus                               6     0
    ## 2 Hydrogenobacter sp. Cluster 1 Green          42     0
    ## 3 Hydrogenobacter sp. Cluster 2 Blue            3     0
    ## 4 Hydrogenobacter sp. Cluster 2 Orange        104     1
    ## 5 Sulfurihydrogenibium sp.                     40     0
    ## 6 Venenivibrio sp.                              3     0

Wider data formats are often easier to read and can be useful for
certain types of analyses, such as when you want to compare values
across different categories.

### Converting wide data to long format: `pivot_longer`

Meanwhile, if you have a dataset in wide format and you want to convert
it back to long format, you can use the `pivot_longer()` function. This
is useful when you want to perform operations that require tidy data.

    virsorter_long <- virsorter_wide %>%
      pivot_longer(cols = -Population, 
                   names_to = "Phage_Type", 
                   values_to = "Count")
    head(virsorter_long)

    ## # A tibble: 6 × 3
    ## # Groups:   Population [3]
    ##   Population                          Phage_Type Count
    ##   <chr>                               <chr>      <int>
    ## 1 H. thermophilus                     dsDNAphage     6
    ## 2 H. thermophilus                     ssDNA          0
    ## 3 Hydrogenobacter sp. Cluster 1 Green dsDNAphage    42
    ## 4 Hydrogenobacter sp. Cluster 1 Green ssDNA          0
    ## 5 Hydrogenobacter sp. Cluster 2 Blue  dsDNAphage     3
    ## 6 Hydrogenobacter sp. Cluster 2 Blue  ssDNA          0

{:.warning} 
> The `pivot_longer()` function is the opposite of `pivot_wider()`. It might seem reversible, but it is not always straightforward. The `cols` argument specifies which columns to pivot, and the `names_to` and `values_to` arguments specify the names of the new columns created from the pivoting operation. > > When there is missing data, the `pivot_longer()` function will fill in the missing values with `NA`. This is important to keep in mind when working with datasets that may have missing values.

{:.info} 
> **`replace_na()`**: > It can be manually replaced with `0` or any other value using the `replace_na()` function from `tidyr`.
> >`df_long <- df_long %>% mutate(score = replace_na(score, 0))`

------------------------------------------------------------------------

## Expanding a dataset with `expand()`

Let us subset the dataset from `virsorter_data_recode` to only include
the **Population** and **Site** columns. We can then use the `expand()`
function to create a dataset that contains all combinations of these two
variables.

    virsorter_expanded <- virsorter_data_recode %>%
        select(Population, Site) %>%
        distinct() %>%
        expand(Population, Site)
    virsorter_expanded

    ## # A tibble: 18 × 2
    ##    Population                           Site 
    ##    <chr>                                <chr>
    ##  1 H. thermophilus                      KRP1 
    ##  2 H. thermophilus                      KRP2 
    ##  3 H. thermophilus                      KRP2B
    ##  4 Hydrogenobacter sp. Cluster 1 Green  KRP1 
    ##  5 Hydrogenobacter sp. Cluster 1 Green  KRP2 
    ##  6 Hydrogenobacter sp. Cluster 1 Green  KRP2B
    ##  7 Hydrogenobacter sp. Cluster 2 Blue   KRP1 
    ##  8 Hydrogenobacter sp. Cluster 2 Blue   KRP2 
    ##  9 Hydrogenobacter sp. Cluster 2 Blue   KRP2B
    ## 10 Hydrogenobacter sp. Cluster 2 Orange KRP1 
    ## 11 Hydrogenobacter sp. Cluster 2 Orange KRP2 
    ## 12 Hydrogenobacter sp. Cluster 2 Orange KRP2B
    ## 13 Sulfurihydrogenibium sp.             KRP1 
    ## 14 Sulfurihydrogenibium sp.             KRP2 
    ## 15 Sulfurihydrogenibium sp.             KRP2B
    ## 16 Venenivibrio sp.                     KRP1 
    ## 17 Venenivibrio sp.                     KRP2 
    ## 18 Venenivibrio sp.                     KRP2B

Let us compare the original dataset with the expanded dataset. The
original dataset has 18 rows, while the expanded dataset has 30 rows.
This is because the expanded dataset contains all combinations of
Population, Site, and Phage\_Type, including those that were not present
in the original dataset.

    virsorter_original <- virsorter_data_recode %>%
        select(Population, Site) %>%
        distinct()
    virsorter_original

    ## # A tibble: 11 × 2
    ##    Population                           Site 
    ##    <chr>                                <chr>
    ##  1 Hydrogenobacter sp. Cluster 2 Blue   KRP1 
    ##  2 Hydrogenobacter sp. Cluster 1 Green  KRP1 
    ##  3 Sulfurihydrogenibium sp.             KRP1 
    ##  4 H. thermophilus                      KRP1 
    ##  5 Hydrogenobacter sp. Cluster 2 Orange KRP1 
    ##  6 Venenivibrio sp.                     KRP1 
    ##  7 Hydrogenobacter sp. Cluster 1 Green  KRP2B
    ##  8 Sulfurihydrogenibium sp.             KRP2B
    ##  9 Hydrogenobacter sp. Cluster 2 Orange KRP2 
    ## 10 Hydrogenobacter sp. Cluster 1 Green  KRP2 
    ## 11 Sulfurihydrogenibium sp.             KRP2

As you can see, the expanded dataset contains additional rows that were
not present in the original dataset. This is useful when you want to
ensure that all combinations of variables are represented in your data,
which can be important for certain types of analyses or visualizations.

{:.note} 
> The `expand()` function is particularly useful when you want to create a dataset that contains all possible combinations of variables, even if some combinations do not exist in the original dataset. This can be helpful for creating visualizations or performing analyses that require complete datasets.

------------------------------------------------------------------------

## Complete a dataset with `complete()`

The `complete()` function from `tidyr` allows you to fill in missing
combinations of variables in your dataset. This is useful when you want
to ensure that all possible combinations of variables are represented in
your data.

    virsorter_incomplete <- virsorter_data_recode %>%
        group_by(Population, Phage_Type, Site, Timepoint) %>%
        summarise(Count = n()) %>%
        ungroup() %>%
        pivot_wider(names_from = Phage_Type, values_from = Count, values_fill = 0)
    virsorter_incomplete

    ## # A tibble: 18 × 5
    ##    Population                           Site  Timepoint dsDNAphage ssDNA
    ##    <chr>                                <chr> <chr>          <int> <int>
    ##  1 H. thermophilus                      KRP1  SE057              6     0
    ##  2 Hydrogenobacter sp. Cluster 1 Green  KRP1  SE046              1     0
    ##  3 Hydrogenobacter sp. Cluster 1 Green  KRP1  SE055              2     0
    ##  4 Hydrogenobacter sp. Cluster 1 Green  KRP1  SE058             19     0
    ##  5 Hydrogenobacter sp. Cluster 1 Green  KRP2  SE046              1     0
    ##  6 Hydrogenobacter sp. Cluster 1 Green  KRP2  SE057              1     0
    ##  7 Hydrogenobacter sp. Cluster 1 Green  KRP2B SE055              4     0
    ##  8 Hydrogenobacter sp. Cluster 1 Green  KRP2B SE058             14     0
    ##  9 Hydrogenobacter sp. Cluster 2 Blue   KRP1  SE046              3     0
    ## 10 Hydrogenobacter sp. Cluster 2 Orange KRP1  SE058             66     1
    ## 11 Hydrogenobacter sp. Cluster 2 Orange KRP2  SE046             14     0
    ## 12 Hydrogenobacter sp. Cluster 2 Orange KRP2  SE058             24     0
    ## 13 Sulfurihydrogenibium sp.             KRP1  SE055             11     0
    ## 14 Sulfurihydrogenibium sp.             KRP1  SE057              8     0
    ## 15 Sulfurihydrogenibium sp.             KRP2  SE053              1     0
    ## 16 Sulfurihydrogenibium sp.             KRP2B SE055              4     0
    ## 17 Sulfurihydrogenibium sp.             KRP2B SE057             16     0
    ## 18 Venenivibrio sp.                     KRP1  SE058              3     0

The result shows 18 lines. However, we can see that not all sites and
Timepoint are present in the dataset. For example, there are no entries
for **SE046** in the **Green** population. We can use the `complete()`
function to fill in these missing combinations with `0` counts.

    virsorter_complete <- virsorter_data_recode %>%
        group_by(Population, Phage_Type, Site, Timepoint) %>%
        summarise(Count = n()) %>%
        ungroup() %>%
        complete(Population, Phage_Type, Site, Timepoint, fill = list(Count = 0)) %>%
        pivot_wider(names_from = Phage_Type, values_from = Count, values_fill = 0)
    head(virsorter_complete, n = 20)

    ## # A tibble: 20 × 5
    ##    Population                          Site  Timepoint dsDNAphage ssDNA
    ##    <chr>                               <chr> <chr>          <int> <int>
    ##  1 H. thermophilus                     KRP1  SE046              0     0
    ##  2 H. thermophilus                     KRP1  SE053              0     0
    ##  3 H. thermophilus                     KRP1  SE055              0     0
    ##  4 H. thermophilus                     KRP1  SE057              6     0
    ##  5 H. thermophilus                     KRP1  SE058              0     0
    ##  6 H. thermophilus                     KRP2  SE046              0     0
    ##  7 H. thermophilus                     KRP2  SE053              0     0
    ##  8 H. thermophilus                     KRP2  SE055              0     0
    ##  9 H. thermophilus                     KRP2  SE057              0     0
    ## 10 H. thermophilus                     KRP2  SE058              0     0
    ## 11 H. thermophilus                     KRP2B SE046              0     0
    ## 12 H. thermophilus                     KRP2B SE053              0     0
    ## 13 H. thermophilus                     KRP2B SE055              0     0
    ## 14 H. thermophilus                     KRP2B SE057              0     0
    ## 15 H. thermophilus                     KRP2B SE058              0     0
    ## 16 Hydrogenobacter sp. Cluster 1 Green KRP1  SE046              1     0
    ## 17 Hydrogenobacter sp. Cluster 1 Green KRP1  SE053              0     0
    ## 18 Hydrogenobacter sp. Cluster 1 Green KRP1  SE055              2     0
    ## 19 Hydrogenobacter sp. Cluster 1 Green KRP1  SE057              0     0
    ## 20 Hydrogenobacter sp. Cluster 1 Green KRP1  SE058             19     0

The complete dataset now has 90 rows, with all combinations of
Population, Phage\_Type, Site, and Timepoint represented. The missing
combinations have been filled with `0` counts.

The `complete()` function is particularly useful when you want to ensure
that your dataset is fully populated with all possible combinations of
variables, which can be important for certain types of analyses or
visualizations.

------------------------------------------------------------------------

# Visualizing Data with `ggplot2`

The `ggplot2` package is a powerful and flexible system for creating
static graphics in R. It is part of the tidyverse and is designed to
work seamlessly with tidy data.

## Example Visualization: Bar Plot of Viral Types by Population

We can create a bar plot to visualize the distribution of viral types by
population using `ggplot2`. The `geom_bar()` function is used to create
bar plots, and we can use the `fill` aesthetic to color the bars by
viral type.

    virsorter_input <- virsorter_summary %>%
        ungroup() %>%
        complete(Population, Phage_Type, fill = list(Count = 0))
    head(virsorter_input)

    ## # A tibble: 6 × 3
    ##   Population                          Phage_Type Count
    ##   <chr>                               <chr>      <int>
    ## 1 H. thermophilus                     dsDNAphage     6
    ## 2 H. thermophilus                     ssDNA          0
    ## 3 Hydrogenobacter sp. Cluster 1 Green dsDNAphage    42
    ## 4 Hydrogenobacter sp. Cluster 1 Green ssDNA          0
    ## 5 Hydrogenobacter sp. Cluster 2 Blue  dsDNAphage     3
    ## 6 Hydrogenobacter sp. Cluster 2 Blue  ssDNA          0

Plot the data using `ggplot2`:

    plot1 <- ggplot(virsorter_input) +
      geom_bar(aes( x = Population, 
                    y = Count, 
                    fill = Phage_Type
                    ),
                    stat = "identity",
                    position = "dodge"
            ) +
      labs(title = "Distribution of Viral Types by Population",
           x = "Population",
           y = "Count") +
      theme_minimal()
    plot1

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot1.png"
alt="Plot1" />
<figcaption aria-hidden="true">Plot1</figcaption>
</figure>

------------------------------------------------------------------------

## Plot Geom Objects

Let us make a time series from our virsorter dataset.

First, let us re-analyse it so that viral count is show by timepoint and
population.

    virsorter_time_series <- virsorter_data_recode %>%
      group_by(Population, Timepoint, Phage_Type) %>%
      summarise(Count = n(), .groups = 'drop') %>%
      arrange(Population, Timepoint, Phage_Type) %>%
      ungroup() %>%
      mutate(Timepoint = recode(Timepoint, 
             SE046 = 1,
             SE053 = 2,
             SE055 = 3,
             SE056 = 4,
             SE057 = 5,
             SE058 = 6,
             )
      ) %>%
      complete(Population, Timepoint, Phage_Type, fill = list(Count = 0)) 
    virsorter_time_series

    ## # A tibble: 60 × 4
    ##    Population      Timepoint Phage_Type Count
    ##    <chr>               <dbl> <chr>      <int>
    ##  1 H. thermophilus         1 dsDNAphage     0
    ##  2 H. thermophilus         1 ssDNA          0
    ##  3 H. thermophilus         2 dsDNAphage     0
    ##  4 H. thermophilus         2 ssDNA          0
    ##  5 H. thermophilus         3 dsDNAphage     0
    ##  6 H. thermophilus         3 ssDNA          0
    ##  7 H. thermophilus         5 dsDNAphage     6
    ##  8 H. thermophilus         5 ssDNA          0
    ##  9 H. thermophilus         6 dsDNAphage     0
    ## 10 H. thermophilus         6 ssDNA          0
    ## # ℹ 50 more rows

Let us plot the time series data using `ggplot2`. We will use
`geom_line()` to create a line plot and `geom_point()` to add points for
each timepoint.

    virsorter_time_series_orange <- virsorter_time_series %>%
      filter(Population == "Hydrogenobacter sp. Cluster 2 Orange")

    plot2 <- ggplot(virsorter_time_series_orange, aes(x = Timepoint, y = Count, color = Phage_Type)) +
      geom_line(aes(group = Phage_Type), linewidth = 1) +
      geom_point(size = 3) +
      labs(title = "Viral Types Over Time by Population",
           x = "Timepoint",
           y = "Count") +
      scale_x_continuous(breaks = 1:6, labels = c("SE046", "SE053", "SE055", "SE056", "SE057", "SE058")) +
      theme_minimal() +
      theme(legend.position = "bottom")
    #plot2

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot2.png"
alt="Plot2" />
<figcaption aria-hidden="true">Plot2</figcaption>
</figure>

We filter the dataset to only include the **Hydrogenobacter sp. Cluster
2 Orange** population. The `geom_line()` function is used to create
lines connecting the points for each viral type, and `geom_point()` adds
points at each timepoint.

------------------------------------------------------------------------

## Plotting with `facet_wrap()`

We can also use `facet_wrap()` to create separate plots for each
population. This allows us to visualize the distribution of viral types
within each population.

    plot3 <- ggplot(virsorter_time_series, aes(x = Timepoint, y = Count, color = Phage_Type)) +
      geom_line(aes(group = Phage_Type), linewidth = 1) +
      geom_point(size = 3) +
      labs(title = "Viral Types Over Time by Population",
           x = "Timepoint",
           y = "Count") +
      scale_x_continuous(breaks = 1:6, labels = c("SE046", "SE053", "SE055", "SE056", "SE057", "SE058")) +
      theme_minimal() +
      theme(legend.position = "bottom") +
      facet_wrap(~ Population)

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot3.png"
alt="Plot3" />
<figcaption aria-hidden="true">Plot3</figcaption>
</figure>

If you want to see the non-facet\_wrap version, you can use the
`facet_null()` function to remove the facets.

    plot4 <- ggplot(virsorter_time_series, aes(x = Timepoint, y = Count, color = Phage_Type)) +
      geom_line(aes(group = Phage_Type), linewidth = 1) +
      geom_point(size = 3) +
      labs(title = "Viral Types Over Time by Population",
           x = "Timepoint",
           y = "Count") +
      scale_x_continuous(breaks = 1:6, labels = c("SE046", "SE053", "SE055", "SE056", "SE057", "SE058")) +
      theme_minimal() +
      theme(legend.position = "bottom") 

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot4.png"
alt="Plot4" />
<figcaption aria-hidden="true">Plot4</figcaption>
</figure>

------------------------------------------------------------------------

## Changing the Color Palette

We can customize the color palette of our plot using the
`scale_color_manual()` function. This allows us to specify the colors
for each viral type.

    plot5 <- ggplot(virsorter_time_series, aes(x = Timepoint, y = Count, color = Phage_Type)) +
      geom_line(aes(group = Phage_Type), linewidth = 1) +
      geom_point(size = 3) +
      labs(title = "Viral Types Over Time by Population",
           x = "Timepoint",
           y = "Count") +
      scale_x_continuous(breaks = 1:6, labels = c("SE046", "SE053", "SE055", "SE056", "SE057", "SE058")) +
      scale_color_manual(values = c("dsDNAphage" = "#FF5733", "ssDNA" = "#33FF57")) +
      theme_minimal() +
      theme(legend.position = "bottom") +
      facet_wrap(~ Population)

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot5.png"
alt="Plot5" />
<figcaption aria-hidden="true">Plot5</figcaption>
</figure>

Let us try the Wes Anderson color palette from the `wesanderson`
package. This package provides a set of aesthetically pleasing color
palettes inspired by the films of Wes Anderson.

    library(wesanderson) # Install the package if you haven't already

    plot6 <- ggplot(virsorter_time_series, aes(x = Timepoint, y = Count, color = Phage_Type)) +
      geom_line(aes(group = Phage_Type), linewidth = 1) +
      geom_point(size = 3) +
      labs(title = "Viral Types Over Time by Population",
           x = "Timepoint",
           y = "Count") +
      scale_x_continuous(breaks = 1:6, labels = c("SE046", "SE053", "SE055", "SE056", "SE057", "SE058")) +
      scale_color_manual(values = wes_palette("GrandBudapest1",2)) + # Use a Wes Anderson color palette
      theme_minimal() +
      theme(legend.position = "bottom") +
      facet_wrap(~ Population)

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot6.png"
alt="Plot6" />
<figcaption aria-hidden="true">Plot6</figcaption>
</figure>

------------------------------------------------------------------------

## The Themes of `ggplot2`

You can customize the appearance of your plots using themes in
`ggplot2`. The `theme_minimal()` function is one of the built-in themes
that provides a clean and minimalistic look. You can also create your
own custom themes or use other built-in themes like `theme_bw()`,
`theme_classic()`, etc.

    plot7 <- ggplot(virsorter_time_series, aes(x = Timepoint, y = Count, color = Phage_Type)) +
      geom_line(aes(group = Phage_Type), linewidth = 1) +
      geom_point(size = 3) +
      labs(title = "Viral Types Over Time by Population",
           x = "Timepoint",
           y = "Count") +
      scale_x_continuous(breaks = 1:6, labels = c("SE046", "SE053", "SE055", "SE056", "SE057", "SE058")) +
      scale_color_manual(values = wes_palette("GrandBudapest1",2)) + # Use a Wes Anderson color palette
      theme_minimal() + # Use a minimal theme
      theme(legend.position = "bottom",
            axis.title.x = element_text(size = 16, face = "bold"),
            axis.title.y = element_text(size = 15, face = "bold"),
            strip.text.x = element_text(size = 15, face = "bold"),
            plot.title = element_text(size = 18, face = "bold", hjust = 0.5)
            ) +
      facet_wrap(~ Population)

<figure>
<img
src="https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/img/plot7.png"
alt="Plot7" />
<figcaption aria-hidden="true">Plot7</figcaption>
</figure>

Other themes can be applied to the plot using the `theme()` function.
You can customize various aspects of the plot, such as axis labels,
titles, and legend positions.

Other important theme arguments include: \## Important `theme()`
Arguments in ggplot2

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 40%" />
<col style="width: 38%" />
</colgroup>
<thead>
<tr class="header">
<th>Argument</th>
<th>What it Controls</th>
<th>Example Usage</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>legend.position</code></td>
<td>Position of the legend (<code>"right"</code>, <code>"bottom"</code>,
<code>"left"</code>, <code>"top"</code>, or <code>"none"</code>)</td>
<td><code>theme(legend.position = "bottom")</code></td>
</tr>
<tr class="even">
<td><code>axis.title.x</code></td>
<td>X-axis title appearance</td>
<td><code>theme(axis.title.x = element_text(size = 14))</code></td>
</tr>
<tr class="odd">
<td><code>axis.title.y</code></td>
<td>Y-axis title appearance</td>
<td><code>theme(axis.title.y = element_text(size = 14))</code></td>
</tr>
<tr class="even">
<td><code>axis.text.x</code></td>
<td>X-axis tick labels</td>
<td><code>theme(axis.text.x = element_text(angle = 45))</code></td>
</tr>
<tr class="odd">
<td><code>axis.text.y</code></td>
<td>Y-axis tick labels</td>
<td><code>theme(axis.text.y = element_text(size = 12))</code></td>
</tr>
<tr class="even">
<td><code>plot.title</code></td>
<td>Plot title appearance</td>
<td><code>theme(plot.title = element_text(hjust = 0.5))</code></td>
</tr>
<tr class="odd">
<td><code>strip.text.x</code></td>
<td>Facet label appearance (x)</td>
<td><code>theme(strip.text.x = element_text(size = 12))</code></td>
</tr>
<tr class="even">
<td><code>strip.text.y</code></td>
<td>Facet label appearance (y)</td>
<td><code>theme(strip.text.y = element_text(face = "bold"))</code></td>
</tr>
<tr class="odd">
<td><code>panel.grid.major</code></td>
<td>Major grid lines</td>
<td><code>theme(panel.grid.major = element_blank())</code></td>
</tr>
<tr class="even">
<td><code>panel.grid.minor</code></td>
<td>Minor grid lines</td>
<td><code>theme(panel.grid.minor = element_blank())</code></td>
</tr>
<tr class="odd">
<td><code>panel.background</code></td>
<td>Plot panel background</td>
<td><code>theme(panel.background = element_rect(fill = "white"))</code></td>
</tr>
<tr class="even">
<td><code>plot.background</code></td>
<td>Entire plot background</td>
<td><code>theme(plot.background = element_rect(fill = "gray90"))</code></td>
</tr>
<tr class="odd">
<td><code>legend.title</code></td>
<td>Legend title appearance</td>
<td><code>theme(legend.title = element_text(face = "bold"))</code></td>
</tr>
<tr class="even">
<td><code>legend.text</code></td>
<td>Legend text appearance</td>
<td><code>theme(legend.text = element_text(size = 10))</code></td>
</tr>
</tbody>
</table>

These arguments allow you to control the appearance of almost every
aspect of your ggplot2 visualizations.

# Summary Table: Key Data Tidying Functions

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 40%" />
<col style="width: 46%" />
</colgroup>
<thead>
<tr class="header">
<th>Function</th>
<th>Purpose</th>
<th>Example Usage</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>read_csv()</code></td>
<td>Read CSV files, skip columns</td>
<td><code>read_csv("file.csv", col_types = cols(...1 = col_skip()))</code></td>
</tr>
<tr class="even">
<td><code>separate()</code></td>
<td>Split one column into multiple columns</td>
<td><code>separate(df, col, into = c("A", "B"), sep = "_")</code></td>
</tr>
<tr class="odd">
<td><code>unite()</code></td>
<td>Combine multiple columns into one</td>
<td><code>unite(df, "new_col", A, B, sep = "_")</code></td>
</tr>
<tr class="even">
<td><code>mutate()</code></td>
<td>Create or modify columns</td>
<td><code>mutate(df, new_col = old_col * 2)</code></td>
</tr>
<tr class="odd">
<td><code>str_extract()</code></td>
<td>Extract patterns from strings</td>
<td><code>mutate(df, col2 = str_extract(col1, "pattern"))</code></td>
</tr>
<tr class="even">
<td><code>recode()</code></td>
<td>Replace specific values in a column</td>
<td><code>mutate(df, col = recode(col, old = "new"))</code></td>
</tr>
<tr class="odd">
<td><code>group_by()</code></td>
<td>Group data for summary operations</td>
<td><code>group_by(df, col)</code></td>
</tr>
<tr class="even">
<td><code>summarise()</code></td>
<td>Summarize data (e.g., count, mean)</td>
<td><code>summarise(df, n = n())</code></td>
</tr>
<tr class="odd">
<td><code>pivot_wider()</code></td>
<td>Convert long data to wide format</td>
<td><code>pivot_wider(df, names_from, values_from)</code></td>
</tr>
<tr class="even">
<td><code>pivot_longer()</code></td>
<td>Convert wide data to long format</td>
<td><code>pivot_longer(df, cols, names_to, values_to)</code></td>
</tr>
<tr class="odd">
<td><code>replace_na()</code></td>
<td>Replace missing values</td>
<td><code>mutate(df, col = replace_na(col, 0))</code></td>
</tr>
<tr class="even">
<td><code>expand()</code></td>
<td>Create all combinations of variables</td>
<td><code>expand(df, col1, col2)</code></td>
</tr>
<tr class="odd">
<td><code>complete()</code></td>
<td>Fill in missing combinations of variables</td>
<td><code>complete(df, col1, col2, fill = list(count = 0))</code></td>
</tr>
</tbody>
</table>
