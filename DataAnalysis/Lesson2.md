---
title: Lesson 2 - Intro to Tidyverse and dplyr
parent: Data Wrangling with R
nav_order: 2
---

# Introduction to Tidyverse: dplyr

## 🧹 What is the Tidyverse?

The **tidyverse** is a collection of R packages designed for data
science. All tidyverse packages share an underlying design philosophy,
grammar, and data structures.

This loads several core packages:
-   **ggplot2** (data visualization)
-   **dplyr** (data manipulation)
-   **tidyr** (tidy data formatting)
-   **readr** (reading rectangular data)
-   **purrr** (functional programming tools)
-   **tibble** (modern data frames)

<img src="https://dplyr.tidyverse.org/logo.png" width="200" height="200"
alt="dplyr" /><img src="https://ggplot2.tidyverse.org/logo.png" width="200"
height="200" alt="ggplot2" /><img src="https://tidyr.tidyverse.org/logo.png" width="200" height="200"
alt="tidyr" />
<img src="https://readr.tidyverse.org/logo.png" width="200" height="200"
alt="readr" /><img src="https://purrr.tidyverse.org/logo.png" width="200" height="200"
alt="purrr" /><img src="https://tibble.tidyverse.org/logo.svg" width="200"
height="200" alt="tibble" />

## 🧠 The Tidyverse Philosophy

The tidyverse promotes a consistent and intuitive approach to data analysis in R. It emphasizes: 
- **Human readability**: Code is designedto be easy to read and understand. 
  - **Consistent syntax**: Functions across packages share similar naming conventions and arguments, reducing the learning curve. 
  - **Tidy data**: Data is structured in a way that makes it easy to manipulate and visualize. 
- **Shared Grammar and Data Structures**: Many tidyverse packages use the same data structures (like
tibbles) and share a common grammar, making it easier to switch between them. 
- **Pipes (`%>%`)**: A way to chain commands together, making code more readable. 
- **Verbs**: Functions are often named after the action they perform, such as `filter()`, `select()`, and `mutate()`, making it clear what each function does. 
- **tibbles**: A modern take on data frames that provides better printing and subsetting behavior. More predictable behavior (e.g., no automatic type conversion).

Here’s a simple example of how the tidyverse philosophy is applied in
practice:

{:.activity}
>```
>    mtcars %>%                          # Load the mtcars dataset and pipe
>      as_tibble() %>%                   # Tibble package: convert it to a tibble for better printing 
>      filter(mpg > 20) %>%              # dplyr package: filter rows where mpg is greater than 20 
>      mutate(kpl = mpg * 0.425144) %>%  # dplyr package: create a new column kpl (km per liter)
>      ggplot(aes(x = wt, y = kpl)) +    # ggplot2 package: Create a ggplot using previous lines as input
>      geom_point()                      # ggplot2 package: add points to the plot
>```


## ⌨️ Installation

To use the tidyverse, you first need to install it. You can do this from
CRAN using the following command:

{:.activity}
>```r
>install.packages("tidyverse")
>```

To use the tidyverse, we load the main package:

{:.activity}
>```r
>    library(tidyverse)
>```

    ## ── Attaching core tidyverse packages ─────────────────────────────────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.2     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.4     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.4     
    ## ── Conflicts ───────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors


{:.note} 
>This is also the basic way to install and load packages in R.

# 📟 Data Manipulation with `dplyr`

`dplyr` is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges. It uses vectorized operations to make data manipulation fast andefficient. The main verbs in `dplyr` are: 
- **`select()`**: Choosespecific columns from a data frame. 
- **`filter()`**: Subset rows based on conditions. 
- **`mutate()`**: Create new variables or modify existing ones. 
- **`summarise()`**: Reduce data to summary statistics. 
- **`group_by()`**: Group data by one or more variables for subsequent operations.

## Example Dataset

We will use the built-in `mtcars` dataset for demonstration. The `mtcars` dataset contains specifications and performance measurements of various car models from the 1970s. It includes variables such as miles per gallon (mpg), number of cylinders (cyl), horsepower (hp), weight (wt), and more.

