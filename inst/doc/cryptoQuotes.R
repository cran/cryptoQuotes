## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(cryptoQuotes)

## ----eval=FALSE---------------------------------------------------------------
#  ## get OHLC data
#  ## from binance futures
#  ## market with daily pips
#  ATOMUSDT <- cryptoQuotes::getQuote(
#    ticker   = 'ATOMUSDTM',
#    source   = 'binance',
#    futures  = TRUE,
#    interval = '15m',
#    from     = '2023-10-01',
#    to       = '2023-10-02'
#  )

## ----include = FALSE, message=FALSE, echo=FALSE-------------------------------
### get data from kucoin
### from the internal data set
ATOMUSDT <- cryptoQuotes:::internalTest[[1]][[2]]

## ----out.width="100%",fig.align='center',fig.height=5-------------------------
## Create a chart
cryptoQuotes::chart(
  cryptoQuotes::kline(ATOMUSDT, deficiency = FALSE) %>%
    cryptoQuotes::addVolume() %>% 
    cryptoQuotes::addBBands(cols = c('close'))
)

## ----eval=FALSE---------------------------------------------------------------
#  ## get OHLC data
#  ## from Kucoin futures
#  ## market with daily pips
#  ATOMUSDT <- cryptoQuotes::getQuote(
#    ticker   = 'ATOM-USDT',
#    source   = 'kucoin',
#    futures  = FALSE,
#    interval = '15m',
#    from     = '2023-10-01',
#    to       = '2023-10-02'
#  )

## ----include = FALSE, message=FALSE, echo=FALSE-------------------------------
### get data from kucoin
### from the internal data set
ATOMUSDT <- cryptoQuotes:::internalTest[[2]][[1]]

## ----out.width="100%",fig.align='center',fig.height=5-------------------------
## Create a chart
cryptoQuotes::chart(
  cryptoQuotes::kline(ATOMUSDT, deficiency = FALSE) %>%
    cryptoQuotes::addVolume() %>% 
    cryptoQuotes::addRSI()
)

