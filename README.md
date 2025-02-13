# Writing Your Own Functions (in R)

Tutorial on how to write your own functions in R, [Google Slides][slides].

[slides]: https://docs.google.com/presentation/d/1biJUPsf3farPX9GDToQ8CnAlo5BRAxImaqBYgLJ5CcI/edit?usp=sharing

```
data/noaa       Temperature data
plots/          Where we will store our plot outpus
R/              R source code
└── data_setup  code for downloading and splitting the data
.gitignore      Paths git should ignore
README.md       This file

```

## File Descriptions

* `copy_paste_modify_A.R` - one way someone might run the same analysis multiple
  times by copying and pasting the code. 

* `copy_paste_modify_B.R` - Another way someone might organize their code if 
  they copy and pasted their analysis multiple times.

* `function.R` - an example of how to organize the code in the other two files
  using a function

## Step by Step Instructions

### Non-Coding Steps

1. What tasks do you want to accomplish with this function? (scope)

    a. Use comments and pseudo code to outline
    
    b. Start small and work your way up
  
2. What are the inputs? (parameters)

    a. What data does the function need to "know about"?
    
    b. What things will change between different runs of your function?
    
3. What is the output? (return value)

    a. Think about what your goal is.
    
    b. data.frame or other R object, data file, plot? 

### Coding Steps
4. Write and test code outside of function.

5. Set up function skeleton, including naming it.

      b. Use a evocative name.
      
      a. Include descriptive parameter names. 
      
6. Migrate code into function skeleton.
    
    a. Don't be afraid to copy/paste from original code 
    
    b. Insert parameter values where applicable.
  
### Finishing Steps

7. Test function.

    a. Restart Session before testing.
    
    b. `debug()`, `debugonce()`, `browser()`, or `options(error=recover)`
    
    c. Implement defensive programming, ex. error messages using `stop()`
  
8. Document function!

    a. Use roxygen comments (#') for autopopulating hashtags
    
    b. Follow built-in R documentation for guidance

## R Function Skeleton

```
evocative_function_name <- function(param1, param2) {



  return(output)
}

```