######################
## Environment vectors

# Used for reference the same base data directory
rootDataDir <- "./dataset"


plot1 <- function() {
    
    # get dataset  
    dataset <- get_plotData()
 
    #open a PNG file for output
    png(filename="plot1.png", width=480, height=480, bg="transparent" )
    
    #create graphic  
    with(dataset, {
            hist(dataset$globalactivepower
                    ,main="Global Active Power"
                    ,xlab="Global Active Power (kilowatts)"
                    ,col="red"
                )
            }
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



#66638  1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000  
#69516  2/2/2007;23:58:00;3.658;0.220;239.610;15.200;0.000;1.000;17.000