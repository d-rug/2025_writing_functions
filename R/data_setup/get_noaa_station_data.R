
# Description -------------------------------------------------------------

#' Download data from NOAA's climate data API
#' https://www.ncdc.noaa.gov/cdo-web/token
#' 


# Setup -------------------------------------------------------------------

library('httr')
library('jsonlite')
library('data.table')
library('lubridate')

# Functions ---------------------------------------------------------------



extract_json = function(response, results_only=FALSE) {
  
  result = fromJSON(rawToChar(response$content))
  
  if (results_only & ('results' %in% names(result)) ) {
    result = result$results
  }
  
  return(result)
}

get_count = function(result) {
  count = result$metadata$resultset$count
  
  return(count)
}

get_offset = function(result) {
  offset = result$metadata$resultset$offset
  
  return(offset)
  
}

create_url = function(base_url, dataset, args) {
  
  arg_string = paste(names(args), args, sep='=', collapse='&')
  
  url_req = paste0(base_url, '/', dataset, '?', arg_string)
  
  return(url_req)
  
}

get_with_token = function(base_url, dataset, args, token) {
  
  url = create_url(base_url, dataset, args)
  
  response = GET(url = url, config=add_headers(token = token))
  
  result = extract_json(response)
  
  return(result)
}

request_data = function(base_url, dataset, args, token) {
  
  args['limit'] = 1000
  
  results = get_with_token(base_url, dataset, args, token)
  
  result_count = get_count(results)
  
  df = results$results
  
  if (result_count>1000) {
    
    pages = ceiling(result_count/1000)
    
    for (i in 2:pages) {
      
      print(i)
      
      Sys.sleep(20)
      
      args['offset'] = get_offset(results) + 1000
      
      results = get_with_token(base_url, dataset, args, token)
      
      df = rbind(df, results$results)
      
    }
  
  }
  
  return(df)
  
}

get_year = function(chr) {
  num_year = substr(chr, 1, 4) |> as.integer()
  
  return(num_year)
}

# Main --------------------------------------------------------------------


api_key = readLines('noaa_api_key.txt')

noaa_url = 'https://www.ncei.noaa.gov/cdo-web/api/v2/'

arg_list = c(locationid='FIPS:06', datasetid='GHCND', sortfield='mindate',
             datacategoryid='TEMP')

raw_stations = request_data(noaa_url, 'stations', arg_list, api_key)
stations = data.table(raw_stations)

stations[, ":="(minyear = get_year(mindate), 
                maxyear = get_year(maxdate))]

stations[, years:= maxyear - minyear]

good_stations = stations[datacoverage>0.95 & years>=90 & maxyear>2020]