{:.activity}
>```r
>    head(mtcars)
>```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

The `mtcars` dataset is a data frame with 32 rows and 11 columns, where each row represents a different car model and each column represents a different attribute of the car.

------------------------------------------------------------------------

## Select columns

If we need to subset the dataset to only include specific columns, we can use the `select()` function from `dplyr`. This is useful for focusing on relevant variables for analysis.

{:.activity}
>```r
>    mtcars %>% select(mpg, cyl, hp) %>% head()
>```

    ##                    mpg cyl  hp
    ## Mazda RX4         21.0   6 110
    ## Mazda RX4 Wag     21.0   6 110
    ## Datsun 710        22.8   4  93
    ## Hornet 4 Drive    21.4   6 110
    ## Hornet Sportabout 18.7   8 175
    ## Valiant           18.1   6 105

    mtcars %>% select(c(mpg, cyl, hp)) %>% head()

    ##                    mpg cyl  hp
    ## Mazda RX4         21.0   6 110
    ## Mazda RX4 Wag     21.0   6 110
    ## Datsun 710        22.8   4  93
    ## Hornet 4 Drive    21.4   6 110
    ## Hornet Sportabout 18.7   8 175
    ## Valiant           18.1   6 105

{:.notice} 
> The input for `select()` can be a vector of column
names. You can use the `c()` function to combine multiple column names,
or list them directly within `select()`. 
> 
> Additionally, you can
use helper functions like `starts_with()`, `ends_with()`, `contains()`,
etc. More of this later.

------------------------------------------------------------------------

## Filter rows

Now, the power of `dplyr` shines with the `filter()` function, which
allows us to subset rows based on conditions. This is particularly
useful for focusing on specific groups or values within the dataset.

{:.activity}
>```r
>    mtcars %>% filter(cyl > 5) %>% head()
>```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360        14.3   8  360 245 3.21 3.570 15.84  0  0    3    4

Additionally, we can combine multiple conditions using logical operators
like `&` (and) and `|` (or):

{:.activity}
>```r
>    mtcars %>% filter(cyl > 5 & hp > 100) %>% head()
>```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360        14.3   8  360 245 3.21 3.570 15.84  0  0    3    4

We can combine `filter` command with pattern matching such as `grepl()`
or `str_detect()` from the `stringr` package.

{:.activity}
>```r
>    # filter rows that is the model name contains "Mazda"
>    mtcars %>% filter(grepl("Mazda", rownames(mtcars)))
>```

    ##               mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4      21   6  160 110  3.9 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag  21   6  160 110  3.9 2.875 17.02  0  1    4    4

{:.activity}
>```r
>    # You can also filter by removing rows that match a pattern. 
>    # Let us remove cars with the make "Hornet"
>    mtcars %>% filter(!grepl("Hornet", rownames(mtcars)))
>```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

------------------------------------------------------------------------

## Joining datasets

Joining datasets is a common operation in data analysis, especially when you have related data spread across multiple tables. `dplyr` provides several functions for joining datasets, such as `inner_join()`, `left_join()`, `right_join()`, and `full_join()`.

{:.activity}
>```r
>    # Create a second dataset with car models and their origins
>    car_origins <- tibble(
>      model = c("Mazda RX4", "Mazda RX4 Wag", "Datsun 710", "Hornet 4 Drive", "Hornet Sportabout"),
>      origin = c("Japan", "Japan", "Japan", "USA", "USA")
>    )
>    head(car_origins)
>```

    ## # A tibble: 5 × 2
    ##   model             origin
    ##   <chr>             <chr> 
    ## 1 Mazda RX4         Japan 
    ## 2 Mazda RX4 Wag     Japan 
    ## 3 Datsun 710        Japan 
    ## 4 Hornet 4 Drive    USA   
    ## 5 Hornet Sportabout USA

{:.activity}
>```r
>    # Perform an inner join to combine the two datasets
>    mtcars_with_origins <- mtcars %>%
>      rownames_to_column(var = "model") %>%  # Convert row names to a column
>      inner_join(car_origins, by = "model")   # Join by the model column
>    head(mtcars_with_origins)
>```

    ##               model  mpg cyl disp  hp drat    wt  qsec vs am gear carb origin
    ## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4  Japan
    ## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4  Japan
    ## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1  Japan
    ## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1    USA
    ## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2    USA

