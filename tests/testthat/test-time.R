# create timezone for GMT
test_that("get timezone obj",{
  tz = timeZone("Z")
  expect_identical(.jclass(tz), "java.time.ZoneOffset")
})

# create timezone with system local
test_that("get timezone obj",{
  # who knows if this works outside of windows? or America/Los_Angeles?
  tz = timeZone(Sys.timezone())
  expect_identical(.jclass(tz), "java.time.ZoneOffset")
  expect_identical(tz$toString, Sys.timezone())
})

# create timestamp
test_that("create timestamp",{
  require(lubridate)
  time = newTimestamp(2018, 5, 2, tz=timeZone("America/Los_Angeles"))
})

# create duration for 1 day
# create duration for 1 hour
# create duration for 2 hours
# create duration for 6 hours
# create duration for 360 minutes


