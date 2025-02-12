library('data.table')

filter_write = function(station, df) {
  df_station = df[STATION == station]
  
  fn = paste0('data/noaa/', station, '.csv')
  
  fwrite(df_station, fn)
}

noaa = fread('data/3877365.csv')

stations = unique(noaa$STATION)

lapply(stations, filter_write, noaa)
