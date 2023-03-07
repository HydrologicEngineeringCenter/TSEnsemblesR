
#' Functions to assist with TSEnsembles timestamps
#'
#' @param tzCode
#'
#' @return java object for timezone
#' @export
#'
#' @examples
.jTimezone <- function(tzCode){
  return(.jcall("java/time/ZoneId", returnSig="Ljava/time/ZoneId;", "of", tzCode))
}

#' Functions to assist with TSEnsembles timestamps
#'
#' @param tsYear
#' @param tsMonth
#' @param tsDay
#' @param tsHour
#' @param tsSeconds
#' @param tzID
#'
#' @return timestamp as ZoneDateTime object
#' @export
#'
#' @examples
newTimestamp <- function(tsYear, tsMonth, tsDay, tsHour=0, tsSeconds=0, tzID=.jTimezone("Z")){
  int0 = as.integer(0)
  issueDate = .jcall("java/time/ZonedDateTime", returnSig="Ljava/time/ZonedDateTime;", "of",
                     as.integer(tsYear), as.integer(tsMonth), as.integer(tsDay),
                     int0, int0, int0, int0, tzID)
}

#'  Functions to assist with TSEnsembles timestamps
#'
#' @param jTimestamp
#'
#' @return POSIXct from java ZonedDateTime object
#' @export
#'
#' @examples
.jTimestampToPOSIXct <- function(jTimestamp){
  tzID = jTimestamp$getZone()$getId()
  if(tzID == "Z"){
    tzID = "UTC"
  }
  return(as.POSIXct(jTimestamp$toEpochSecond(), origin="1970-01-01", tz=tzID))
}

#' Functions to assist with TSEnsembles timestamps
#'
#' @param days
#'
#' @return Java Duration object
#' @export
#'
#' @examples
durationDays <- function(days){
  .duration(days, "ofDays")
}

#' Functions to assist with TSEnsembles timestamps
#'
#' @param hours
#'
#' @return Java Duration object
#' @export
#'
#' @examples
durationHours <- function(hours){
  .duration(hours, "ofHours")
}

#' Functions to assist with TSEnsembles timestamps
#'
#' @param minutes
#'
#' @return Java Duration object
#' @export
#'
#' @examples
durationMinutes <- function(minutes){
  .duration(minutes, "ofMinutes")
}

# private function to wrap java
# units is really method name on the Duration class
.duration <- function(quantity, units){
  return(.jcall("java/time/Duration", returnSig="Ljava/time/Duration;", units, .jlong(quantity)))
}