{:.activity}
>```r
>    # Perform a left join to combine the two datasets
>    mtcars_with_origins_left <- mtcars %>%
>      rownames_to_column(var = "model") %>%   # Convert row names to a column
>      left_join(car_origins, by = "model")    # Join by the model column
>    head(mtcars_with_origins_left)
>```

    ##               model  mpg cyl disp  hp drat    wt  qsec vs am gear carb origin
    ## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4  Japan
    ## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4  Japan
    ## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1  Japan
    ## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1    USA
    ## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2    USA
    ## 6           Valiant 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1   <NA>

{:.activity}
>```r
>    # Perform a right join to combine the two datasets
>    mtcars_with_origins_right <- mtcars %>%
>      rownames_to_column(var = "model") %>%   # Convert row names to a column
>      right_join(car_origins, by = "model")   # Join by the model column
>    head(mtcars_with_origins_right)
>```

    ##               model  mpg cyl disp  hp drat    wt  qsec vs am gear carb origin
    ## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4  Japan
    ## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4  Japan
    ## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1  Japan
    ## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1    USA
    ## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2    USA

{:.activity}
>```r
>    # Perform a full join to combine the two datasets
>    mtcars_with_origins_full <- mtcars %>%
>      rownames_to_column(var = "model") %>%   # Convert row names to a column
>      full_join(car_origins, by = "model")    # Join by the model column
>    head(mtcars_with_origins_full)
>```

    ##               model  mpg cyl disp  hp drat    wt  qsec vs am gear carb origin
    ## 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4  Japan
    ## 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4  Japan
    ## 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1  Japan
    ## 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1    USA
    ## 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2    USA
    ## 6           Valiant 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1   <NA>

The `inner_join()` function returns only the rows that have matching values in both datasets, while `left_join()` returns all rows from the left dataset and the matching rows from the right dataset. The `right_join()` does the opposite, returning all rows from the right dataset and the matching rows from the left dataset. The `full_join()` returns all rows from both datasets, filling in `NA` for missing values.

{:.note} 
>The `inner_join()`, `left_join()`, `right_join()`, and `full_join()` functions are used to combine datasets based on a common column. The `by` argument specifies the column(s) to join on. If the column names are different in the two datasets, you can use `by = c("col1" = "col2")` to specify the columns to join on.

------------------------------------------------------------------------

<br>

# 🧬 A Bioinformatics Example with `dplyr`

Let us use a Bioinformatics example to illustrate the use of `dplyr` for data manipulation.

