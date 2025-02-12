# Goal: Create plots of average minimum winter temperatures over time for 
# 6 parts of California with a linear model super imposed on top and the slop
# printed on the plot

library('ggplot2')
library('lubridate')

# Chula Vista ---------------------------------------------------------------

#read in data
df <- read.csv('data/noaa/USC00041758.csv')

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
avg_tmin_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)

#convert to data.frame
avg_tmin <- data.frame(year=as.integer(names(avg_tmin_vec)), 
                       tmin=avg_tmin_vec)

#run linear model
mod <- lm(tmin ~ year, data=avg_tmin)

#calculate slope of line
slope <- round(coef(mod)[2] * 10, 2)

#create text for plot
slope_text <- paste0('Slope = ', slope, 'F per decade')

#calculate R^2
r2 <- round(summary(mod)$adj.r.squared, 3)
r2_text <- paste0('italic(R) ^ 2 ==', r2)

#plot of Tmin over time
tmin_plot <- ggplot(data=avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Chula Vista',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=slope_text, size=5, hjust=0) +
  annotate('text', x=1925, y=49, label=r2_text, size=5, hjust=0, parse=TRUE) +
  theme_bw(14)

#save plot
png(filename='plots/original/chula_vista_tmin.png')
  tmin_plot
dev.off()


# Yosemite ---------------------------------------------------------------

#read data
df <- read.csv('data/noaa/USC00043939.csv')

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
avg_tmin_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)

#convert to data.frame
avg_tmin <- data.frame(year=as.integer(names(avg_tmin_vec)), 
                       tmin=avg_tmin_vec)

#run linear model
mod <- lm(tmin ~ year, data=avg_tmin)

#calculate slope of line with text for plot
slope <- round(coef(mod)[2] * 10, 2)
slope_text <- paste0('Slope = ', slope, 'F per decade')

#calculate R^2
r2 <- round(summary(mod)$adj.r.squared, 3)
r2_text <- paste0('italic(R) ^ 2 ==', r2)

#plot of Tmin over time
tmin_plot <- ggplot(data=avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Yosemite',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1917, y=35, label=slope_text, size=5, hjust=0) +
  annotate('text', x=1917, y=34, label=r2_text, size=5, hjust=0, parse=TRUE) +
  theme_bw(14)

#save plot
png(filename='plots/original/yosemite_tmin.png')
tmin_plot
dev.off()


# North Bay ---------------------------------------------------------------


df <- read.csv('data/noaa/USC00044500.csv')

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
avg_tmin_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)

#convert to data.frame
avg_tmin <- data.frame(year=as.integer(names(avg_tmin_vec)), 
                       tmin=avg_tmin_vec)

#run linear model
mod <- lm(tmin ~ year, data=avg_tmin)

#calculate slope of line with text for plot
slope <- round(coef(mod)[2] * 10, 2)
slope_text <- paste0('Slope = ', slope, 'F per decade')

#calculate R^2
r2 <- round(summary(mod)$adj.r.squared, 3)
r2_text <- paste0('italic(R) ^ 2 ==', r2)

#plot of Tmin over time
tmin_plot <- ggplot(data=avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Marin County',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1908, y=46, label=slope_text, size=5, hjust=0) +
  annotate('text', x=1908, y=45, label=r2_text, size=5, hjust=0, parse=TRUE) +
  theme_bw(14)

#save plot
png(filename='plots/original/marin_tmin.png')
tmin_plot
dev.off()


# Tulare ------------------------------------------------------------------

df <- read.csv('data/noaa/USC00044890.csv')

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
avg_tmin_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)

#convert to data.frame
avg_tmin <- data.frame(year=as.integer(names(avg_tmin_vec)), 
                       tmin=avg_tmin_vec)

#run linear model
mod <- lm(tmin ~ year, data=avg_tmin)

#calculate slope of line with text for plot
slope <- round(coef(mod)[2] * 10, 2)
slope_text <- paste0('Slope = ', slope, 'F per decade')

#calculate R^2
r2 <- round(summary(mod)$adj.r.squared, 3)
r2_text <- paste0('italic(R) ^ 2 ==', r2)

#plot of Tmin over time
tmin_plot <- ggplot(data=avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Tulare County',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1905, y=46, label=slope_text, size=5, hjust=0) +
  annotate('text', x=1905, y=45, label=r2_text, size=5, hjust=0, parse=TRUE) +
  theme_bw(14)

#save plot
png(filename='plots/original/tulare_tmin.png')
tmin_plot
dev.off()


# Sacramento --------------------------------------------------------------

df <- read.csv('data/noaa/USW00023271.csv')

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
avg_tmin_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)

#convert to data.frame
avg_tmin <- data.frame(year=as.integer(names(avg_tmin_vec)), 
                       tmin=avg_tmin_vec)

#run linear model
mod <- lm(tmin ~ year, data=avg_tmin)

#calculate slope of line with text for plot
slope <- round(coef(mod)[2] * 10, 2)
slope_text <- paste0('Slope = ', slope, 'F per decade')

#calculate R^2
r2 <- round(summary(mod)$adj.r.squared, 3)
r2_text <- paste0('italic(R) ^ 2 ==', r2)

#plot of Tmin over time
tmin_plot <- ggplot(data=avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Sacramento',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1884, y=46, label=slope_text, size=5, hjust=0) +
  annotate('text', x=1884, y=45, label=r2_text, size=5, hjust=0, parse=TRUE) +
  theme_bw(14)

#save plot
png(filename='plots/original/sacramento_tmin.png')
tmin_plot
dev.off()


# Red Bluff ---------------------------------------------------------------

df <- read.csv('data/noaa/USW00024216.csv')

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
avg_tmin_vec <- tapply(winter$tmin, winter$year_mod, mean, na.rm=TRUE)

#convert to data.frame
avg_tmin <- data.frame(year=as.integer(names(avg_tmin_vec)), 
                       tmin=avg_tmin_vec)

#run linear model
mod <- lm(tmin ~ year, data=avg_tmin)

#calculate slope of line with text for plot
slope <- round(coef(mod)[2] * 10, 2)
slope_text <- paste0('Slope = ', slope, 'F per decade')

#calculate R^2
r2 <- round(summary(mod)$adj.r.squared, 3)
r2_text <- paste0('italic(R) ^ 2 ==', r2)

#plot of Tmin over time
tmin_plot <- ggplot(data=avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Red Bluff',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1941, y=46, label=slope_text, size=5, hjust=0) +
  annotate('text', x=1941, y=45, label=r2_text, size=5, hjust=0, parse=TRUE) +
  theme_bw(14)

#save plot
png(filename='plots/original/redbluff_tmin.png')
tmin_plot
dev.off()
