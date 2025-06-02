---
title: Lesson 1 - Introduction to R
parent: Data Wrangling with R
nav_order: 1
---

# 🚀 A Quick Introduction to *R*

R is a powerful programming language and environment for statistical computing and graphics. It is widely used among statisticians and data miners for data analysis and visualization.

In base R (without additional packages), you can create variables, manipulate data, and perform calculations with simple commands. Here are some basic examples:

{:.activity}
>```r
>    # Create a variable
>    x <- 5
>    # Perform a calculation
>    y <- x * 2
>    # Print the result
>    print(y)  
>```

    ## [1] 10


{:.activity}
>```r
>    # Create a vector
>    v <- c(1, 2, 3, 4, 5)
>    # Calculate the mean of the vector
>    mean_v <- mean(v)
>    # Print the mean
>    print(mean_v)  
>```

    ## [1] 3

Think of R as a more complex and **powerful calculator** that can handle complex data analysis tasks. It allows you to perform operations on data, create visualizations, and apply statistical models.

# 🖥️ R as programming language

## R Data Structures

R has several built-in data structures that are essential for data analysis. Data structures in R are ways to organize and store data so that it can be easily manipulated and analyzed. Each structure has its own characteristics and is suited for different types of data.

The most common ones include:

### Core Data Structures in Base R

<table>
<colgroup>
<col style="width: 9%" />
<col style="width: 46%" />
<col style="width: 44%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Structure</strong></th>
<th><strong>Description</strong></th>
<th><strong>Example</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Vector</strong></td>
<td>One-dimensional sequence of elements of the same type</td>
<td><code>x &lt;- c(1, 2, 3, 4)</code><br><code>names &lt;- c("Alice", "Bob")</code></td>
</tr>
<tr class="even">
<td><strong>Matrix</strong></td>
<td>Two-dimensional array of the same type</td>
<td><code>m &lt;- matrix(1:6, nrow = 2)</code><br><code>m[1, 2]  # Access element</code></td>
</tr>
<tr class="odd">
<td><strong>Array</strong></td>
<td>Multi-dimensional generalization of a matrix</td>
<td><code>a &lt;- array(1:12, dim = c(2, 3, 2))</code><br><code>a[1, 2, 1]</code></td>
</tr>
<tr class="even">
<td><strong>Data Frame</strong></td>
<td>Table with columns of different types</td>
<td><code>df &lt;- data.frame(name=c("A", "B"), age=c(25, 30))</code><br><code>df$age</code></td>
</tr>
<tr class="odd">
<td><strong>List</strong></td>
<td>Collection of elements of any type</td>
<td><code>lst &lt;- list(name="Alice", age=25, scores=c(90, 85))</code><br><code>lst[[2]]</code></td>
</tr>
<tr class="even">
<td><strong>Factor</strong></td>
<td>Categorical variable with predefined levels</td>
<td><code>f &lt;- factor(c("low", "medium", "high"))</code><br><code>levels(f)</code></td>
</tr>
<tr class="odd">
<td><strong>Environment</strong></td>
<td>Collection of objects (variables, functions) in a specific
scope</td>
<td><code>env &lt;- new.env()</code><br><code>assign("x", 10, envir = env)</code><br><code>env$x</code></td>
</tr>
<tr class="even">
<td><strong>Function</strong></td>
<td>A block of code that can be called with arguments</td>
<td><code>my_func &lt;- function(x) { x^2 }</code><br><code>my_func(3)</code></td>
</tr>
</tbody>
</table>

## R Data Types and Variables

Like any programming language, R allows you to create variables to store data. Variables can hold different types of data, such as numbers, text, or logical values. Here are some examples of creating and using variables in R:

{:.activity}
>```r
>    # Numeric type
>    num_var <- 3.14
>    print(num_var)        
>```
    ## [1] 3.14

>{:.activity}
>```r
>    # Integer type
>    int_var <- 5L  # 'L' suffix indicates an integer
>    print(int_var)        
>```

    ## [1] 5

{:.activity}
>```r
>    # Character type
>    char_var <- "Hello, R!"
>    print(char_var)      
>```

    ## [1] "Hello, R!"

{:.activity}
>```r
>    # Logical type
>    log_var <- TRUE
>    print(log_var)        
>```

    ## [1] TRUE

{:.activity}
>```r
>    # Complex type
>    complex_var <- 1 + 2i  # 'i' indicates an imaginary part
>    print(complex_var)    
>```

    ## [1] 1+2i

