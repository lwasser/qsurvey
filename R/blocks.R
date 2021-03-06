utils::globalVariables(c(".", "block_description", "block_randomization", "block_id"))

#' Get block ids, descriptions, and elements
#'
#' Retrieve each block's \code{id}, as generated by Qualtrics, and
#' \code{description}, as assigned by the user in the control panel. Optionally,
#' if argument \code{elements = TRUE}, \code{blocks} also shows the elements of
#' each block (questions and page breaks), in a long table of block-element
#' pairs.
#'
#' @inheritParams choices
#' @param elements Show the elements of each block, or don't (default).
#'
#' @return A table giving the \code{block_id} and \code{block_description} of
#' each block, and optionally its elements.
#' @seealso \code{\link{choices}}, \code{\link{questions}}
#' @export
blocks <- function(design_object, elements = FALSE) {

  assert_is_design(design_object)
  block_list <- lapply(design_object$blocks, function(x) {
    data.table::rbindlist(x[["elements"]], fill = TRUE)[,
      block_description := x[["description"]]][,
      block_randomization := paste(unlist(x[["randomization"]]), collapse = ", ")]
  })
  block_tbl <- data.table::rbindlist(block_list, use.names = TRUE, fill = TRUE,
    idcol = "block_id")
  format_blocks(block_tbl)
  if (!isTRUE(elements)) {
    block_tbl <- unique(block_tbl, by = "block_id")[, .(block_id, block_description)]
  }
  block_tbl[]
}

format_blocks <- function(tbl) {

  data.table::setnames(tbl, c("type", "questionId"), c("element_type",
      "question_id"))
  set_first_cols(tbl, c("block_id", "block_description", "element_type",
      "question_id"))
}

set_first_cols <- function(tbl, cols) {

  data.table::setcolorder(tbl, union(cols, names(tbl)))
}

