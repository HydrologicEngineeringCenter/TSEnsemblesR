# Read and write raw ensembles from file

#' Ensemble Timeseries Functions
#'
#' @param record
#' @param units
#' @param type
#' @param version
#'
#' @return
#' @export
#'
#' @examples
newEnsembleTS <- function(record, units, type, version){
  return(.jnew("hec.ensemble.EnsembleTimeSeries", record, units, type, version)) #, class.loader=.rJava.class.loader))
}


#' Ensemble Timeseries Functions
#'
#' @param ensembleTS ensemble timeseries to add ensemble to
#' @param issueDate date for which ensemble should be added
#' @param ensembleArray data
#' @param startDate date on which ensemble values starts
#' @param interval duration object representing interval between values in forecast
#'
#' @return void
#' @export
#'
#' @examples
addEnsembleToTS <- function(ensembleTS, issueDate, startDate, interval, ensembleArray, units=NULL){
  if(is.null(units)) units=ensembleTS$getUnits()
  ensembleArray = .jarray(.jfloat(ensembleArray), dispatch=TRUE)
  .jcall(ensembleTS, returnSig="V", "addEnsemble", issueDate, ensembleArray, startDate, interval, units)
}


#' Ensemble Timeseries Functions
#'
#' @param ensembleTS
#'
#' @return
#' @export
#'
#' @examples
getIssueDates <- function(ensembleTS){
  ensembleTS$getIssueDates()
}

#' Ensemble Timeseries Functions
#'
#' @param ensembleTS
#' @param timestamp
#'
#' @return
#' @export
#'
#' @examples
getEnsembleAtTime <- function(ensembleTS, issueDate, toMatrix=TRUE){
  outVals = .jevalArray(ensembleTS$getEnsemble(issueDate)$getValues(), simplify=TRUE)
  if(toMatrix){
    return(matrix(outVals, nrow=nrow(outVals)))
  } else {
    return(outVals)
  }
}

# Get one ensemble set
#' Ensemble Timeseries Functions
#'
#' @param ensembleTS
#' @param issueDate
#' @param paramLabel
#' @param addMetadata
#'
#' @return a tidy ensemble for `issueDate`
#' @export
#'
#' @examples
getTidyEnsembleAtTime <- function(ensembleTS, issueDate, paramLabel=NULL, addMetadata=TRUE){
  if(is.null(paramLabel)){
    paramLabel = ensembleTS$getTimeSeriesIdentifier()$parameter
  }
  ens = getEnsembleAtTime(ensembleTS, issueDate)
  #colnames(ens) <- paste0("member.", seq(ncol(ens)))
  #colnames(ens) <- seq(ncol(ens))
  startTime = ensembleTS$getEnsemble(issueDate)$getStartDateTime()
  ensInterval = ensembleTS$getEnsemble(issueDate)$getInterval()
  ensDF = toTidyEnsemble(ens, startTime, ensInterval, paramLabel)
  if(addMetadata){
    ensDF$location = ensembleTS$getTimeSeriesIdentifier()$location
    ensDF$verison = ensembleTS$getVersion()
  }
  return(ensDF)
}

# get all ensembles
#' Ensemble Timeseries Functions
#'
#' @param ensembleTS
#'
#' @return tidy data.frame of ensembles for all issue dates in ensembleTS
#' @export
#'
#' @examples
getTidyEnsembles <- function(ensembleTS){
  # repeat for all issue dates
  ensembleDFs = lapply(ensembleTS$getIssueDates(), function(id){
    ensDF = getTidyEnsembleAtTime(ensembleTS, id)
    ensDF$IssueDate = jTimestampToPOSIXct(id)
    ensDF
  } )
  do.call(rbind, ensembleDFs)
}


#' Ensemble Timeseries Functions
#'
#' @param tidyEnsemble
#'
#' @return an array in format stored inside of TSEnsembles, can be written to file
#' @export
#'
#' @examples
toEnsembleArray <- function(tidyEnsemble){
  require(reshape2)
  #  function(ensembleTS, issueDate, startDate, interval, ensembleArray, units=NULL)
  tidyEnsemble$timestamp = as.numeric(tidyEnsemble$timestamp)
  acast(tidyEnsemble, timestamp ~ ensemble.member, value.var="Flow")
}


# requires more metadata if not pulling directly from file
#' Ensemble Timeseries Functions
#'
#' @param arrayEnsemble
#' @param startTime
#' @param interval
#' @param paramLabel
#'
#' @return tidy data.frame format containing the ensemble array with timestamps
#' @export
#'
#' @examples
toTidyEnsemble <- function(arrayEnsemble, startTime, interval, paramLabel){
  require(reshape2)
  timestamps <- lapply(seq(nrow(arrayEnsemble))-1, function(x) .jTimestampToPOSIXct(startTime$plus(interval$multipliedBy(.jlong(x)))))
  ensDF = melt(arrayEnsemble, varnames=c("timestamp", "ensemble.member"), value.name=paramLabel)
  ensDF$timestamp = timestamps[ensDF$timestamp] # this is a fast way to transform them - stays as POSIXct objs
  return(ensDF)
}

