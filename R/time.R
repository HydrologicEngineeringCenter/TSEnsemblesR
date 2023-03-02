
timeZone <- function(tzCode){
  return(.jcall("java/time/ZoneId", returnSig="Ljava/time/ZoneId;", "of", tzCode))
}

newTimestamp <- function(tsYear, tsMonth, tsDay, tsHour=0, tsSeconds=0, tz=timeZone("Z")){
  int0 = .jlong(0)
  issueDate = .jcall("java/time/ZonedDateTime", returnSig="Ljava/time/ZonedDateTime;", "of",
                     as.integer(tsYear), as.integer(tsMonth), as.integer(tsDay),
                     int0, int0, int0, int0, utc_zid)
}

durationDays <- function(days){
  .duration(days, "ofDays")
}

durationHours <- function(hours){
  .duration(days, "ofHours")
}

durationMinutes <- function(minutes){
  .duration(days, "ofMinutes")
}

# private function to wrap java
# units is really method name on the Duration class
.duration <- function(quantity, units){
  dur = .jcall("java/time/Duration", returnSig="Ljava/time/Duration;", units, .jlong(quantity))

}
