library('ggplot2')
library('lubridate')


#' Plot Minimum Temperature Data Over Time
#' 
#' This function inputs a temperature data file from NOAA, 
#' cleans the data and then calculates the average annual winter minimum 
#' temperature for all years present in data set.
#' 
#' @param filename character, file path for the data
#' @param location character, name of the location were the temperature data 
#'    originates
#' @param save_path character, path to folder where the plot should be saved.
#' 
#' A plot is saved and the full file path of the resulting plot is returned
#' .
plot_temperature <- function(filename, location, save_path) {
  
  df <- read.csv(filename)
  
  #convert names to lower case
  names(df) <- tolower(names(df)) 
  
  
  #remove missing values
  df <- df[!is.na(df$tmin), ] 
  
  #extract month and year
  df$month <- month(df$date)
  df$year <- year(df$date)
  
  #filter to only be the winter months
  winter <- df[df$month %in% c(12, 1, 2), ]
  
  
  #modify year so that Dec gets grouped with the Jan and Feb it is adjacent to
  winter$year_mod <- ifelse(winter$month==12, winter$year+1, winter$year)
  
  #calculate average tmin per winter
  avg_temp_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)
  
  #convert to data.frame
  avg_temp <- data.frame(year=as.integer(names(avg_temp_vec)), 
                         tmin=avg_temp_vec)
  
  #run linear model
  mod <- lm(tmin ~ year, data=avg_temp)
  
  #calculate slope of line
  slope <- round(coef(mod)[2] * 10, 2)
  
  #create text for plot
  slope_text <- paste0('Slope = ', slope, 'F per decade')
  
  #calculate R^2
  r2 <- round(summary(mod)$adj.r.squared, 3)
  r2_text <- paste0('italic(R) ^ 2 ==', r2)
  
  #create title
  title_str <- paste('Average Winter Minimum Temperature:', location)
  
  #create plot file name 
  loc_no_space <- gsub(' ', '_', location)
  fn <- file.path(save_path, paste0(loc_no_space, '_tmin.png'))
  
  #plot of Tmin over time
  tmin_plot <- ggplot(data=avg_temp, aes(x=year, y=tmin)) +
    geom_point(color='navy') + 
    geom_smooth(formula='y~x', method='lm') +
    labs(title=title_str,
         x='Year',
         y='Temperature (Fahrenheit)') +
    annotate('text', x=1925, y=50, label=slope_text, size=5, hjust=0) +
    annotate('text', x=1925, y=49, label=r2_text, size=5, hjust=0, parse=TRUE) +
    theme_bw(14)
  
  #save plot
  
  ggsave(filename=fn, plot=tmin_plot)
  
  return(fn)
}

file_names = c('data/noaa/USC00041758.csv', 'data/noaa/USC00043939.csv',
               'data/noaa/USC00044500.csv', 'data/noaa/USC00044890.csv',
               'data/noaa/USW00024216.csv', 'data/noaa/USW00023271.csv')

loc_names = c('Chula Vista', 'Yosemite', 'North Bay', 'Tulare', 'Red Bluff',
              'Sacramento')

temperature_data_files = list.files('data/noaa', pattern='csv', full.names = TRUE)

mapply(plot_temperature, file_names, loc_names, 'plots/function/')


