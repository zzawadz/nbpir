% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inflation.R
\name{nbp_read_inflation}
\alias{nbp_read_inflation}
\title{Title}
\usage{
nbp_read_inflation(path, interval = c("monthly", "quarterly", "annual"),
  type = c("previous", "corresponding"))
}
\arguments{
\item{path}{path to the file containing inflation data downloaded fromo NBP website. See the \code{\link{nbp_inflation_download}} function.}

\item{interval}{date interval. Can be monthly (default), quarterly or annual.}

\item{type}{select method of calculation. 'previous' (default) returns data in relation to the previous month. 'corresponding' returns the values in relation
to the corresponding interval from previous year.}
}
\description{
Title
}
\examples{

path <- nbp_inflation_download()
nbp_read_inflation(path)
nbp_read_inflation(path, type = "corresponding")

nbp_read_inflation(path, interval = "quarterly")
nbp_read_inflation(path, interval = "annual")

}
