## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse   = TRUE,
  message    = FALSE,
  warning    = FALSE,
  comment    = "#>",
  out.width  = "100%",
  out.height = "620px" 
)

## ----setup--------------------------------------------------------------------
library(cryptoQuotes)

## -----------------------------------------------------------------------------
# 1) create a simple chart
# object
# 
# NOTE: The chart is wrapped in
# plotly::layout() to avoid
# duplicating xaxis when the
# custom indicators are added
chart_object <- plotly::layout(
  chart(
    ticker = BTC,
    main   = kline(),
    sub    = list(
      volume()
    ),
    options = list(
      dark = FALSE
    )
  ),
  xaxis = list(
    showticklabels = FALSE
  )
)

## -----------------------------------------------------------------------------
# 1) generate sin-indicator
sin_indicator <- data.frame(
    index         = zoo::index(BTC),
    sin_indicator = sin(seq(0,8*pi,length.out=nrow(BTC)))
  
)

## -----------------------------------------------------------------------------
# 1) create a plotly-object
# with the sin-indicator
sin_indicator <- plotly::layout(
   margin= list(l = 5, r = 5, b = 5),
  p = plotly::plot_ly(
    data = sin_indicator,
    y    = ~sin_indicator,
    x    = ~index,
    type = "scatter",
    mode = "lines",
    name = "sin"
  ),
  yaxis = list(
    title = NA
  ),
  xaxis = list(
    title = NA
  )
)
# 2) display the 
# indicator
sin_indicator

## -----------------------------------------------------------------------------
# 1) append the sin_indicator
# to the chart object
chart_object <- plotly::subplot(
  # ensures that plots are 
  # vertically aligned
  nrows = 2,
  heights = c(
    0.7,
    0.2
  ),
  chart_object,
  sin_indicator,
  shareX = FALSE,
  titleY = FALSE
)

# 2) display the chart
# object
chart_object

## -----------------------------------------------------------------------------
# 1) linear regression
# line
lm_indicator <- data.frame(
  y = fitted(
    lm(
      close ~ time,
      data = data.frame(
        time = 1:nrow(BTC),
        close = BTC$close
      )
    )
  ),
  index = zoo::index(BTC)
)

## -----------------------------------------------------------------------------
# 1) display the linear
# regression line on
# an empty chart
plotly::add_lines(
  p    = plotly::plotly_empty(),
  data = lm_indicator,
  y    = ~y,
  x    = ~index,
  inherit = FALSE,
  xaxis = "x1",
  yaxis = "y2",
  name  = "regression"
)

## -----------------------------------------------------------------------------
# 1) add the regression
# line to the chart_object
plotly::layout(
  margin = list(l = 5, r = 5, b = 5, t = 65),
  plotly::add_lines(
    p       = chart_object,
    data    = lm_indicator,
    y       = ~y,
    x       = ~index,
    inherit = FALSE,
    xaxis   = "x1",
    yaxis   = "y2",
    name    = "regression"
  ),
  yaxis = list(
    title = NA
  ),
  xaxis = list(
    title = NA
  )
)

