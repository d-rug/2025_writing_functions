
# Setup -------------------------------------------------------------------

#' TO GET DATA
#' Go to https://www.ncdc.noaa.gov/cdo-web/search
#' Daily Summaries 
#' Add target stations to cart
#' Check out 
#'  - Custom GHCN-Daily CSV
#'  - Select time range
#'  - Check Air temperature variables
#'  Download Data when it is ready and store it in the data/ folder
#'  Modify file name below:
#'  

data_path = 'data/3877365.csv'

library('data.table')

filter_write = function(station, df) {
  df_station = df[STATION == station]
  
  fn = paste0('data/noaa/', station, '.csv')
  
  fwrite(df_station, fn)
}

noaa = fread(data_path)

stations = unique(noaa$STATION)

lapply(stations, filter_write, noaa)