{:.activity}
>```r
>    # Raw type
>    raw_var <- charToRaw("A")  # Converts character to raw bytes
>    print(raw_var)     
>```

    ## [1] 41

{:.activity}
>```r
>    # Factor type
>    factor_var <- factor(c("low", "medium", "high"))  # Categorical data
>    print(factor_var)
>```

    ## [1] low    medium high  
    ## Levels: high low medium

{:.activity}
>```r
>    print(levels(factor_var)) 
>```

    ## [1] "high"   "low"    "medium"

{:.activity}
>```r
>    # Date type
>    date_var <- as.Date("2025-01-01")  # Date object
>    print(date_var)      
>```

    ## [1] "2025-01-01"

{:.activity}
>```r
>    # POSIXct type
>    posix_var <- as.POSIXct("2025-01-01 12:00:00")  # Date-time object
>    print(posix_var)
>```

    ## [1] "2025-01-01 12:00:00 MST"

{:.activity}
>```r
>    # Function type
>    func_var <- function(a, b) a + b  # User-defined function
>    print(func_var(2, 3))  
>```

    ## [1] 5

{:.activity}
>```r
>    # List type
>    list_var <- list(name="Gama", age=18, scores=c(96, 88))  # Heterogeneous container
>    print(list_var)  
>```

    ## $name
    ## [1] "Gama"
    ## 
    ## $age
    ## [1] 18
    ## 
    ## $scores
    ## [1] 96 88

{:.activity}
>```r
>    # Data frame type
>    df_var <- data.frame(a=1:4, b=c("A", "B","C","Z"))  # Table-like structure
>    print(df_var)  
>```

    ##   a b
    ## 1 1 A
    ## 2 2 B
    ## 3 3 C
    ## 4 4 Z

{:.activity}
>```r
>    # Matrix type
>    matrix_var <- matrix(1:4, nrow=2)  # 2D numeric structure
>    print(matrix_var)  
>```

    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4

{:.activity}
>```r
>    # Array type
>    array_var <- array(1:8, dim=c(2, 2, 2))  # Multi-dimensional structure
>    print(array_var)  
>```

    ## , , 1
    ## 
    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4
    ## 
    ## , , 2
    ## 
    ##      [,1] [,2]
    ## [1,]    5    7
    ## [2,]    6    8

R is also an **interactive language**, meaning you can type commands directly into the console and see results immediately. This makes it easy to experiment with data and perform quick calculations.

### Summary of R Data Types and Structures

