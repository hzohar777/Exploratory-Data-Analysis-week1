

# required packages
library(data.table)
library(lubridate)

# making sure the sources data folder exists
if (!file.exists('power_consumption folder')) {
  dir.create('power_consumption folder')
}

# check if existing or need to ceate...
if (!file.exists('power_consumption folder/power_consumption.txt')) {
  
  # download the and unzip
  file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(file.url,destfile='source data/power_consumption.zip')
  unzip('source data/power_consumption.zip',exdir='source data',overwrite=TRUE)

  # arrange 2 days data
  consumption.class<-c(rep('character',2),rep('numeric',7))
 consumption<-read.table('power_consumption folder/household_power_consumption.txt',header=TRUE,
                                sep=';',na.strings='?',colClasses=consumption.class)
  consumption<- consumption[ consumption$Date=='1/2/2007' |  consumption$Date=='2/2/2007',]

  # clean up  
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
          'SubMetering1','SubMetering2','SubMetering3')
  colnames( consumption)<-cols
   consumption$DateTime<-dmy( consumption$Date)+hms consumption$Time)
   consumption<- consumption[,c(10,3:9)]
  
  # write  clean data back to the data folder
  write.table( consumption,file='power_consumption folder/power_consumption.txt',sep='|',row.names=FALSE)
} else {
  
   consumption<-read.table('source data/power_consumption.txt',header=TRUE,sep='|')
   consumption$DateTime<-as.POSIXlt( consumption$DateTime)

}

# remove the large raw data set 
if (file.exists('power_consumption folder/household_power_consumption.txt')) {
  x<-file.remove('power_consumption folder/household_power_consumption.txt')
}