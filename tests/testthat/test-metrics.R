test_that("SqliteDatabase.java test", {
  tempDbDir = tempdir()
  file.copy("./data/ResSimTest_20200101.db", tempDbDir)
  db = openEnsemblesFile(paste0(tempDbDir, "\\ResSimTest_20200101.db"), mode="open")
  id = .jnew("hec.RecordIdentifier", "Kanektok.BCAC1", "flow")
  ets = db$getEnsembleTimeSeries(id)
  cumulativeComputable = .jnew("hec.ensemble.stats.CumulativeComputable")
  cumulative = new(J("hec.ensemble.stats.NDayMultiComputable"), cumulativeComputable, as.integer(2))
  percentileCompute = new(J("hec.ensemble.stats.PercentilesComputable"), .jfloat(0.95))
  twoStep = .jcast(new(J("hec.ensemble.stats.TwoStepComputable"), cumulative, percentileCompute, FALSE), new.class="hec/ensemble/stats/SingleComputable", check=T)
  #twoStep = .jnew("hec.ensemble.stats.TwoStepComputable", cumulative, percentileCompute, FALSE)
  #.jmethods(ets, "computeSingleValueSummary")
  #output = .jcall(ets, returnSig="hec/metrics/MetricCollectionTimeSeries", method="computeSingleValueSummary", twoStep)
  output = ets$computeSingleValueSummary(.jcast(twoStep, "hec/ensemble/stats/SingleComputable", check=T))
  db$write(output)

  ids = db$getMetricTimeSeriesIDs()
  mcts = db$getMetricCollectionTimeSeries(ids$toArray()[[1]])
  expect_equal(3, mcts$getIssueDates()$size())
})

test_that("read metrics", {
  # test that metrics can be read from single metric file
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

  #require(TSEnsemblesR)
  openEnsemblesFile("./data/ensembles.db") -> multi_metric_ensembles.db
  openEnsemblesFile("./data/single_metric_ensembles.db") -> single_metric_ensembles.db
  .jnew("hec.RecordIdentifier", "ADOC", "FLOW") -> recID
  multi_metric_ensembles.db$getMetricCollectionIssueDates(recID)
  single_metric_ensembles.db$getMetricCollectionIssueDates(recID)
  single_metric_ensembles.db$getMetricCollectionTimeSeries(recID) -> mcts
  #mcts$getIssueDates()$size()

  #metricTimeSeriesToDF(multi_metric_ensembles.db$getMetricCollectionTimeSeries(recID))
  tsids = multi_metric_ensembles.db$getMetricTimeSeriesIDs()

  for(tsid in as.list(tsids)){
    for(stat in multi_metric_ensembles.db$getMetricStatistics(tsid)){
      mcts = multi_metric_ensembles.db$getMetricCollectionTimeSeries(tsid, statistic)
      print(head(metricTimeSeriesToDF(mcts)))
    }
  }

})
