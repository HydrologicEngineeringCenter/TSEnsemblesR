

#' Manage records in file
#'
#' @param filename
#'
#' @return data.frame of locations in file
#' @export
#'
#' @examples
getRecords <- function(filename){
  return(data.frame())
}

#' Manages records in file
#'
#' @param filename
#' @param location
#' @param parameter
#'
#' @export
#'
#' @examples
addRecord <- function(filename, location, parameter){
  recordID = .jnew("hec/RecordIdentifier", location, parameter)
}

#' Manages records in a file
#'
#' Deletes records from within a file
#'
#' @param filename
#' @param location
#' @param parameter
#'
#' @return true if successful
#' @export
#'
#' @examples
deleteRecord <-function(filename, location, parameter){
  # TODO implement deleteRecord
}
