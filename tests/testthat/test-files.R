# tests
# file can be opened
# file create.modes work
# file can be closed
# file catalog can be accessed

test_that("new can be opened and closed", {
  testFilename = tempfile(fileext=".db")

  testFile = openEnsemblesFile(testFilename, mode="new")

  expect_identical(.jclass(testFile), "hec.SqliteDatabase")

  # close the first time should succeed, return null
  expect_null(closeEnsemblesFile(testFile))

  # close the second time should fail
  expect_error(closeEnsemblesFile(testFile))
})


test_that("existing file can be opened", {
  watFile <- openEnsemblesFile("C:\\Projects\\Prado_WAT_FIRO_Dev\\Watersheds\\PradoCaseStudy_2022-06-30\\runs\\Testing\\RTestTWM\\realization 1\\lifecycle 1\\event 1\\ensembles.db", mode="append")
  expect_s4_class(watFile, "jobjRef")
  watFile
})
