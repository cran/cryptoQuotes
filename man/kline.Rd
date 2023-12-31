% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chart.R
\name{kline}
\alias{kline}
\title{Chart the OHLC prices using candlesticks}
\usage{
kline(quote, deficiency = FALSE, slider = TRUE)
}
\arguments{
\item{quote}{A cryptoQuote in xts/zoo format.}

\item{deficiency}{Logical. \link{FALSE} by default, if \link{TRUE} color defiency compliant
colors are used.}

\item{slider}{Logical. TRUE by default. If FALSE, no slider will be included.}
}
\value{
Invisbly returns a plotly object.
}
\description{
\ifelse{html}{\href{https://lifecycle.r-lib.org/articles/stages.html#stable}{\figure{lifecycle-stable.svg}{options: alt='[Stable]'}}}{\strong{[Stable]}}

Candlestick charts are highly visual and provide a quick and intuitive way to assess market sentiment and price action.
Traders and analysts use them in conjunction with other technical analysis tools to make informed trading decisions.
These charts are particularly useful for identifying key support and resistance levels, trend changes, and potential entry and exit points in financial markets.
}
\seealso{
Other charting: 
\code{\link{chart}()},
\code{\link{ohlc}()}
}
\concept{charting}
