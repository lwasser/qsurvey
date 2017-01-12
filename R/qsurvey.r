#' The qsurvey package: overview
#'
#' qsurvey is a toolkit for working with the Qualtrics survey platform and its data
#' in R. It focuses on testing and review of surveys before fielding, and analysis
#' of responses afterward. 
#'
#' \itemize{
#' \item Examine branching, randomization, and question attributes
#' \item Represent survey flows as directed graphs for plotting or interactive
#' review in Shiny
#' \item Download and manipulate response data
#' }
#'
#' For more see the \href{http://jdunham.io/qsurvey}{project site}.
#'
#' A
#' \href{https://www.qualtrics.com/support/integrations/api-integration/api-integration}{Qualtrics API key}
#' is needed to communicate with the survey platform. Set the environment
#' variable \code{QUALTRICS_KEY} to your key value. You can do this
#' \link[=Startup]{during R startup} (recommended), interactively with
#' \code{\link[base]{Sys.setenv}}, or through \code{\link{key_from_file}}.
#'
#' @name qsurvey
#' @docType package
#' @import assertthat data.table
NULL