utils::globalVariables(c("choice"))

#' Get item response choices
#'
#' Request a table giving the response choices for each survey item.
#'
#' @inheritParams responses
#' @return A data.table of response choices
#' @importFrom utils type.convert
#' @export
choices = function(id) {
  design = design(id)
  choices = lapply(design$questions, function(x) {
    lapply(x[["choices"]], function(l) {
      parse_question_element(l)
    })
  })
  choices = parse_choices(choices)
  return(choices[])
}

parse_choices = function(choices) {
  # choices is a list of lists: there is a list for each survey item, and each
  # of these lists contains a list for each available choice
  x = data.table::rbindlist(lapply(choices, unlist, recursive = FALSE),
    fill = TRUE, idcol = "question")
  # x is now a wide table with columns like 9.description, 9.choiceText...
  x = data.table::melt(x,
    id.vars = "question",
    variable.name = "choice",
    na.rm = TRUE)
  # split e.g. 9.description into a choice number and key
  x[, c("choice", "key") := data.table::tstrsplit(x$choice, "\\.")]
  x = data.table::dcast.data.table(x, question + choice ~ key, value.var = "value")
  # we want a numeric sort on choice number
  x[, choice := type.convert(choice)]
  data.table::setkeyv(x, c("question", "choice"))
  return(x[])
}
