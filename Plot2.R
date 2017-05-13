
# load data
source('power_consumption_Loading.R')

# open device
png(filename='plot2.png',width=480,height=480,units='px')

# plot data
plot(consumption$DateTime,consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

# close device
x<-dev.off()