######################
## Environment vectors

# Used for reference the same base data directory
rootDataDir <- "./dataset"


plot3 <- function(data) {

    # get dataset  
    dataset <- get_plotData()
 
    #open a PNG file for output
    png(filename="plot3.png", width=480, height=480, bg="transparent" )
    
    #create graphic  
    with(dataset, {
            plot(dataset$datetime, dataset$submetering1
                    ,type="l"
                    ,ylab="Energy sub metering"
                    ,xlab=""
                )
            }
        )
        
    # Add additional lines
    with(subset(dataset),lines(datetime,submetering2,col="red"))
    with(subset(dataset),lines(datetime,submetering3,col="blue"))
    
    legend("topright" 
        , col = c("black","red","blue")
        , lwd=1
        , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
        )
        
    #close graphic device (PNG file)
    dev.off()




}


## Description:  'get_plotData function is for loading the dataset
##                  then referenced in merging with either the training data or the test data
## Input: none
## Returns: 'household power' dataset
get_plotData <- function() {

    # Build the filename
    dataFileLocation <- sprintf("%s/household_power_consumption.txt",rootDataDir)

    #Column names for the data
    dataColNames <- c('date','time','globalactivepower','globalreactivepower','voltage','globalintensity','submetering1','submetering2','submetering3')

    # Read data, only reads in rows within the project date range requirements
    dataset <- read.table(dataFileLocation, header=FALSE, sep=";",col.names=dataColNames,na.strings = "?",skip=66637,nrows=2879)
    
    # Create a single Date/Time column
    x <- paste(dataset$date, dataset$time)
    
    dataset$datetime <- strptime(x, "%d/%m/%Y %H:%M:%S") 
    
    # Return data
    dataset
}