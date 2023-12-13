% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chart.R
\name{chart}
\alias{chart}
\title{Chart your data}
\usage{
chart(chart, slider = TRUE)
}
\arguments{
\item{chart}{A kline or ohlc chart with and without
indicators}

\item{slider}{Logical. TRUE by default.}
}
\value{
Returns a plotly object
}
\description{
Chart your data
}
\examples{
# script: scr_charting
# date: 2023-10-25
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Charting in general
# script start;

# library
library(cryptoQuotes)

# charting klines
# with various indicators
chart(
  chart = kline(
    ATOMUSDT
  ) \%>\% addVolume() \%>\% addMA(
    FUN = TTR::SMA,
    n = 7
  ) \%>\% addMA(
    FUN = TTR::SMA,
    n = 14
  ) \%>\%
    addBBands() \%>\%
    addMACD() \%>\%
    addRSI()

)


# script end;
}
\seealso{
Other charting: 
\code{\link{kline}()},
\code{\link{ohlc}()}
}
\concept{charting}