#' Download interest rates from Polish National Bank
#'
#' This functions download various interest rates from NBP (Polish National Bank) as a xts object.
#'
#' @param types DESCRIPTION.
#'
#' @return xts object.
#' @export
#' @importFrom xml2 read_xml xml_find_all xml_attr xml_parent
#' @importFrom lubridate ymd
#' @examples
#'
#' get_interest_rates("ref")
#' get_interest_rates(c("ref","lom"))
#'
get_interest_rates = function(types = c("ref","lom","dep","red"))
{
  xmlData = read_xml("http://www.nbp.pl/xml/stopy_procentowe_archiwum.xml")

  .get_rates = function(type = "ref")
  {
    dt = xml_find_all(xmlData, sprintf("//pozycja[@id='%s']", type))
    rates = as.numeric(gsub(xml_attr(dt, "oprocentowanie"), pattern = ",", replacement = "."))
    dates = xml_attr(xml_parent(dt), "obowiazuje_od")
    x = xts(rates, order.by = ymd(dates))
    colnames(x) = type
    x
  }

  allRes = lapply(types, .get_rates)
  Reduce(cbind, allRes)
}


#' Expand xts do daily periodicity.
#'
#' FUNCTION DESCRIPTION
#'
#' @param x xts object
#' @param enddate last date.
#'
#' @return RETURN DESCRIPTION
#' @examples
#' # ADD EXAMPLES HERE
expand_daily = function(x, enddate = "today")
{
  if(enddate == "today")
  {
    enddate = today()
  } else
  {
    enddate = ymd(enddate)
  }

  start = index(x)[1]
  x = x[paste(index(x)[1], enddate, sep = "/")]

  dates = seq(start, enddate, by = 1)
  dates = xts(seq_along(dates), order.by = dates)

  na.locf(cbind(dates, x)[,-1])
}



#' Convert xts to tibble.
#'
#' Adds column with dates to the first position to after conversion to tibble.
#'
#' @param x xts object.
#'
#' @export
#' @return tbl_df object.
#' @examples
#'
xts2tbl = function(x)
{
  dt = as_data_frame(x)
  bind_cols(data_frame(date = index(x)), dt)
}

