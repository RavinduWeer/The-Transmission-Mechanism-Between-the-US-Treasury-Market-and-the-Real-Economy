📌 Executive Summary
This project investigates the bidirectional relationship between the US Treasury Market (specifically the 10-Year Yield and the Yield Curve Spread) and the Real Economy (Real GDP Growth). Utilizing quarterly time-series data from the Federal Reserve Economic Data (FRED) and R-based econometric modeling, this research tests the validity of traditional macroeconomic transmission mechanisms in the post-2008 financial landscape.

Contrary to historical literature positioning the yield curve as a reliable linear predictor of economic growth, this analysis reveals a breakdown in these mechanisms. The findings suggest that unconventional monetary policies, such as Quantitative Easing (QE), and balance-sheet recessions have distorted the price signals historically relied upon for macroeconomic forecasting.

🛠️ Tools & Technologies Used
    Language: R
    Data Sourcing: quantmod (FRED API)
    Time-Series Alignment: zoo
    Econometric Testing: tseries (Stationarity), lmtest (Granger Causality)

📊 Data Sourcing and Pre-processing
Data was retrieved programmatically via FRED, focusing on the following macroeconomic indicators:
    GDPC1: Real Gross Domestic Product (Quarterly)
    DGS10: 10-Year Treasury Constant Maturity Rate (Daily, aggregated to Quarterly)
    T10Y2Y: 10-Year minus 2-Year Treasury Yield Spread (Daily, aggregated to Quarterly)

To satisfy the assumptions of time-series regression, the raw data underwent rigorous transformation:
    Growth Rate Transformation: Real GDP was transformed into a growth rate using log-differences: g=(ln(GDPt​)−ln(GDPt−1​))×100.
    Frequency Alignment: Daily treasury yields were aggregated to quarterly mean values to match GDP reporting frequencies.
    Stationarity Adjustments: The 10-Year Yield was transformed into first differences to achieve stationarity.
    Index Alignment: Utilized as.yearqtr to perfectly align disparate date formats across datasets, preventing data loss during the merge process.

🔬 Econometric Methodology
    Stationarity Verification (Augmented Dickey-Fuller Test): Confirmed that all transformed variables (GDP Growth, 10-Year Yield Change, Yield Spread) rejected the null hypothesis of non-stationarity (p<0.05), ensuring the data was suitable for causal testing without the risk of spurious regression.

    Granger Causality Testing: Applied linear Granger Causality tests with a 4-quarter lag structure to evaluate bidirectional predictive power:

        Test 1: 10-Year Yield Volatility vs. GDP Growth
        Test 2: Yield Curve Spread (10Y-2Y) vs. GDP Growth

    Cross-Correlation Function (CCF): Visualized the lagged relationships between GDP Growth and the Yield Spread to identify any non-contemporaneous correlations up to 8 quarters.

💡 Key Findings
    Transmission Breakdown: The linear Granger Causality analysis revealed that neither the yield curve spread nor the volatility of 10-year yields possessed statistically significant predictive power for the magnitude of GDP growth (p>0.05) over a 4-quarter horizon.

    Economy to Bond Market: GDP growth also failed to linearly predict future yield spreads.

    Structural Distortion: The lack of linear causality contradicts 1990s stylized facts. This "Null Result" indicates that while the yield curve may act as a binary warning signal for recessions, it is no longer a reliable linear forecaster of GDP growth, likely due to the suppressive effects of central bank asset purchases (QE) on term premiums.

🚀 How to Run the Project
    Clone this repository to your local machine.
    Ensure you have an active internet connection (required for the quantmod FRED API call).
    Open the Treasury_RealEconomy_Analysis.R script in RStudio.
    Run the script. The console will output data extraction logs, Augmented Dickey-Fuller test results, Granger Causality F-statistics, and generate a CCF plot in your plotting pane.

Here is a comprehensive and professional README file for your GitHub repository. It integrates the technical details from your R code with the macroeconomic conclusions from your research report, creating a strong portfolio piece for hiring managers.
The Transmission Mechanism Between the US Treasury Market and the Real Economy

