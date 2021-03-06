% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/choices.R
\name{choices}
\alias{choices}
\title{Get survey response choices}
\usage{
choices(design_object)
}
\arguments{
\item{design_object}{A \code{\link{qualtrics_design-class}} object retrieved
from Qualtrics by \code{\link{design}}.}
}
\value{
A table of response choices.
}
\description{
Retrieve a table giving the response choices for each close-ended question in
a survey. Text-entry and other question types without predefined choices are
omitted.
}
\seealso{
\code{\link{blocks}}, \code{\link{questions}}
}

