# tests
# file can be opened
# file create.modes work
# file can be closed
# file catalog can be accessed

test_that("file can be opened and closed", {
  testFilename = tempfile(fileext=".db")

  testFile = openEnsemblesFile(testFilename)

  expect_identical(.jclass(testFile), "hec.SqliteDatabase")

  # close the first time should succeed, return null
  expect_null(closeEnsemblesFile(testFile))

  # close the second time should fail
  expect_error(closeEnsemblesFile(testFile))
})
