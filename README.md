# Forecasting using SPSS; Big Mart Sales III Data

Forecasting Sales data using Hackathon data from www.analyticsvidhya.com

 

##Problem Statement

The data scientists at BigMart have collected 2013 sales data for 1559 products across 10 stores in different cities. The aim is to build a predictive model and find out the sales of each product at a particular store.

There is a train (8523) and a test (5681) data set. The train data set has both input and output variable(s). Sales figures for the test set are predicted.

##Variables

This dataset has the following variables:

Item_Identifier: Unique product ID

Item_Weight: Weight of product

Item_Fat_Content: Whether the product is low fat or not

Item_Visibility: The % of total display area of all products in a store allocated to the particular product

Item_Type: The category to which the product belongs

Item_MRP: Maximum Retail Price (list price) of the product

Outlet_Identifier: Unique store ID

Outlet_Establishment_Year: The year in which store was established

Outlet_Size: The size of the store in terms of ground area covered

Outlet_Location_Type: The type of city in which the store is located

Outlet_Type:Whether the outlet is just a grocery store or some sort of supermarket

Item_Outlet_Sales: Sales of the product in the particulat store. This is the outcome variable to be predicted.

Cleaning, transformation and analysis is done using SPSS software. The SPSS syntax I have used is included in this repository. In this section I will further elaborate on my approach.

##Explorative analysis

After Downloading the train and test dataset, the two datasets are merged. A variable is added to identify which cases belong to which of the two datasets.

Next an explorative data analysis is conducted on the total dataset. Descriptive statistics (Mean, standard deviation, min, max) is calculated for the metric variables. Descriptive statistics (Mode, mean, max and frequency tables) are also calculated for the categorical variables.

This results in the identification of missing values in the variables:

-Item_Weight

-Outlet_size

-Item_visibility

Other things that stand out after this explorative analysis:

-Minimum of item visibility is 0. This would mean that the item is not visible and therefore not possible.

-Item_fat_content has different formats for the category Low Fat(LF, low fat and Low Fat) and Regular(reg and Regular)

-Item_type has many categories that do not seem to exclude one another

-Outlet_establishment year has an outlier

-There are a few variables that are heavily skewed (Item_visibility, Item_Weight and Item_MRP as well as the dependent variable Item_Outlet_Sales

##Data cleaning

###Dealing with missing variables:

-Missing values in item_weight are replaced by its mean (12.85765)

-Outlet size missing values are replaced by the mode (medium)

-The values 0 of item_visibility are also replaced by the mean (0.06589527801)

### Computing variables

The format of categories of Item_fat_content are adapted to two categories: Low Fat and Regular

The categories of Item_type have been reformatted to three categories: Food, Drinks and Non-Consumables

The variable Establishment year has been computed into ‘Years of Operation’ by calculating 2019-‘Establisment year’.

###Creating dummy variables

As I intend to conduct a multiple regression on the variables I have created dummy variables for categorical variables with more than 2 categories, as in multiple regression only dichotomous variables can be included.

Dummy variables have been created for the following variables:

Item_Type

Outlet_size

Outlet_location type

Outlet_type

### Transforming skewed variables

There are four variables that have been transformed to deal with skewness in the values. I have checked wether Square root transformation or Log transformation will be satisfactory. The new variables are called:

Log_ItemVisibility

SQRT_ItemWeight

SQRT_ItemMRP

SQRT_OutletSales

##Multiple regression analysis