<table>
<colgroup>
<col style="width: 10%" />
<col style="width: 33%" />
<col style="width: 31%" />
<col style="width: 12%" />
<col style="width: 11%" />
</colgroup>
<thead>
<tr class="header">
<th><strong>Type</strong></th>
<th><strong>Description</strong></th>
<th><strong>Example</strong></th>
<th><strong>typeof()</strong></th>
<th><strong>class()</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Numeric</strong></td>
<td>Numbers with decimal points</td>
<td><code>x &lt;- 3.14</code></td>
<td><code>"double"</code></td>
<td><code>"numeric"</code></td>
</tr>
<tr class="even">
<td><strong>Integer</strong></td>
<td>Whole numbers (explicit with <code>L</code>)</td>
<td><code>x &lt;- 5L</code></td>
<td><code>"integer"</code></td>
<td><code>"integer"</code></td>
</tr>
<tr class="odd">
<td><strong>Character</strong></td>
<td>Text strings</td>
<td><code>x &lt;- "hello"</code></td>
<td><code>"character"</code></td>
<td><code>"character"</code></td>
</tr>
<tr class="even">
<td><strong>Logical</strong></td>
<td>Boolean values: TRUE or FALSE</td>
<td><code>x &lt;- TRUE</code></td>
<td><code>"logical"</code></td>
<td><code>"logical"</code></td>
</tr>
<tr class="odd">
<td><strong>Complex</strong></td>
<td>Complex numbers</td>
<td><code>x &lt;- 1 + 2i</code></td>
<td><code>"complex"</code></td>
<td><code>"complex"</code></td>
</tr>
<tr class="even">
<td><strong>Raw</strong></td>
<td>Raw bytes (rarely used)</td>
<td><code>x &lt;- charToRaw("A")</code></td>
<td><code>"raw"</code></td>
<td><code>"raw"</code></td>
</tr>
<tr class="odd">
<td><strong>Factor</strong></td>
<td>Categorical data with levels</td>
<td><code>x &lt;- factor(c("low", "high"))</code></td>
<td><code>"integer"</code></td>
<td><code>"factor"</code></td>
</tr>
<tr class="even">
<td><strong>Date</strong></td>
<td>Date objects</td>
<td><code>x &lt;- as.Date("2025-01-01")</code></td>
<td><code>"double"</code></td>
<td><code>"Date"</code></td>
</tr>
<tr class="odd">
<td><strong>POSIXct</strong></td>
<td>Date-time object</td>
<td><code>x &lt;- as.POSIXct("2025-01-01 12:00:00")</code></td>
<td><code>"double"</code></td>
<td><code>"POSIXct"</code></td>
</tr>
<tr class="even">
<td><strong>Function</strong></td>
<td>User-defined or built-in functions</td>
<td><code>x &lt;- function(a, b) a + b</code></td>
<td><code>"closure"</code></td>
<td><code>"function"</code></td>
</tr>
<tr class="odd">
<td><strong>List</strong></td>
<td>Heterogeneous container</td>
<td><code>x &lt;- list(name="Gama", age=30)</code></td>
<td><code>"list"</code></td>
<td><code>"list"</code></td>
</tr>
<tr class="even">
<td><strong>Data Frame</strong></td>
<td>Table-like structure</td>
<td><code>x &lt;- data.frame(a=1:2, b=c("A", "B"))</code></td>
<td><code>"list"</code></td>
<td><code>"data.frame"</code></td>
</tr>
<tr class="odd">
<td><strong>Matrix</strong></td>
<td>2D numeric structure</td>
<td><code>x &lt;- matrix(1:4, 2, 2)</code></td>
<td><code>"integer"</code></td>
<td><code>"matrix"</code></td>
</tr>
<tr class="even">
<td><strong>Array</strong></td>
<td>Multi-dimensional structure</td>
<td><code>x &lt;- array(1:8, c(2,2,2))</code></td>
<td><code>"integer"</code></td>
<td><code>"array"</code></td>
</tr>
<tr class="odd">
<td><strong>Environment</strong></td>
<td>Collection of objects in a scope</td>
<td><code>x &lt;- new.env()</code></td>
<td><code>"environment"</code></td>
<td><code>"environment"</code></td>
</tr>
</tbody>
</table>

{:.note} 
> If you do not know data type or structure of an object, you can use the `typeof()` and `class()` functions to check it. For example:
>
>```r
>    typeof(x)  # Check the type of x
>
>    ## [1] "double"
>
>    class(x)   # Check the class of x
>
>    ## [1] "numeric"
>```

# 😑 R Basics

## Basic Syntax

R syntax is straightforward and similar to other programming languages. Here are some basic elements of R syntax: 
- **Comments**: Use `#` to add comments in your code. 
- **Assignment**: Use `<-` or `=` to assign values to variables. 
- **Functions**: Call functions using their names followed by parentheses, e.g., `mean(x)`. 
- **Operators**: Use operators like `+`, `-`, `*`, `/` for arithmetic operations, and `==`, `!=`, `<`, `>` for comparisons. 
- **Control Structures**: Use `if`, `else`, `for`, and `while` for control flow. 
- **Packages**: Use `library(package_name)` to load additional functionality.

<br>

## Indexing and Subsetting

In R, you can access elements of vectors, matrices, data frames, and lists using indexing. Here are some examples:

{:.activity}
>```r
>    # Accessing elements in a vector
>    v <- c(10, 20, 30, 40)
>    print(v)
>```

    ## [1] 10 20 30 40

{:.activity}
>```r
>    print(v[2])  
>```

    ## [1] 20

{:.activity}
>```r
>    # Accessing elements in a matrix
>    m <- matrix(1:9, nrow=3)
>    print(m)
>```

    ##      [,1] [,2] [,3]
    ## [1,]    1    4    7
    ## [2,]    2    5    8
    ## [3,]    3    6    9

{:.activity}
>```r
>    print(m[2, 3])  
>```

    ## [1] 8

{:.activity}
>```r
>    # Accessing elements in a data frame
>    df <- data.frame(name=c("Alice", "Bob"), age=c(25, 30))
>    print(df)
>```

    ##    name age
    ## 1 Alice  25
    ## 2   Bob  30

{:.activity}
>```r
>    print(df[1, ])  
>```

    ##    name age
    ## 1 Alice  25

{:.activity}
>```r
>    print(df[1, "name"])  
>```

    ## [1] "Alice"

