## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse   = TRUE,
  message    = FALSE,
  comment    = "#>",
  out.width  = "100%",
  out.height = "620px" 
)

## ----setup--------------------------------------------------------------------
library(cryptoQuotes)

## -----------------------------------------------------------------------------
chart(
  ticker    = BTC,
  main      = kline(),
  sub       = list(
    macd()
    ),
  indicator = list(
    bollinger_bands()
  ) 
)

## ----echo=FALSE---------------------------------------------------------------
bollinger_bands

## ----echo=FALSE---------------------------------------------------------------
macd

## -----------------------------------------------------------------------------
tail(
  TTR::DonchianChannel(
    HL = BTC[,c("high", "low")]
  )
)

## -----------------------------------------------------------------------------
## define custom TA
## donchian_channel
donchian_channel <- function(
    ## these arguments are the
    ## available arguments in the TTR::DonchianChannel
    ## function
    n = 10,
    include.lag = FALSE,
    ## the ellipsis
    ## is needed to interact with
    ## the chart-function
    ...
) {
  
  structure(
    .Data = {
      
      ## 1) define args
      ## as a list from the ellipsis
      ## which is how the chart-function
      ## communicates with the indicators
      args <- list(
        ...
      )
      
      ## 2) define the data, which in this
      ## case is the indicator. The indicator
      ## function streamlines the data so it works
      ## with plotly
      data <- cryptoQuotes:::indicator(
        ## this is just the ticker
        ## that is passed into the chart-function
        x = args$data,
        
        ## columns are the columns of the ohlc
        ## which the indicator is calculated on
        columns = c("high", "low"),
        
        ## the function itself 
        ## can be a custom function
        ## too.
        .f = TTR::DonchianChannel,
        
        ## all other arguments
        ## passed into .f
        n = n,
        include.lag = FALSE
      )
      
      ## each layer represents
      ## each output from the indicator
      ## in this case we have
      ## high, mid and low.
      ## 
      ## The lists represents a plotly-function
      ## and its associated parameters.
      layers <- list(
        ## high
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = "DC",
            name = "high",
            inherit = FALSE,
            data = data,
            x    = ~index,
            y    = ~high,
            line = list(
              color = "#d38b68",
              width = 0.9
            )
          )
        ),
        
        ## mid
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = "DC",
            name = "mid",
            inherit = FALSE,
            data = data,
            x    = ~index,
            y    = ~mid,
            line = list(
              color = "#d38b68",
              dash ='dot',
              width = 0.9
            )
          )
        ),
        
        ## low
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = "DC",
            name = "low",
            inherit = FALSE,
            data = data,
            x    = ~index,
            y    = ~low,
            line = list(
              color = "#d38b68",
              width = 0.9
            )
          )
        )
      )
      
      ## we can add ribbons
      ## to the main plot to give
      ## it a more structured look.
      plot <- plotly::add_ribbons(
        showlegend = TRUE,
        legendgroup = 'DC',
        p = args$plot,
        inherit = FALSE,
        x = ~index,
        ymin = ~low,
        ymax = ~high,
        data = data,
        fillcolor = cryptoQuotes:::as_rgb(alpha = 0.1, hex_color = "#d38b68"),
        line = list(
          color = "transparent"
        ),
        name = paste0("DC(", paste(c(n), collapse = ", "), ")")
      )
      
      ## the plot has to be build
      ## using the cryptoQuotes::build-function
      invisible(
        cryptoQuotes:::build(
          plot,
          layers = layers
        )
      )
      
    }
  )
  
}

## -----------------------------------------------------------------------------
chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume()
  ),
  indicator = list(
    bollinger_bands(),
    donchian_channel()
  )
)

## -----------------------------------------------------------------------------
tail(
  TTR::CCI(
    HLC = BTC[,c("high", "low", "close")]
  )
)

## -----------------------------------------------------------------------------
## define custom TA
## Commodity Channel Index (CCI)
cc_index <- function(
    ## these arguments are the
    ## available arguments in the TTR::CCI
    ## function
    n = 20,
    maType,
    c = 0.015,
    ## the ellipsis
    ## is needed to interact with
    ## the chart-function
    ...
) {
  
  structure(
    .Data = {
      
      ## 1) define args
      ## as a list from the ellipsis
      ## which is how the chart-function
      ## communicates with the indicators
      args <- list(
        ...
      )
      
      ## 2) define the data, which in this
      ## case is the indicator. The indicator
      ## function streamlines the data so it works
      ## with plotly
      data <- cryptoQuotes:::indicator(
        ## this is just the ticker
        ## that is passed into the chart-function
        x = args$data,
        
        ## columns are the columns of the ohlc
        ## which the indicator is calculated on
        columns = c("high", "low", "close"),
        
        ## the function itself 
        ## can be a custom function
        ## too.
        .f = TTR::CCI,
        
        ## all other arguments
        ## passed into .f
        n = n,
        maType = maType,
        c      = c
      )
      
      
      layer <- list(
        list(
          type = "plot_ly",
          params = list(
            name = paste0("CCI(", n,")"),
            data = data,
            showlegend = TRUE,
            x = ~index,
            y = ~cci,
            type = "scatter",
            mode = "lines",
            line = list(
              color = cryptoQuotes:::as_rgb(alpha = 1, hex_color = "#d38b68"),
              width = 0.9
            )
          )
          
        )
      )
      
      cryptoQuotes:::build(
        plot = args$plot,
        layers = layer,
        annotations = list(
          list(
            text = "Commodity Channel Index",
            x = 0,
            y = 1,
            font = list(
              size = 18
            ),
            xref = 'paper',
            yref = 'paper',
            showarrow = FALSE
          )
        )
      )
      
      
      
    }
  )
  
}

## -----------------------------------------------------------------------------
chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume(),
    cc_index()
  ),
  indicator = list(
    bollinger_bands(),
    donchian_channel()
  )
)

