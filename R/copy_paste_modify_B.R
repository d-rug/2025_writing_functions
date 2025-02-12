library('ggplot2')
library('lubridate')

chula <- read.csv('data/noaa/USC00041758.csv')
yosemite <- read.csv('data/noaa/USC00043939.csv')
bay <- read.csv('data/noaa/USC00044500.csv')
tulare <- read.csv('data/noaa/USC00044890.csv')
redbluff <- read.csv('data/noaa/USW00024216.csv')
sac <- read.csv('data/noaa/USW00023271.csv')

names(chula) <- tolower(names(chula))
names(yosemite) <- tolower(names(yosemite))
names(bay) <- tolower(names(bay))
names(tulare) <- tolower(names(tulare))
names(redbluff) <- tolower(names(redbluff))
names(sac) <- tolower(names(sac))

chula <-chula[!is.na(chula$tmin), ]
yosemite <- yosemite[!is.na(yosemite$tmin), ]
bay <- bay[!is.na(bay$tmin), ]
tulare <- tulare[!is.na(tulare$tmin), ]
redbluff <- redbluff[!is.na(redbluff$tmin), ]
sac <- sac[!is.na(sac$tmin), ]

chula$month <- month(chula$date)
yosemite$month <- month(yosemite$date)
bay$month <- month(bay$date)
tulare$month <- month(tulare$date)
redbluff$month <- month(redbluff$date)
sac$month <- month(sac$date)

chula$year <- year(chula$date)
yosemite$year <- year(yosemite$date)
bay$year <- year(bay$date)
tulare$year <- year(tulare$date)
redbluff$year <- year(redbluff$date)
sac$year <- year(sac$date)

cvwinter <- chula[chula$month %in% c(12, 1, 2), ]
ywinter <- yosemite[yosemite$month %in% c(12, 1, 2), ]
nb_winter <- bay[bay$month %in% c(12, 1, 2), ]
t_winter <- tulare[tulare$month %in% c(12, 1, 2), ]
rb_winter <- redbluff[redbluff$month %in% c(12, 1, 2), ]
sac_winter <- sac[sac$month %in% c(12, 1, 2), ]

cvwinter$year_mod <- ifelse(cvwinter$month==12, cvwinter$year+1, cvwinter$year)
ywinter$year_mod <- ifelse(ywinter$month==12, ywinter$year+1, ywinter$year)
nb_winter$year_mod <- ifelse(nb_winter$month==12, nb_winter$year+1, nb_winter$year)
t_winter$year_mod <- ifelse(t_winter$month==12, t_winter$year+1, t_winter$year)
rb_winter$year_mod <- ifelse(rb_winter$month==12, rb_winter$year+1, rb_winter$year)
sac_winter$year_mod <- ifelse(sac_winter$month==12, sac_winter$year+1, sac_winter$year)

cv_avg_tmin_vec <- tapply(cvwinter$tmin, cvwinter$year_mod, mean, na.rm=TRUE)
y_avg_tmin_vec <- tapply(ywinter$tmin, ywinter$year_mod, mean, na.rm=TRUE)
nb_avg_tmin_vec <- tapply(nb_winter$tmin, nb_winter$year_mod, mean, na.rm=TRUE)
t_avg_tmin_vec <- tapply(t_winter$tmin, t_winter$year_mod, mean, na.rm=TRUE)
rb_avg_tmin_vec <- tapply(rb_winter$tmin, rb_winter$year_mod, mean, na.rm=TRUE)
sac_avg_tmin_vec <- tapply(sac_winter$tmin, sac_winter$year_mod, mean, na.rm=TRUE)

cv_avg_tmin <- data.frame(year=as.integer(names(cv_avg_tmin_vec)), 
                          tmin=cv_avg_tmin_vec)
y_avg_tmin <- data.frame(year=as.integer(names(y_avg_tmin_vec)), 
                       tmin=y_avg_tmin_vec)
