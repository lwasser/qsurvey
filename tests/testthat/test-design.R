test_that("survey_design is a qualtrics_design object with expected elements", {
  svy_tbl <- surveys()
  lapply(svy_tbl$id, function(id) {

    expect_silent(d <- design(id))
    expect_is(d, "qualtrics_design")

    expect_named(d, c("id", "name", "ownerId", "organizationId",
        "isActive", "creationDate", "lastModifiedDate", "expiration",
        "questions", "exportColumnMap", "blocks", "flow", "embeddedData",
        "comments", "responseCounts", "json"), ignore.order = TRUE)

    for (char_element in c("id", "name", "ownerId", "organizationId",
        "creationDate", "lastModifiedDate")) {
      expect_is(d[[char_element]], "character")
    }

    expect_is(d$isActive, "logical")

    for (list_element in c("expiration", "questions", "exportColumnMap", "blocks",
        "flow", "embeddedData", "comments", "responseCounts")) {
      expect_is(d[[list_element]], "list")
    }

    expect_named(d$expiration, c("startDate", "endDate"), ignore.order = TRUE) 

    lapply(d$questions, function(q_element) {
      expect_is(q_element, "list")
      expect_true(all(c("questionType", "questionText", "questionLabel", "validation")
        %in% names(q_element)))
      # choices too, dpeending on question type
      # str(q_element, 1)
    })
    # str(d$questions, 1)
    # str(d$questions[[1]], 1)
    # str(d$questions[[26]], 1)
  })
})

test_that("survey_design stops if id isn't a string", {
  expect_error(design(2), "id is not a string")
})
