# bios611-project2
This project aim to use R-shiny app to visualiza each prodictor's contribution to the final real estate price in Seattle, the model we use is GBM. By setting different parameters in the GBM methods, the predition results vary a little bit. Therefore, we can have this app to give us a better understanding of how GBM working on the continuous data prediction with multiple predictors in the model.  

# data
The data comes from https://www.kaggle.com/harlfoxem/housesalesprediction
This is a real life dataset contains house sale prices for King County, which includes Seattle. It includes homes sold between May 2014 and May 2015.
To prevent the effect of outliers, we eliminate the house with bedroom number over 6.

# pdp
Partial dependency analysis for GBM used the published pdp R packages, the details can be found here
https://bgreenwell.github.io/pdp/articles/pdp.html

# predicted price
The predicted price is based on the full model,including: 
bedrooms,bathrooms,sqft_living,aqft_lot,floors,waterfront,view,condition+grade,sqft_above,sqft_basement,yr_built,yr_renovated,lat,long,sqft_living15,sqft_lot15
The error between predicted price and the actual price is quite small.

# how to run the app on docker
first, build the docker environment by:
    >docker build . -t project2
Then,  initiate the aliases by saying:
    >source aliases.bashrc
Lastly, run the docker enviornment by:
    >start_shiny gbm 8788
