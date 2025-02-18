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

* `copy_paste_modify_A.R` - one way someone might run the same analysis multiple times by copying and pasting the code. 

* `copy_paste_modify_B.R` - Another way someone might organize their code if 
  they copy and pasted their analysis multiple times.

* `function.R` - an example of how to organize the code in the other two files
  using a function.

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

## FAQ

### What are the shortcuts you were using?

Can't remember exactly which ones I was using but here are some of my favorite:

* Create section header: Cntrl/Cmd+Shift+R

* Autopopulating (roxygen) comments: #' and then hit Enter. Tip: if a comment
line gets too long, select the line(s) and then hit Cntrl+Shift+/ to break up
the lines so they don't go off the screen.

* Run line of code from script in console: Cntrl/Cmd+Enter

* Retrieve a line of code I previously ran in the console: up arrow

* Bring up the find and replace menu: Cntrl/Cmd + f

* Open up R help files: `?function_name`. So if you want to open up the help
file for `read.csv()` you would run `?read.csv` in the console
  
### How do you load/define functions in a script?

You have 3 options for defining a function.

1. Write the function inside the script. Make sure you define the function
before you use it in the script. This is good for functions you will only ever
use in one script.

2. Use `source()`. Define a function in a separate script (ex.
`R/functions.R`). Then run `source('R/functions.R')` at the top of your script
to load the function. This is a good option for functions that you want to use
in multiple scripts for a single project.

3. Write a package. I know this may sound scary but there are actually a lot
of resources to help you with the process! In particular, I found the (online)
book [R Packages][rpacks] and the R package [devtools][devtools] to be
incredibly helpful. The process of migrating functions into a package is
similar to migrating code into a function, but with more documentation. This
is a good option for functions you want to use across multiple projects or
that you want to share with other people.

### What exactly does `paste()` do? 

The `paste()` function sticks (concatenates) text strings together. By default
those text strings are separated with a space. However you can change that using
the `sep` argument. `paste()` is useful for creating labels in functions because
if you include a variable as an input to `paste()`, it concatenates the text
stored in the variable instead of the variable name. For example, the following
code 

```
campus_eatery = 'Swirlz Bakery in the Memorial Union'

plot_title = paste('Number of patrons per week at', campus_eatery)

print(plot_title)
```

will print 'Number of patrons per week at Swirlz Bakery in the Memorial Union',
not 'Number of patrons per week at campus_eatery'. You can use this to change
things like titles, axes labels, etc for each run of your function. For more
sophisticated text string manipulation check out `sprintf()` or `glue()` from
the glue package.

### How do we control what class of objects R will accept for a particular argument?
  
R doesn't have any built in method for doing this in regular functions. 
You can check manually using functions like `is.data.frame()` or 
checking the class of the object using `class`, and then throw an error 
using `stop()`. However, that can be clunky. The sleeker option would be 
to define a class and then create a method for that particular class. But
that only works for the first argument. If you are interested in defining
your own classes I would point you to the [Object Oriented Programming][oo] 
section of the [Advanced R book][advr].

### How do I get into debugging mode?

There are many ways of getting into debugging mode. These are some of my
favorite:

1.  Use `browser()`. Add the line of code 
    ```
    browser()
    ```
    somewhere in your function. Redefine your function with that line of code in
    it. Then when you next call your function you will enter debugging mode at the
    point where you put `browser()` in your function.
  
2.  Use`debugonce()`. If your function is called `my_function()`, you can get
    into debugging mode by running `debugonce(my_function)` in the console, and 
    then running your function. What this does is temporarily adds `browser()` 
    to the first line of code in your function. You can even do this with 
    functions you didn't write! Try
    
    ```
    debugonce(summary)
    summary(1:10)
    ```

3. Run `options(error=browser)` in the console. This will put you into debug
mode automatically whenever you hit an error. This can be useful if you aren't
sure where in your function an error is happening. However, it also will dump
you into debug mode if you accidentally mistype your variable name when running
something like `head(df)`. If you want to turn this functionality off, run
`options(error=NULL)` in the console. If you are writing nested functions you 
may want to use `options(error=recover)` instead. This gives you the option of
which function you want to "jump into". 

[rpacks]: https://r-pkgs.org/
[devtools]: https://devtools.r-lib.org/
[oo]: https://adv-r.hadley.nz/oo.html
[advr]: https://adv-r.hadley.nz/index.html

## Getting the Data

In general it is not a good idea to store data on github if it is larger than
1MB or two. For the purpose of this workshop I'm putting about 15MB of data in
this repository, but I will be removing it after the workshop (2025-02-13). 
If you find this repo later and want to follow along here is a rough guide for
how I got the NOAA temperature data.

1. I identified candidate NOAA weather stations using 
  `R/data_setup/get_noaa_station_data.R`. This allowed me to identify stations 
  that had long time series with very few missing values. This script requires
  an API key, which you can acquire [here][api].

2. I went to the NOAA Climate Data Online tool and searched for the stations
  I previously identified, from the Daily Summaries dataset. After adding them 
  to my "cart", I "checked out".

3. During "check-out" is where you specify the type of data you want and how
  you want to receive it. Here is what I chose:
  
    a. Custom GHCN-Daily CSV
    
    b. Time Range 1900-current
    
    c. Include station name but not lat/long location or special flags
    
    d. All air temperature variables selected

4. After that you click through and NOAA will send you an email when your data
  is ready to download. Save it in the data/ folder.


[api]: https://www.ncdc.noaa.gov/cdo-web/token