{:.activity}
>```r
>    print(df$name)  
>```

    ## [1] "Alice" "Bob"

{:.activity}
>```r
>    # Accessing elements in a list
>    lst <- list(a=1:5, b="Hello", c=TRUE)
>    print(lst)
>```
    ## $a
    ## [1] 1 2 3 4 5
    ## 
    ## $b
    ## [1] "Hello"
    ## 
    ## $c
    ## [1] TRUE

{:.activity}
>```r
>    print(lst$b)  
>```
    ## [1] "Hello"

{:.activity}
>```r
>    # Accessing elements in a factor
>    f <- factor(c("low", "medium", "high"))
>    print(f[2])  
>```

    ## [1] medium
    ## Levels: high low medium

{:.activity}
>```r
>    # Accessing elements in a character vector
>    char_vec <- c("apple", "banana", "cherry")
>    print(char_vec[1])  
>```

    ## [1] "apple"

{:.note} 
>Indexing in R is **1-based**, meaning the first element is accessed with index 1. You can also use **negative indices** to exclude elements or logical vectors to filter data.

---

## Vectorized Operations

R is designed for vectorized operations, meaning you can perform operations on entire vectors or matrices without using explicit loops. This makes R efficient for data manipulation. Here are some examples:

{:.activity}
>```r
>    # Vectorized addition
>    v1 <- c(1, 2, 3)
>    v2 <- c(4, 5, 6)
>    result <- v1 + v2  # Adds corresponding elements
>    print(result)  
>```

    ## [1] 5 7 9

{:.activity}
>```r
>    # Vectorized multiplication
>    v3 <- c(2, 3, 4)
>    result2 <- v1 * v3  # Multiplies corresponding elements
>    print(result2)  
>```

    ## [1]  2  6 12

{:.activity}
>```r
>    # Vectorized comparison
>    v4 <- c(1, 2, 3, 4)
>    result3 <- v4 > 2  # Compares each element to 2
>    print(result3)  
>```

    ## [1] FALSE FALSE  TRUE  TRUE

{:.activity}
>```r
>    # Matrix operations
>    m1 <- matrix(1:4, nrow=2)
>    m2 <- matrix(5:8, nrow=2)
>    result4 <- m1 + m2  # Adds corresponding elements
>    print(m1)
>```
    ##      [,1] [,2]
    ## [1,]    1    3
    ## [2,]    2    4

{:.activity}
>```r
>    print(m2)
>```

    ##      [,1] [,2]
    ## [1,]    5    7
    ## [2,]    6    8

{:.activity}
>```r
>    print(result4)  
>```

    ##      [,1] [,2]
    ## [1,]    6   10
    ## [2,]    8   12

{:.activity}
>```r
>    # Vectorized functions
>    v5 <- c(1, 2, 3, 4)
>    result5 <- sqrt(v5)  # Applies square root to each element
>    print(result5)  
>```

    ## [1] 1.000000 1.414214 1.732051 2.000000

{:.activity}
>```r
>    # Vectorized logical operations
>    v6 <- c(TRUE, FALSE, TRUE)
>    v7 <- c(FALSE, TRUE, TRUE)
>    result6 <- v6 & v7  # Logical AND operation
>    print(result6)  
>```

    ## [1] FALSE FALSE  TRUE

Vectorized operations allow you to write concise and efficient code, **avoiding the need for explicit loops** like in other languages. This is one of the key features that makes R powerful for data analysis.

---

## Recycling Rules *R*

In R, when performing operations on vectors of different lengths, R applies a concept called **recycling**. This means that if one vector is shorter than the other, R will repeat the shorter vector until it matches the length of the longer vector. Here are some examples:

{:.activity}
>```r
>    # Example with different lengths
>    v1 <- c(1, 2, 3)
>    v2 <- c(10, 20)
>    result <- v1 + v2  # The second vector is recycled
>    print(result)  
>```

    ## Warning in v1 + v2: longer object length is not a multiple of shorter object
    ## length
    ##
    ## [1] 11 22 13

{:.activity}
>```r
>    # Example with recycling in a matrix
>    m1 <- matrix(1:6, nrow=2)
>    m2 <- c(10, 20)  # Shorter vector
>    result2 <- m1 + m2  # The second vector is recycled
>    print(m1)
>```

    ##      [,1] [,2] [,3]
    ## [1,]    1    3    5
    ## [2,]    2    4    6

{:.activity}
>```r
>    print(m2)
>```

    ## [1] 10 20

