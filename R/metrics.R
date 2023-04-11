

#' Title
#'
#' @param mcts
#'
#' @return
#' @export
#'
#' @examples
metricTimeSeriesToDF <- function(mcts){

  # for(id in .jevalArray(mcts$getIssueDates()$toArray())){
  #   mcv = mcts$getMetricCollection(id)$getValues()
  #   for(i in 1:mcv$length){
  #     print(.jevalArray(mcv[[i]]))
  #   }
  # }

  require(plyr)
  ldply(.jevalArray(mcts$getIssueDates()$toArray()), function(id){
    mc = mcts$getMetricCollection(id)
    label = mc$metricStatisticsToString()
    #id2 = mc$getIssueDate()$toString()
    mcv = mc$getValues()
    ldply(1:mcv$length, function(i){
      data.frame(label, issueDate=.jTimestampToPOSIXct(id), value=.jevalArray(mcv[[i]]))
    })
  })
}
