# Writing Your Own Functions (in R)
Tutorial on how to write your own functions in R.

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

      b. Use a evocative name
      a. Include descriptive parameter names 
      
6. Migrate code into function skeleton.

    a. Replace variable names with parameter values
    b. Rename variables created in function to differ from variables in your
    regular
  
7. Test function.

    a. `debug()`, `debugonce()`, `browser()`, or `options(error=recover)`
    b. Implement error messages and error catching: `stop()` and `tryCatch()`
  
8. Document function!

    a. Use roxygen comments (#') for autopopulating hashtags
    b. Follow built-in R documentation for guidance

## R Function Skeleton

```
evocative_function_name <- function(param1, param2) {



  return(output)
}

```