{:.activity}
>```r
>    print(result2)  
>```

    ##      [,1] [,2] [,3]
    ## [1,]   11   13   15
    ## [2,]   22   24   26


---

## Logical Operations in **R**

Logical operations in R are used to perform comparisons and logical tests on data. They return boolean values (`TRUE` or `FALSE`) based on the conditions specified. Here are some common logical operations:

{:.note}
>‘TRUE’ and ‘FALSE’ are written in uppercase in R, and they are used to represent boolean values. ‘TRUE’ and ‘FALSE’ can be represented as 1 and 0, respectively, but are not strict equivalents.

{:.activity}
>```r
>    # Logical operations
>    # Create two vectors
>    v1 <- c(1, 2, 3, 4)
>    v2 <- c(3, 4, 3, 6)
>    # Comparison operators
>    equal <- v1 == v2  # Check if elements are equal
>    print(equal)  
>```

    ## [1] FALSE FALSE  TRUE FALSE

{:.activity}
>```r
>    greater_than <- v1 > v2  # Check if elements in v1 are greater than those in v2
>    print(greater_than)  
>```

    ## [1] FALSE FALSE FALSE FALSE

{:.activity}
>```r
>    less_than <- v1 < v2  # Check if elements in v1 are less than those in v2
>    print(less_than)  
>```

    ## [1]  TRUE  TRUE FALSE  TRUE

{:.activity}
>```r
>    # Logical operators
>    and <- v1 > 2 & v2 < 5  # Logical AND operation
>    print(and)  
>```

    ## [1] FALSE FALSE  TRUE FALSE

{:.activity}
>```r
>    or <- v1 < 2 | v2 > 5  # Logical OR operation
>    print(or)  
>```

    ## [1]  TRUE FALSE FALSE  TRUE

{:.activity}
>```r
>    not <- !(v1 < 3)  # Logical NOT operation
>    print(not)  
>```

    ## [1] FALSE FALSE  TRUE  TRUE

{:.activity}
>```r
>    # Combining logical conditions
>    combined_condition <- (v1 > 2) & (v2 < 5)  # Combine conditions with AND
>    print(combined_condition)  
>```

    ## [1] FALSE FALSE  TRUE FALSE

{:.activity}
>```r
>    # Logical indexing
>    # Use logical vectors to index elements
>    v3 <- c(10, 20, 30, 40)
>    logical_index <- v3 > 20  # Create a logical vector
>    print(logical_index)  
>```

    ## [1] FALSE FALSE  TRUE  TRUE

{:.activity}
>```r
>    # Use logical vector to subset the original vector
>    subset_v3 <- v3[logical_index]  # Subset using logical indexing
>    print(subset_v3)  
>```

    ## [1] 30 40

### Conditional Statements

Conditional statements in R allow you to execute code based on certain conditions. The most common conditional statements are `if`, `else if`, and `else`. Here are some examples:

{:.activity}
>```r
>    # Conditional statements
>    x <- 5
>
>    # If-else statement
>    if (x > 0) {
>      print("x is positive")
>    } else if (x < 0) {
>      print("x is negative")
>    } else {
>      print("x is zero")
>    }
>```

    ## [1] "x is positive"

{:.activity}
>```r
>    # Nested if-else statement
>    if (x > 0) {
>      print("x is positive")
>    } else {
>      if (x < 0) {
>        print("x is negative")
>      } else {
>        print("x is zero")
>      }
>    }
>```

    ## [1] "x is positive"

{:.activity}
>```r
>    # Switch statement
>    fruit <- "apple"
>    switch(fruit,
>           apple = "This is an apple",
>           banana = "This is a banana",
>           orange = "This is an orange",
>           "Unknown fruit")  # Default case if no match
>```

    ## [1] "This is an apple"

Conditional statements are essential for controlling the flow of your R programs, allowing you to execute different code blocks based on specific conditions.

---

## Understanding Missing Values or **NA** in R

In R, missing values are represented by `NA` (Not Available). They indicate that a value is not present or is unknown. Handling missing values is crucial in data analysis, as they can affect calculations and results.

There are several ways of working with missing values in R:

{:.activity}
>```r
>    # Create a vector with missing values
>    v <- c(1, 2, NA, 4, NA, 6)
>    mean(v)
>```

    ## [1] NA

{:.activity}
>```r
>    mean(v, na.rm = TRUE)  # Calculate mean while ignoring NA values
>```

    ## [1] 3.25

