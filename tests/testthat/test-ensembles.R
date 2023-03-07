# Tests

test_that("ensemble can be created",{
  rec = createRecord("MyLocation", "MyParam")
  versionString = "forecasted flow"
  ts = newEnsembleTS(rec, "cfs", "inst", versionString)
  expect_identical(.jclass(ts), "hec.ensemble.EnsembleTimeSeries")
  expect_identical(ts$getVersion(), versionString)
})

test_that("ensemble can be populated", {
  rec = createRecord("MyLocation", "MyParam")
  ts = newEnsembleTS(rec, "cfs", "inst", "forecasted flow")
  #expect_identical(.jclass(ts), "hec.ensemble.EnsembleTimeSeries")
  issueDate = newTimestamp(2018, 5, 2)
  startDate = newTimestamp(2018, 5, 3)
  # Note we are reusing the same timestamps in the same TS object. - maybe this is a BAD idea?

  # 2x2
  inVals = matrix(seq(1,4), nrow=2)
  addEnsembleToTS(ts, issueDate, startDate, durationDays(1), inVals)
  outVals = .jevalArray(ts$getEnsemble(issueDate)$getValues(), simplify=TRUE)
  expect_equal(matrix(outVals, nrow=nrow(outVals)), inVals)
  expect_equal(dim(outVals), dim(inVals))

  # 4x1
  inVals = matrix(seq(1,4), nrow=1)
  addEnsembleToTS(ts, issueDate, startDate, durationDays(1), inVals)
  outVals = .jevalArray(ts$getEnsemble(issueDate)$getValues(), simplify=TRUE)
  expect_equal(matrix(outVals, nrow=nrow(outVals)), inVals)
  expect_equal(dim(outVals), dim(inVals))

  # 1x4
  inVals = matrix(seq(1,4), nrow=4)
  addEnsembleToTS(ts, issueDate, startDate, durationDays(1), inVals)
  outVals = .jevalArray(ts$getEnsemble(issueDate)$getValues(), simplify=TRUE)
  expect_equal(matrix(outVals, nrow=nrow(outVals)), inVals)
  expect_equal(dim(outVals), dim(inVals))

  # larger data tests

  # random 68x14
  inVals = matrix(rnorm(68*14), nrow=14)
  addEnsembleToTS(ts, issueDate, startDate, durationDays(1), inVals)
  outVals = .jevalArray(ts$getEnsemble(issueDate)$getValues(), simplify=TRUE)
  # I don't know if this is a good way to compare these, there appears to be some float error < 1e-6 with random numbers
  expect_lt(max(matrix(outVals, nrow=nrow(outVals)) - inVals), 1e-06)
  expect_equal(dim(outVals), dim(inVals))

  # random 68*(14*24) for hourly data
  inVals = matrix(rnorm(68*14*24), nrow=14*24)
  addEnsembleToTS(ts, issueDate, startDate, durationHours(1), inVals)
  outVals = .jevalArray(ts$getEnsemble(issueDate)$getValues(), simplify=TRUE)
  # I don't know if this is a good way to compare these, there appears to be some float error < 1e-6 with random numbers
  expect_lt(max(matrix(outVals, nrow=nrow(outVals)) - inVals), 1e-06)
  expect_equal(dim(outVals), dim(inVals))

})


test_that("existing file can be opened and ensemble read into array",{
  # open a test file
})

test_that("existing file can be opened and ensemble(s) read into tidy data.frame",{
  # open a test file and use getTidyEnsembles
})

test_that("ensemble can be tidyed", {
  # check dimensions
  # check counts of unique values in members, timestamps, value columns
  # check that values have the right member and timestamps
})

test_that("ensemble can be cast back to an array", {
  # check dimensions
  # check values in the right locations (e.g. don't transpose data)
})
