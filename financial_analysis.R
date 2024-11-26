# financial_analysis.R

# Load required libraries
library(readr)
library(dplyr)
library(zoo)
library(plotly)
library(htmlwidgets)

# Load the cleaned data
my_data <- read_csv("C:/Users/vanis/Downloads/cleaned_financial_regression.csv")

# Calculate a 7-day moving average for S&P 500 closing prices
my_data$sp500_ma7 <- rollapply(my_data$`sp500 close`, 7, mean, fill = NA, align = 'right')

# Calculate a 7-day EMA for S&P 500 closing prices
my_data$sp500_ema7 <- TTR::EMA(my_data$`sp500 close`, n = 7)

# Create an interactive plot with moving average and EMA
plotly_plot <- plot_ly(my_data, x = ~as.Date(date), type = 'scatter', mode = 'lines') %>%
  add_lines(y = ~sp500_ema7, name = "S&P 500 7-Day EMA", line = list(color = 'green')) %>%
  add_lines(y = ~sp500_ma7, name = "S&P 500 7-Day MA", line = list(color = 'orange')) %>%
  add_lines(y = ~`sp500 close`, name = "S&P 500", line = list(color = 'blue')) %>%
  add_lines(y = ~`nasdaq close`, name = "NASDAQ", line = list(color = 'red')) %>%
  layout(
    title = "Comparison of S&P 500 and NASDAQ with 7-Day EMA and MA",
    xaxis = list(title = "Date"),
    yaxis = list(title = "Closing Price")
  )

# Save the interactive plot to an HTML file
saveWidget(plotly_plot, "C:/Users/vanis/Downloads/interactive_financial_plot.html")
