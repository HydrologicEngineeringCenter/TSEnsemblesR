# create timezone for GMT
test_that("get timezone obj",{
  tz = .jTimezone("Z")
  expect_identical(.jclass(tz), "java.time.ZoneOffset")
})

# create timezone with system local
test_that("get timezone obj",{
  # who knows if this works outside of windows? or America/Los_Angeles?
  tz = .jTimezone(Sys.timezone())
  expect_identical(.jclass(tz), "java.time.ZoneRegion")
  expect_identical(tz$toString(), Sys.timezone())
})

# create timestamp
test_that("create timestamp",{
  time = newTimestamp(2018, 5, 2, tzID=.jTimezone("America/Los_Angeles"))
  expect_equal(time$getYear(), 2018)
  expect_equal(time$getMonth()$getValue(), 5)
  expect_equal(time$getDayOfMonth(), 2)
  expect_equal(time$getHour(), 0)
  expect_equal(time$getMinute(), 0)
})

test_that("create duration", {
  # test base storage in seconds
  expect_equal(durationDays(1)$getSeconds(), 24*60*60)
  expect_equal(durationHours(1)$getSeconds(), 60*60)
  expect_equal(durationMinutes(1)$getSeconds(), 60)
  # test some conversions
  expect_equal(durationDays(3)$toDays(), 3)
  expect_equal(durationHours(6)$toMinutes(), 6*60)
  expect_equal(durationMinutes(15)$toSeconds(), 15*60)
})

