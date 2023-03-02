# records can be created
test_that("records created", {
  myLoc = "Raccoon Creek at Swedesboro, NJ"
  myParam = "Stage"
  rec = createRecord(myLoc, myParam)
  expect_identical(rec$toString(), paste(myLoc, myParam, sep="/"))
})

# records can be listed in a file
