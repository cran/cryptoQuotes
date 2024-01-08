## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
collapse = TRUE,
comment = "#>",
message = FALSE
)

## ----setup--------------------------------------------------------------------
library(cryptoQuotes)

## ----echo=FALSE, out.width="80%", fig.cap="Tweet by Elon Musk - the timezone is CET.",fig.align='center'----
## include tweet from
## Elon Musk
knitr::include_graphics(
  path = "elonTweet.png"
)

## ----eval = FALSE-------------------------------------------------------------
#  ## DOGEUSDT the day
#  ## of the tweet on the
#  ## 1m chart
#  DOGEUSDT <- cryptoQuotes::getQuote(
#    ticker   = 'DOGEUSDT',
#    interval = '1m',
#    source   = 'binance',
#    futures  = FALSE,
#    from     = '2022-01-14',
#    to       = '2022-01-15'
#  )

## -----------------------------------------------------------------------------
## extract the hour
## of the tweet
DOGEUSDT <- window(
  x     = DOGEUSDT,
  start = ('2022-01-14 06:00:00'),
  end   = ('2022-01-14 07:00:00')
)

## ----out.width="100%",fig.align='center',fig.height=5-------------------------
## chart the
## price action
## using klines
cryptoQuotes::chart(
  chart = cryptoQuotes::kline(
    quote = DOGEUSDT
  ) %>% cryptoQuotes::addVolume(),
  slider = FALSE
)

## -----------------------------------------------------------------------------
## 1) create event data.frame
## by subsetting the data
event_data <- as.data.frame(
  zoo::coredata(
    DOGEUSDT[19]
  )
)

## 1.1) add the index 
## to the event_data
event_data$index <- zoo::index(
  DOGEUSDT[19]
)

# 1.2) add event label
# to the data
event_data$event <- 'Elon Musk Tweets'

# 1.3) add color to the
# event label
event_data$color <- 'steelblue'

## ----out.width="100%",fig.align='center',fig.height=5-------------------------
## 1) create event data.frame
## by subsetting the data
event_data <- as.data.frame(
  zoo::coredata(
    DOGEUSDT[19]
  )
)

## 1.1) add the index 
## to the event_data
event_data$index <- zoo::index(
  DOGEUSDT[19]
)

# 1.2) add event label
# to the data
event_data$event <- 'Elon Musk Tweets'

# 1.3) add color to the
# event label
event_data$color <- 'steelblue'

## 1) chart the
## price action
## using klines
cryptoQuotes::chart(
  chart = cryptoQuotes::kline(
    quote = DOGEUSDT
  )%>% addEvents(
    event = event_data
  ) %>% cryptoQuotes::addVolume(),
  slider = FALSE
)