{:.activity}
>```r
>    # Check for missing values
>    is.na(v)  # Returns TRUE for NA values
>```

    ## [1] FALSE FALSE  TRUE FALSE  TRUE FALSE

{:.activity}
>```r
>    # Count missing values
>    na_count <- sum(is.na(v))  # Count the number of NA values
>    print(na_count)
>```

    ## [1] 2

{:.activity}
>```r
>    # Remove missing values
>    v_no_na <- na.omit(v)  # Remove NA values from the vector
>    print(v_no_na)
>```

    ## [1] 1 2 4 6
    ## attr(,"na.action")
    ## [1] 3 5
    ## attr(,"class")
    ## [1] "omit"

{:.activity}
>```r
>    # Replace missing values
>    v[is.na(v)] <- 0  # Replace NA values with 0
>    print(v)  # Print the vector after replacing NA values
>```

    ## [1] 1 2 0 4 0 6

Missing values can occur in various data types, including vectors, matrices, data frames, and lists. It is essential to handle them appropriately to ensure accurate analysis and results.

---

## Reading and Writing Data

There are several ways to read and write data in R, depending on the format of the data.

{:.activity}
```r
    # Let us create a sample data frame
    df <- data.frame(
      Name = c("Alice", "Bob", "Charlie"),
      Age = c(25, 30, 35),
      Score = c(90, 85, 95)
    )
    # Writing data to a CSV file
    write.csv(df, "./sample_data.csv", row.names = FALSE)  # Save data frame to CSV file
    # Reading data from a CSV file
    df_read <- read.csv("./sample_data.csv")  # Read data from CSV file
    print(df_read)  # Print the read data frame
```

    ##      Name Age Score
    ## 1   Alice  25    90
    ## 2     Bob  30    85
    ## 3 Charlie  35    95

# 🧠 Extra Base R information

## The HELP System

R has a built-in help system that provides documentation for functions,
packages, and datasets. You can access help in several ways:

{:.highlight}
>```r
>    ?mean
>    help("lm")
>    example(mean)
>```
>
>    ## 
>    ## mean> x <- c(0:10, 50)
>    ## 
>    ## mean> xm <- mean(x)
>    ## 
>    ## mean> c(xm, mean(x, trim = 0.10))
>    ## [1] 8.75 5.50
>
>    # Try this too:
>    help(package = "stats")  # Get help for the 'stats' package
>    help.search("linear model")  # Search for help on linear models

---

## Apply family functions

The apply family functions in base R are a set of functions used to perform loop-like operations over elements of data structures (vectors, lists, matrices, etc.) in a more concise and often more efficient way than using explicit for loops. Examples of apply family functions include `apply()`, `lapply()`, `sapply()`, `tapply()`, and `mapply()`. These functions allow you to apply a function to each element or subset of a data structure without writing explicit loops.

{:.activity}
```r
    # Using apply family functions
    # Create a matrix
    m <- matrix(1:9, nrow=3)
    # Apply function to rows
    row_sums <- apply(m, 1, sum)  # Sum of each row
    print(row_sums)  
```

    ## [1] 12 15 18

{:.activity}
```r
    # lapply
    lst <- list(a=1:5, b=6:10, c=11:15)
    lapply_result <- lapply(lst, mean)  # Calculate mean of each list element
    print(lapply_result)  
```

    ## $a
    ## [1] 3
    ## 
    ## $b
    ## [1] 8
    ## 
    ## $c
    ## [1] 13

{:.activity}
```r
    #sapply
    sapply_result <- sapply(lst, mean)  # Simplified version of lapply
    print(sapply_result)  
```

    ##  a  b  c 
    ##  3  8 13

{:.activity}
```r
    # tapply
    ages <- c(25, 30, 35, 40)
    group <- c("A", "A", "B", "B")
    tapply(ages, group, mean)  # Mean age by group
```
    ##    A    B 
    ## 27.5 37.5

<br>

# Summary: Base R

In this introduction to **base R**, you’ve learned how to create and
manipulate variables, explore core data types and structures, perform
vectorized operations, handle missing values, and apply functions
efficiently using the `apply` family. You’ve also seen how to read and
write data, use conditional logic, and leverage R’s built-in help
system.

Base R provides a strong foundation for data analysis, and understanding
its syntax and logic will help you confidently explore more advanced
tools like the tidyverse, data visualization, and statistical modeling.
With practice, R becomes a powerful ally in data-driven problem-solving.

Happy analysis!
