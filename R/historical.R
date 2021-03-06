

#' Historic exchange rates
#'
#' Historical exchange rates are only available on paid fixer.io accounts.
#'
#' @param date A date in YYYY-MM-DD format, or any value that can be coerced
#' to YYYY-MM-DD format with `as.Date()`. Defaults to `NULL`, which
#' returns the latest conversion data.
#' @param base The base currency to index other currencies against.
#' Defaults to `"EUR"`. Can only be changed with paid plans.
#' @param symbols The symbols of currencies to return exchange rates for.
#' Defaults to `NULL` and returns all available currencies. See
#' [fixer_symbols]()] for details on symbol options.
#'
#' @return A tibble with exchange rates to the base currency on a given date.
#' @export
#'
#' @examples \dontrun{
#'
#' historical <- fixer_historical(date = "2017-05-18")
#'
#' }

fixer_historical <- function(date = NULL, base = "EUR", symbols = NULL) {
  date_query <- ifelse(is.null(date), "latest", as.character(date))

  base_query <- paste0("&base=", base)

  symbols_query <- symbols_util(symbols)

  query <- paste0(
    date_query, "?access_key=", getOption("fixer.API.key"),
    base_query, symbols_query
  )

  df <- fixer_download(query)

  rates <- tibble::enframe(df$rates)

  rates$value <- as.numeric(rates$value)

  rates
}
