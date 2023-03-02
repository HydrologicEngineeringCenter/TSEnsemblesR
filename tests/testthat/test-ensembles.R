# Tests

test_that("ensemble can be created",{
  rec = createRecord("MyLocation", "MyParam")
  ts = newEnsembleTS(rec, "cfs", "inst", "usgs gaged flow")
  expect_identical(.jclass(ts), "hec.ensemble.EnsembleTimeSeries")
})
