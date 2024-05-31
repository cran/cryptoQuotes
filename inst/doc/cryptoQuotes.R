## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse      = TRUE,
  comment       = "#>",
  out.width     = "100%",
  out.height    = "680",
  fig.align     = "center"
)

## ----setup, message = FALSE---------------------------------------------------
library(cryptoQuotes)

## -----------------------------------------------------------------------------
# show a sample of 
# the available tickers
sample(
  x = available_tickers(
    source  = "kraken",
    futures = FALSE
  ),
  size = 5
)

## -----------------------------------------------------------------------------
## extract Bitcoin
## market on the hourly 
## chart
BTC <- get_quote(
  ticker   = "XBTUSDT",
  source   = "kraken",
  futures  = FALSE, 
  interval = "1h"
)

## ----echo=FALSE---------------------------------------------------------------
tail(
 BTC 
)

## -----------------------------------------------------------------------------
## get available
## intervals for OHLC
## on Kraken
available_intervals(
  source  = "kraken",
  type    = "ohlc",
  futures = FALSE
)

## -----------------------------------------------------------------------------
## extract long-short
## ratio on Bitcoin
## using the hourly chart
LS_BTC <- try(
   get_lsratio(
    ticker   = "XBTUSDT",
    source   = "kraken",
    interval = "1h"
  )
)

## -----------------------------------------------------------------------------
## extract long-short
## ratio on Bitcoin
## using the hourly chart
LS_BTC <- get_lsratio(
  ticker   = "PF_XBTUSD",
  source   = "kraken",
  interval = "1h"
)

## ----echo=FALSE---------------------------------------------------------------
tail(
 LS_BTC 
)

## -----------------------------------------------------------------------------
# show a sample of 
# the available tickers
sample(
  x = available_tickers(
    source  = "kraken",
    futures = TRUE
  ),
  size = 5
)

## ----fig.alt="cryptocurrency market data with R"------------------------------
# candlestick chart with
# volume and Long to Short Ratio
chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume(),
    lsr(ratio = LS_BTC)
  ),
  options = list(
    dark = FALSE
  )
)

## ----fig.alt="cryptocurrency market data with R"------------------------------
# candlestick chart with
# volume and Long to Short Ratio
chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume(),
    lsr(ratio = LS_BTC)
  ),
  indicator = list(
    sma(n = 7),
    sma(n = 14),
    sma(n = 21),
    bollinger_bands(
      color = "steelblue"
    )
  ),
  options = list(
    dark = FALSE
  )
)

