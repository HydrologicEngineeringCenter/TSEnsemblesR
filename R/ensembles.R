# Read and write raw ensembles from file

#' Read
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
  return(.jnew("hec.ensemble.EnsembleTimeSeries", recordID, "cfs", "inst", "synthetic"))
}


#' Title
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
addEnsembleToTS <- function(ensembleTS, issueDate, ensembleArray, startDate, interval){
  .jcall(ensembleTS, returnSig="V", "addEnsemble", issueDate, ens_array, startDate, interval, "cfs")
}

# inverse function to deal with ensembles
toTidyEnsemble <- function(ensembleArray, startDate, interval, label=NULL){
  require(reshape2)
  # TODO convert array to tidy ensemble set
}
toEnsembleArray <- function(tidyEnsemble){
  require(reshape2)
}
