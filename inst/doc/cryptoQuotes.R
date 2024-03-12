## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE,
  out.width = "100%",
  comment = "#>",
  message = FALSE
)

## ----message=FALSE------------------------------------------------------------
library(cryptoQuotes)

## ----echo=FALSE, out.width="80%", fig.cap="Tweet by Elon Musk - the timezone is CET.",fig.align='center'----
## include tweet from
## Elon Musk
knitr::include_graphics(
  path = "elonTweet.png"
)

## -----------------------------------------------------------------------------
## DOGEUSDT the day
## of the tweet on the
## 1m chart
DOGE <- cryptoQuotes::get_quote(
  ticker   = 'DOGE-USDT',
  interval = '1m',
  source   = 'kucoin',
  futures  = FALSE,
  from     = '2022-01-14 07:00:00',
  to       = '2022-01-14 08:00:00'
)

## -----------------------------------------------------------------------------
## extrat the
## tweet moment
tweet_moment <- DOGE["2022-01-14 07:18:00"]

## calculate 
## rally
cat(
  "Doge closed:", round((tweet_moment$close/tweet_moment$open - 1),4) * 100, "%"
)

## ----fig.align='center', out.height=800---------------------------------------
## chart the
## price action
## using klines
cryptoQuotes::chart(
  ticker     = DOGE,
  main       = cryptoQuotes::kline(),
  sub  = list(
    cryptoQuotes::volume()
  ),
  options = list(
    dark = FALSE
  )
)

## -----------------------------------------------------------------------------
## 1) create event data.frame
## by subsetting the data
event_data <- as.data.frame(
  zoo::coredata(
    DOGE["2022-01-14 07:18:00"]
  )
)

## 1.1) add the index 
## to the event_data
event_data$index <- zoo::index(
  DOGE["2022-01-14 07:18:00"]
)

# 1.2) add event label
# to the data
event_data$event <- 'Elon Musk Tweets'

# 1.3) add color to the
# event label
event_data$color <- 'steelblue'

## ----out.height = 800---------------------------------------------------------
## 1) create event data.frame
## by subsetting the data
event_data <- as.data.frame(
  zoo::coredata(
    DOGE["2022-01-14 07:18:00"]
  )
)

## 1.1) add the index 
## to the event_data
event_data$index <- zoo::index(
  DOGE["2022-01-14 07:18:00"]
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
  ticker     = DOGE,
  event_data = event_data,
  main       = cryptoQuotes::kline(),
  sub  = list(
    cryptoQuotes::volume()
  ),
  options = list(
    dark = FALSE
  )
)