For the next segment of this lesson, let us use some Bioinformatics data generated from from the analysis of abundance of different genomes in a metagenomic dataset, as measured using **[sourmash](https://sourmash.readthedocs.io/en/latest/index.html)**.

To download the data, run the following code:

{:.activity}
```bash
    wget https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/sourmash/krona_files/TP3-KRP1_v_gtdb-all.krona.csv.krona.tsv
    wget https://raw.githubusercontent.com/gamalielcabria/gamalielcabria.github.io/main/DataAnalysis/files/sourmash/krona_files/TP3-KRP2_v_gtdb-all.krona.csv.krona.tsv
```

{:.highlight} 
>The TP3-KRP1\_v\_gtdb-all.krona.csv.krona.tsv and TP3-KRP2\_v\_gtdb-all.krona.csv.krona.tsv files are tab-separated files that contain the abundance of Aquificales genomes in two different samples (TP3-KRP1 and TP3-KRP2) against a reference database (gtdb-all).
>
>**TP3-KRP1** in the name denotes the time point it was collected (TP3) and the sample it was collected from (KRP1). The same applies to **TP3-KRP2**.

{:.activity}
>```r
>    # Load the data
>    TP3_KRP1 <- read_tsv("./TP3-KRP1_v_gtdb-all.krona.csv.krona.tsv")
>    TP3_KRP2 <- read_tsv("./TP3-KRP2_v_gtdb-all.krona.csv.krona.tsv")
>    # Display the first few rows of the data
>    head(TP3_KRP1)
>```

    ## # A tibble: 6 × 8
    ##   fraction superkingdom phylum            class       order family genus species
    ##      <dbl> <chr>        <chr>             <chr>       <chr> <chr>  <chr> <chr>  
    ## 1  0.0106  d__Bacteria  p__Bacteroidota   c__Bactero… o__F… f__We… g__E… s__Eli…
    ## 2  0.0105  d__Bacteria  p__Pseudomonadota c__Gammapr… o__E… f__En… g__C… s__Cit…
    ## 3  0.00905 d__Bacteria  p__Pseudomonadota c__Gammapr… o__E… f__En… g__L… s__Lec…
    ## 4  0.00576 d__Bacteria  p__Pseudomonadota c__Gammapr… o__E… f__En… g__U… s__UBA…
    ## 5  0.00414 d__Bacteria  p__Deinococcota   c__Deinoco… o__D… f__Th… g__T… s__The…
    ## 6  0.00349 d__Bacteria  p__Actinomycetota c__Actinom… o__M… f__Mi… g__M… s__Mic…

{:.note} 
> The data contains the following columns: 
> - **fraction**: The computed fraction of the representative genome in the metagenomic sample. 
> - **Taxonomic columns**: From Superkingdom to Species, representing the assigned taxonomic classification of the representative genome used in the `sourmash` analysis. This sample uses genomes from the **GTDB** database.

The goal of this section is to manipulate the two datasets to compare
the abundance of select genomes between the two samples (TP3-KRP1 and
TP3-KRP2).

------------------------------------------------------------------------

## Mutate and create new columns

Given we downloaded two samples with similar structures, we need to have a column that differentiates the two samples. We can use the `mutate()` function to create a new column that indicates the sample name for each dataset.

{:.activity}
>```r
>    TP3_KRP1 <- TP3_KRP1 %>%        # Pipe the TP3_KRP1 data to itself so modifications are made in place
>      mutate(sample = "TP3-KRP1")   # Create a new column called sample with the value "TP3-KRP1"
>
>    head(TP3_KRP1)
>```

    ## # A tibble: 6 × 9
    ##   fraction superkingdom phylum           class order family genus species sample
    ##      <dbl> <chr>        <chr>            <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1  0.0106  d__Bacteria  p__Bacteroidota  c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 2  0.0105  d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 3  0.00905 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 4  0.00576 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5  0.00414 d__Bacteria  p__Deinococcota  c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6  0.00349 d__Bacteria  p__Actinomyceto… c__A… o__M… f__Mi… g__M… s__Mic… TP3-K…

The new column `sample` now contains the sample name for each row in the `TP3_KRP1` dataset. We can do the same for the `TP3_KRP2` dataset:

{:.activity}
>```r
>    TP3_KRP2 <- TP3_KRP2 %>%        # Pipe the TP3_KRP2 data to itself so modifications are made in place
>      mutate(sample = "TP3-KRP2")   # Create a new column called sample with the value "TP3-KRP2"
>
>    head(TP3_KRP2)
>```

    ## # A tibble: 6 × 9
    ##   fraction superkingdom phylum           class order family genus species sample
    ##      <dbl> <chr>        <chr>            <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1  0.00961 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 2  0.00851 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 3  0.00801 d__Bacteria  p__Bacteroidota  c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 4  0.00526 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5  0.00443 d__Bacteria  p__Deinococcota  c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6  0.00373 d__Bacteria  p__Thermotogota  c__T… o__T… f__Fe… g__F… s__Fer… TP3-K…

{:.note} 
> Naming column schemes in **R** is flexible, but it is a good practice to use descriptive names that reflect the content of the column. In this case, we named the new column `sample` to indicate that it contains the sample name. 
> 
>**Columns and variables** in R can be named using *letters*, *numbers*, and *underscores*, but they cannot start with a number or contain spaces.

As you can see, the new column is added into the end of the data frame.

------------------------------------------------------------------------

## Mutate and vectorize operations

We can also use `mutate()` to modify the values in existing columns.

The fraction column in datasets represents the literal **decimal fraction** of the abundance of the representative genome in the sample. To convert this to a percentage, we can multiply the values in the `fraction` column by 100.

{:.activity}
>```r
>    TP3_KRP1 <- TP3_KRP1 %>% 
>      mutate(fraction = fraction * 100)         # Convert fraction to percentage
>    head(TP3_KRP1)
>```

    ## # A tibble: 6 × 9
    ##   fraction superkingdom phylum           class order family genus species sample
    ##      <dbl> <chr>        <chr>            <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1    1.06  d__Bacteria  p__Bacteroidota  c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 2    1.05  d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 3    0.905 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 4    0.576 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5    0.414 d__Bacteria  p__Deinococcota  c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6    0.349 d__Bacteria  p__Actinomyceto… c__A… o__M… f__Mi… g__M… s__Mic… TP3-K…

{:.activity}
>```r
>    TP3_KRP2 <- TP3_KRP2 %>%
>      mutate(fraction = fraction * 100)         # Convert fraction to percentage
>    head(TP3_KRP2)
>```

    ## # A tibble: 6 × 9
    ##   fraction superkingdom phylum           class order family genus species sample
    ##      <dbl> <chr>        <chr>            <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1    0.961 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 2    0.851 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 3    0.801 d__Bacteria  p__Bacteroidota  c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 4    0.526 d__Bacteria  p__Pseudomonado… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5    0.443 d__Bacteria  p__Deinococcota  c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6    0.373 d__Bacteria  p__Thermotogota  c__T… o__T… f__Fe… g__F… s__Fer… TP3-K…

{:.highlight} 
> The `mutate()` function is vectorized, meaning it applies the operation to each element in the `fraction` column. Again, this is a powerful feature of R that allows for efficient data manipulation without the need for explicit loops.

------------------------------------------------------------------------

## Renaming columns

We can use `rename()` to rename columns. For example, we can rename the `fraction` column to `percent_abundance` to make it more descriptive.

{:.activity}
>```r
>    TP3_KRP1 <- TP3_KRP1 %>% 
>      rename(percent_abundance = fraction,      # Rename fraction to percent_abundance
>             domain = superkingdom              # Rename Superkingdom to Domain
>            )  
>    head(TP3_KRP1)
>```

    ## # A tibble: 6 × 9
    ##   percent_abundance domain      phylum   class order family genus species sample
    ##               <dbl> <chr>       <chr>    <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1             1.06  d__Bacteria p__Bact… c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 2             1.05  d__Bacteria p__Pseu… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 3             0.905 d__Bacteria p__Pseu… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 4             0.576 d__Bacteria p__Pseu… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5             0.414 d__Bacteria p__Dein… c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6             0.349 d__Bacteria p__Acti… c__A… o__M… f__Mi… g__M… s__Mic… TP3-K…

{:.activity}
>```r
>    TP3_KRP2 <- TP3_KRP2 %>%
>      rename(percent_abundance = fraction) %>%  # Rename fraction to percent_abundance
>      rename(domain = superkingdom)             # Rename Superkingdom to Domain
>    head(TP3_KRP2)
>```

    ## # A tibble: 6 × 9
    ##   percent_abundance domain      phylum   class order family genus species sample
    ##               <dbl> <chr>       <chr>    <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1             0.961 d__Bacteria p__Pseu… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 2             0.851 d__Bacteria p__Pseu… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 3             0.801 d__Bacteria p__Bact… c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 4             0.526 d__Bacteria p__Pseu… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5             0.443 d__Bacteria p__Dein… c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6             0.373 d__Bacteria p__Ther… c__T… o__T… f__Fe… g__F… s__Fer… TP3-K…

------------------------------------------------------------------------

## Combining columns

Now, both datasets have a `sample` column that indicates which sample the data belongs to. We can combine the two datasets into one for easier comparison.

{:.activity}
>```r
>    # Combine the two datasets into one
>    combined_data <- bind_rows(TP3_KRP1, TP3_KRP2)
>    # Display the first few rows of the combined data
>    head(combined_data)
>```

    ## # A tibble: 6 × 9
    ##   percent_abundance domain      phylum   class order family genus species sample
    ##               <dbl> <chr>       <chr>    <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1             1.06  d__Bacteria p__Bact… c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 2             1.05  d__Bacteria p__Pseu… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 3             0.905 d__Bacteria p__Pseu… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 4             0.576 d__Bacteria p__Pseu… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5             0.414 d__Bacteria p__Dein… c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6             0.349 d__Bacteria p__Acti… c__A… o__M… f__Mi… g__M… s__Mic… TP3-K…

{:.activity}
>```r
>    # Base R combine the two datasets into one
>    combined_data_base <- rbind(TP3_KRP1, TP3_KRP2)
>    # Display the first few rows of the combined data
>    head(combined_data_base)
>```

    ## # A tibble: 6 × 9
    ##   percent_abundance domain      phylum   class order family genus species sample
    ##               <dbl> <chr>       <chr>    <chr> <chr> <chr>  <chr> <chr>   <chr> 
    ## 1             1.06  d__Bacteria p__Bact… c__B… o__F… f__We… g__E… s__Eli… TP3-K…
    ## 2             1.05  d__Bacteria p__Pseu… c__G… o__E… f__En… g__C… s__Cit… TP3-K…
    ## 3             0.905 d__Bacteria p__Pseu… c__G… o__E… f__En… g__L… s__Lec… TP3-K…
    ## 4             0.576 d__Bacteria p__Pseu… c__G… o__E… f__En… g__U… s__UBA… TP3-K…
    ## 5             0.414 d__Bacteria p__Dein… c__D… o__D… f__Th… g__T… s__The… TP3-K…
    ## 6             0.349 d__Bacteria p__Acti… c__A… o__M… f__Mi… g__M… s__Mic… TP3-K…

{:.note} 
> Both `rbind` and `bind_rows` is useful for combining datasets with the same structure (i.e. number of columns), such as the two samples we have here. 
> 
> The `rbind()` function from base R can also be used to combine datasets, but it requires that the datasets have **the same column names and types**. 
> 
> The `bind_rows()` function is more flexible and can handle **different column names and types**. Missing columns in one dataset will be filled with `NA` in thecombined dataset.

------------------------------------------------------------------------

## Summarize data

One of the most powerful features of `dplyr` is the ability to summarize data using the `summarise()` function. This allows us to compute summary statistics for each group in the dataset. The `summarise()` function is often used in conjunction with `group_by()` to compute statistics for each group.

For example, we can compute the total percent abundance of memberse of the same Phylum per dataset.

{:.activity}
>```r
>    summarised_data <- combined_data %>% 
>      group_by(phylum, sample) %>%          # Group by Domain and sample
>      summarise(mean_percent_abundance = sum(percent_abundance),
>                number_of_taxa = n(),       # Count the number of taxa in each group
>                .groups = 'drop') %>%       # Compute mean percent abundance
>      arrange(phylum, sample)     %>%       # Arrange the results by Domain and sample
>      ungroup()                             # Ungroup the data for further operations
>```

{:.notice} 
> The `sum()` are among the most common functions used in `summarise()`, but you can also use other functions like `mean()`, `median()`, `min()`, `max()`, etc. to compute different summary statistics. 
> The `n()` function is used to count the number of elements counted in each group. This is useful for understanding the number of taxa in each Phylum in each sample. 
> The `arrange()` function is used to sort the results by the `Phylum` and `sample` columns.

{:.activity}
>```r
>    # Display the first few rows of the summarised data
>    head(summarised_data)
>```

    ## # A tibble: 6 × 4
    ##   phylum            sample   mean_percent_abundance number_of_taxa
    ##   <chr>             <chr>                     <dbl>          <int>
    ## 1 p__Actinomycetota TP3-KRP1                 0.823              14
    ## 2 p__Actinomycetota TP3-KRP2                 0.108               6
    ## 3 p__Aquificota     TP3-KRP2                 0.134               2
    ## 4 p__Bacillota      TP3-KRP1                 0.0125              1
    ## 5 p__Bacillota      TP3-KRP2                 0.0614              3
    ## 6 p__Bacillota_A    TP3-KRP1                 0.147               1

As you can see, the summarised data contains only the average percent abundance of each Phylum taxonomic group in each sample and the number of taxa we requested. This allows us to compare the abundance of different taxonomic groups between the two samples.

Additionally, we can also see the column by which they were grouped (`phylum` and `sample`). The other columns in the original dataset are not included in the summarised data, which makes it easier to focus on the relevant information.

{:.save} 
>Always ungroup the data after summarizing it. This is important to avoid unexpected behavior in subsequent operations, as the data will still be grouped by the specified columns if not ungrouped.

{:.note} 
> Summarizing data is useful for understanding the overall trends and makes an easier way to visualize the data. [See the next section for more on visualization](https://gamalielcabria.github.io/DataAnalysis/Lesson2.html).

------------------------------------------------------------------------

<br>

# Summary Table: Key `dplyr` Commands

<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 41%" />
<col style="width: 42%" />
</colgroup>
<thead>
<tr class="header">
<th>Command</th>
<th>Purpose</th>
<th>Example Usage</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>select()</code></td>
<td>Select columns</td>
<td><code>select(mtcars, mpg, cyl)</code></td>
</tr>
<tr class="even">
<td><code>filter()</code></td>
<td>Filter rows by condition</td>
<td><code>filter(mtcars, cyl 
> 5)</code></td>
</tr>
<tr class="odd">
<td><code>mutate()</code></td>
<td>Create or modify columns</td>
<td><code>mutate(mtcars, kpl = mpg * 0.425144)</code></td>
</tr>
<tr class="even">
<td><code>rename()</code></td>
<td>Rename columns</td>
<td><code>rename(mtcars, new_mpg = mpg)</code></td>
</tr>
<tr class="odd">
<td><code>group_by()</code></td>
<td>Group data for summary operations</td>
<td><code>group_by(mtcars, cyl)</code></td>
</tr>
<tr class="even">
<td><code>summarise()</code></td>
<td>Summarize data (e.g., mean, sum, count)</td>
<td><code>summarise(mtcars, avg_mpg = mean(mpg))</code></td>
</tr>
<tr class="odd">
<td><code>arrange()</code></td>
<td>Sort rows</td>
<td><code>arrange(mtcars, desc(mpg))</code></td>
</tr>
<tr class="even">
<td><code>bind_rows()</code></td>
<td>Combine data frames by rows</td>
<td><code>bind_rows(df1, df2)</code></td>
</tr>
<tr class="odd">
<td><code>ungroup()</code></td>
<td>Remove grouping</td>
<td><code>ungroup(data)</code></td>
</tr>
<tr class="even">
<td><code>inner_join()</code></td>
<td>Join two data frames by matching columns</td>
<td><code>inner_join(df1, df2, by = "id")</code></td>
</tr>
<tr class="odd">
<td><code>left_join()</code></td>
<td>Join two data frames by matching columns</td>
<td><code>left_join(df1, df2, by = "id")</code></td>
</tr>
<tr class="even">
<td><code>right_join()</code></td>
<td>Join two data frames by matching columns</td>
<td><code>right_join(df1, df2, by = "id")</code></td>
</tr>
<tr class="odd">
<td><code>full_join()</code></td>
<td>Join two data frames by all columns</td>
<td><code>full_join(df1, df2, by = "id")</code></td>
</tr>
</tbody>
</table>

These commands form the core of data manipulation with `dplyr` in the
tidyverse.

Other useful `dplyr` commands include: 

| **Command**      | **Purpose**                                                         | **Example Usage**                          |
|------------------|----------------------------------------------------------------------|---------------------------------------------|
| `anti_join()`    | Return rows from the first data frame that **do not** match in the second | `anti_join(df1, df2, by = "id")`            |
| `semi_join()`    | Return rows from the first data frame that **do** match in the second     | `semi_join(df1, df2, by = "id")`            |
| `distinct()`     | Return unique rows                                                  | `distinct(mtcars, cyl)`                     |
| `slice()`        | Select rows by position                                             | `slice(mtcars, 1:5)`                        |
