utils::globalVariables(c(".", "export_label", "question"))

#' Get survey questions
#'
#' Retrieve the names, labels, and text of a given survey's questions.
#'
#' @inheritParams choices
#' @param labels Retrieve question labels (default), or don't.
#' @param text Retrieve question text (default), or don't.
#'
#' @return A data.table of question names, labels, and (optionally) text
#' @seealso Retrieve a survey's question \code{\link{choices}} or
#'   \code{\link{responses}}.
#' @export
questions = function(design, labels = TRUE, text = TRUE) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  elements = "questionLabel"
  if (isTRUE(text)) {
    elements = c(elements, "questionText")
  }
  questions = lapply(design$questions, function(x) {
    parse_question_element(x[elements])
  })
  questions = data.table::rbindlist(questions, fill = TRUE, idcol = "question")
  if (isTRUE(labels)) {
    col_map = data.table::rbindlist(design$exportColumnMap, idcol = "export_label",
      fill = TRUE)[, .(export_label, question)]
    col_map = unique(col_map, by = "question")
    questions = merge(questions,
      col_map,
      all.x = TRUE,
      all.y = FALSE,
      by = "question")
  }
  return(questions[])
}

parse_question_element = function(l) {
  # Missing elements will be NULL in json but must be NA in data.table output
  lapply(l, function(x) {
    x = ifelse(is.null(x), NA, x)
    # Also drop HTML tags from question text
    gsub("(<[^>]*>)", "", x)
  })
}