📥 Click here to read the full research report (PDF) (Note: Replace # with the actual link to your uploaded PDF)
📌 Executive Summary

This project investigates the bidirectional relationship between the US Treasury Market (specifically the 10-Year Yield and the Yield Curve Spread) and the Real Economy (Real GDP Growth). Utilizing quarterly time-series data from the Federal Reserve Economic Data (FRED) and R-based econometric modeling, this research tests the validity of traditional macroeconomic transmission mechanisms in the post-2008 financial landscape.

Contrary to historical literature positioning the yield curve as a reliable linear predictor of economic growth, this analysis reveals a breakdown in these mechanisms. The findings suggest that unconventional monetary policies, such as Quantitative Easing (QE), and balance-sheet recessions have distorted the price signals historically relied upon for macroeconomic forecasting.
🛠️ Tools & Technologies Used

    Language: R

    Data Sourcing: quantmod (FRED API)

    Time-Series Alignment: zoo

    Econometric Testing: tseries (Stationarity), lmtest (Granger Causality)

📊 Data Sourcing and Pre-processing

Data was retrieved programmatically via FRED, focusing on the following macroeconomic indicators:

    GDPC1: Real Gross Domestic Product (Quarterly)

    DGS10: 10-Year Treasury Constant Maturity Rate (Daily, aggregated to Quarterly)

    T10Y2Y: 10-Year minus 2-Year Treasury Yield Spread (Daily, aggregated to Quarterly)

To satisfy the assumptions of time-series regression, the raw data underwent rigorous transformation:

    Growth Rate Transformation: Real GDP was transformed into a growth rate using log-differences: g=(ln(GDPt​)−ln(GDPt−1​))×100.

    Frequency Alignment: Daily treasury yields were aggregated to quarterly mean values to match GDP reporting frequencies.

    Stationarity Adjustments: The 10-Year Yield was transformed into first differences to achieve stationarity.

    Index Alignment: Utilized as.yearqtr to perfectly align disparate date formats across datasets, preventing data loss during the merge process.

🔬 Econometric Methodology

    Stationarity Verification (Augmented Dickey-Fuller Test): Confirmed that all transformed variables (GDP Growth, 10-Year Yield Change, Yield Spread) rejected the null hypothesis of non-stationarity (p<0.05), ensuring the data was suitable for causal testing without the risk of spurious regression.

    Granger Causality Testing: Applied linear Granger Causality tests with a 4-quarter lag structure to evaluate bidirectional predictive power:

        Test 1: 10-Year Yield Volatility vs. GDP Growth

        Test 2: Yield Curve Spread (10Y-2Y) vs. GDP Growth

    Cross-Correlation Function (CCF): Visualized the lagged relationships between GDP Growth and the Yield Spread to identify any non-contemporaneous correlations up to 8 quarters.

💡 Key Findings

    Transmission Breakdown: The linear Granger Causality analysis revealed that neither the yield curve spread nor the volatility of 10-year yields possessed statistically significant predictive power for the magnitude of GDP growth (p>0.05) over a 4-quarter horizon.

    Economy to Bond Market: GDP growth also failed to linearly predict future yield spreads.

    Structural Distortion: The lack of linear causality contradicts 1990s stylized facts. This "Null Result" indicates that while the yield curve may act as a binary warning signal for recessions, it is no longer a reliable linear forecaster of GDP growth, likely due to the suppressive effects of central bank asset purchases (QE) on term premiums.

🚀 How to Run the Project

    Clone this repository to your local machine.

    Ensure you have an active internet connection (required for the quantmod FRED API call).

    Open the Treasury_RealEconomy_Analysis.R script in RStudio.

    Run the script. The console will output data extraction logs, Augmented Dickey-Fuller test results, Granger Causality F-statistics, and generate a CCF plot in your plotting pane.

📁 Repository Structure
    Treasury_RealEconomy_Analysis.R: The complete R script containing data extraction, cleaning, and econometric modeling.

    US_Treasury_Market_and_the_Real_Economy.pdf: The comprehensive academic research report detailing the theoretical framework, IS-LM context and full analysis of the findings.
