Quantile Cointegration
To run the Quantile Cointegration Test, first, ensure that all required R packages (readxl, urca, dynamac, ggplot2, and parallel) are installed and loaded. 
The script starts by importing the dataset (DATA.xlsx), where CO2 emissions (y) is the dependent variable and ICT development (x) is the independent variable. 
The quantile-based approach is implemented by computing quantile transformations for CO2 emissions across quantiles ranging from 0.05 to 0.95. 
The Dynamic ARDL model (dynardl) is then estimated for each quantile, incorporating lagged and differenced terms while accounting for error correction mechanisms (ECM). 
The PSS Bounds Test (pssbounds) is applied to assess cointegration at each quantile, and the F-statistics are extracted and stored. 
Finally, a visualization using ggplot2 is generated, plotting F-statistics across quantiles with critical values at 1%, 5%, and 10% significance levels 
