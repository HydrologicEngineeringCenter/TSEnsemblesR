# Code to get metrics from database file

# accessing a metric
# note that TSIDs toString() will appear identical
# for(i in seq(length(ensembles.db$getMetricTimeSeriesIDs()$toArray()))){
#  +     tsid = ensembles.db $getMetricTimeSeriesIDs()$toArray()[[i]]
#  +     mcts = ensembles.db$getMetricCollectionTimeSeries(tsid)
# using toString here gives different pointers for mcts each time
# however issueDates is blank
#  +     print(mcts$type())
#  + }