nb_avg_tmin <- data.frame(year=as.integer(names(nb_avg_tmin_vec)), 
                       tmin=nb_avg_tmin_vec)
t_avg_tmin <- data.frame(year=as.integer(names(t_avg_tmin_vec)), 
                       tmin=t_avg_tmin_vec)
rb_avg_tmin <- data.frame(year=as.integer(names(rb_avg_tmin_vec)), 
                       tmin=rb_avg_tmin_vec)
sac_avg_tmin <- data.frame(year=as.integer(names(sac_avg_tmin_vec)), 
                       tmin=sac_avg_tmin_vec)

cv_mod <- lm(tmin ~ year, data=cv_avg_tmin)
y_mod <- lm(tmin ~ year, data=y_avg_tmin)
nb_mod <- lm(tmin ~ year, data=nb_avg_tmin)
t_mod <- lm(tmin ~ year, data=t_avg_tmin)
rb_mod <- lm(tmin ~ year, data=rb_avg_tmin)
sac_mod <- lm(tmin ~ year, data=sac_avg_tmin)


cv_slope <- round(coef(cv_mod)[2] * 10, 2)
y_slope <- round(coef(y_mod)[2] * 10, 2)
nb_slope <- round(coef(nb_mod)[2] * 10, 2)
t_slope <- round(coef(t_mod)[2] * 10, 2)
rb_slope <- round(coef(rb_mod)[2] * 10, 2)
sac_slope <- round(coef(sac_mod)[2] * 10, 2)

cv_slope_text <- paste0('Slope = ', cv_slope, 'F per decade')
y_slope_text <- paste0('Slope = ', y_slope, 'F per decade')
nb_slope_text <- paste0('Slope = ', nb_slope, 'F per decade')
t_slope_text <- paste0('Slope = ', t_slope, 'F per decade')
rb_slope_text <- paste0('Slope = ', rb_slope, 'F per decade')
sac_slope_text <- paste0('Slope = ', sac_slope, 'F per decade')


# chula vista -------------------------------------------------------------

cv_tmin_plot <- ggplot(data=cv_avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Chula Vista',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=cv_slope_text, size=5, hjust=0) +
  theme_bw(14)

png(filename='plots/original/chula_vista_tmin.png')
  cv_tmin_plot
dev.off()


# Yosemite ----------------------------------------------------------------

y_tmin_plot <- ggplot(data=y_avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Yosemite',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=y_slope_text, size=5, hjust=0) +
  theme_bw(14)

png(filename='plots/original/yosemite_tmin.png')
y_tmin_plot
dev.off()


# North Bay ---------------------------------------------------------------

nb_tmin_plot <- ggplot(data=nb_avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: North Bay',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=nb_slope_text, size=5, hjust=0) +
  theme_bw(14)

png(filename='plots/original/north_bay_tmin.png')
nb_tmin_plot
dev.off()


# Tulare ------------------------------------------------------------------

t_tmin_plot <- ggplot(data=t_avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Tulare',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=t_slope_text, size=5, hjust=0) +
  theme_bw(14)

png(filename='plots/original/tulare_tmin.png')
t_tmin_plot
dev.off()


# Red Bluff ---------------------------------------------------------------

rb_tmin_plot <- ggplot(data=rb_avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Red Bluff',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=rb_slope_text, size=5, hjust=0) +
  theme_bw(14)

png(filename='plots/original/red_bluff_tmin.png')
rb_tmin_plot
dev.off()


# Sacramento --------------------------------------------------------------


sac_tmin_plot <- ggplot(data=sac_avg_tmin, aes(x=year, y=tmin)) +
  geom_point(color='navy') + 
  geom_smooth(formula='y~x', method='lm') +
  labs(title='Average Winter Minimum Temperature: Sacramento',
       x='Year',
       y='Temperature (Fahrenheit)') +
  annotate('text', x=1925, y=50, label=sac_slope_text, size=5, hjust=0) +
  theme_bw(14)

png(filename='plots/original/sacramento_tmin.png')
sac_tmin_plot
dev.off()