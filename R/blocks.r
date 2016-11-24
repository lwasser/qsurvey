#' Get block ids, descriptions, and elements
#'
#' Retrieve each block's \code{id}, as generated by Qualtrics, and
#' \code{description}, as assigned by the user in the control panel. Optionally,
#' if argument \code{elements = TRUE}, \code{blocks} also shows the elements of
#' each block (questions and page breaks), in a long table of block-element
#' pairs.
#'
#' @inheritParams choices
#'
#' @return A data.table giving the \code{block_id} and \code{block_description}
#' of each block, and optionally its elements.
#' @export
blocks = function(design, elements = FALSE) {

  assert_is_design(design)
  block_list = lapply(design$blocks, function(x) {
    # TODO: Generalize this parsing? 1. lapply over an element's children
    # rbindlisting over their children; 2. rbindlist over the return from the
    # lapply
    data.table::rbindlist(x[["elements"]], fill = TRUE)[,
      block_description := x[["description"]]][,
      block_randomization := paste(unlist(x[["randomization"]]), collapse = ", ")]
  })
  block_tbl =
    data.table::rbindlist(block_list, use.names = TRUE, fill = TRUE, idcol = "block_id")
  # FIXME: fragile
  data.table::setnames(block_tbl,
    c("type", "questionId"),
    c("element_type", "question_id"))
  data.table::setcolorder(block_tbl, union(
    c(
      "block_id",
      "block_description",
      "element_type",
      "question_id"
    ),
    names(block_tbl)
  ))
  if (!isTRUE(elements)) {
    block_tbl = unique(block_tbl, by = "block_id")[, .(block_id, block_description)]
  }
  block_tbl[]
}
