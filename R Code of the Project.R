#Clear Console
rm(list=ls())
cat("\014")

# ==============================================================================
# Research: Transmission Mechanism Between US Treasuries and Real Economy
# Tools: Quantmod (Data), Tseries (Stationarity), LMtest (Causality), Zoo (Dates)
# ==============================================================================

# 1. Load Required Libraries
if(!require(quantmod)) install.packages("quantmod")
if(!require(tseries)) install.packages("tseries")
if(!require(lmtest)) install.packages("lmtest")
if(!require(zoo)) install.packages("zoo")

library(quantmod)
library(tseries)
library(lmtest)
library(zoo)

# 2. Data Retrieval from FRED
cat("Downloading data from FRED...\n")
getSymbols(c("GDPC1", "DGS10", "T10Y2Y"), src = "FRED", auto.assign = TRUE)

# 3. Data Processing and Alignment

# A. Transform GDP to Growth Rate
# Formula: ln(GDP_t) - ln(GDP_t-1)
gdp_growth <- diff(log(GDPC1)) * 100
gdp_growth <- na.omit(gdp_growth)
names(gdp_growth) <- "GDP_Growth"

# B. Convert Daily Yields to Quarterly Frequency (mean value)
yield_10y_q <- apply.quarterly(DGS10, mean, na.rm = TRUE)
spread_q    <- apply.quarterly(T10Y2Y, mean, na.rm = TRUE)

# C. Transform Yields to First Differences (Stationarity)
yield_10y_diff <- diff(yield_10y_q)
names(yield_10y_diff) <- "Yield_10Y_Change"

# D. Date Alignment (CRITICAL FIX for "NAs in x" error)
# Convert all indices to "Year-Quarter" format (e.g., "2023 Q1")
# This ensures 2023-01-01 (GDP) matches 2023-03-31 (Yield Mean)
index(gdp_growth)     <- as.yearqtr(index(gdp_growth))
index(yield_10y_diff) <- as.yearqtr(index(yield_10y_diff))
index(spread_q)       <- as.yearqtr(index(spread_q))

# E. Merge Datasets
# zoo's merge with yearqtr index will align them correctly
research_data <- merge(gdp_growth, yield_10y_diff, spread_q)
names(research_data) <- c("GDP_Growth", "Yield_10Y_Change", "Yield_Spread")

# F. Final Cleaning
# Remove any rows that still contain NAs (e.g. from start/end mismatches)
research_data <- na.omit(research_data)

# Safety Check
if(nrow(research_data) < 10) {
  stop("Error: Data merge resulted in too few observations. Check date alignment.")
} else {
  cat(paste("Data successfully merged. Total observations:", nrow(research_data), "\n"))
}

# 4. Stationarity Tests (Augmented Dickey-Fuller)
cat("\n=======================================================\n")
cat("STATIONARITY TESTS (Null Hypothesis: Series is Non-Stationary)\n")
cat("=======================================================\n")
# Using coredata() ensures we pass a numeric vector, stripping the time index wrapper
print(adf.test(coredata(research_data$GDP_Growth), alternative = "stationary"))
print(adf.test(coredata(research_data$Yield_10Y_Change), alternative = "stationary"))
print(adf.test(coredata(research_data$Yield_Spread), alternative = "stationary"))

# 5. Granger Causality Tests
cat("\n=======================================================\n")
cat("GRANGER CAUSALITY TEST 1: 10-Year Yield vs GDP\n")
cat("=======================================================\n")
# Does Yield Change predict GDP?
print(grangertest(GDP_Growth ~ Yield_10Y_Change, order = 4, data = research_data))
# Does GDP predict Yield Change?
print(grangertest(Yield_10Y_Change ~ GDP_Growth, order = 4, data = research_data))

cat("\n=======================================================\n")
cat("GRANGER CAUSALITY TEST 2: Yield Spread vs GDP\n")
cat("=======================================================\n")
# Does Spread predict GDP?
print(grangertest(GDP_Growth ~ Yield_Spread, order = 4, data = research_data))
# Does GDP predict Spread?
print(grangertest(Yield_Spread ~ GDP_Growth, order = 4, data = research_data))

# 6. Cross-Correlation Function (Visualizing Lags)
ccf_res <- ccf(as.numeric(research_data$GDP_Growth), 
               as.numeric(research_data$Yield_Spread), 
               lag.max = 8, 
               plot = TRUE,
               main = "Cross-Correlation: GDP Growth vs Yield Spread",
               ylab = "Correlation", 
               xlab = "Lag (Quarters)")
