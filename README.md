# Simple LM Builder

## How it works:
This application lets you load a dataset, explore its main variables in a scatterchart and run a prediction using a file containing a new dataset. 

Here is what you need to know to use the application. 

### Left Pane (Data Source) and Data Explorer

The idea is that you use your own dataset to do your analysis, but you can also use Galton's and Wages datasets to do the testing. To load your own dataset you must:
Choose a CSV file. The names of the columns must be in the first line of the CSV file
Click the "Load CSV" Button and check "Data Explorer" pane
Review your loaded fileto check using the first 10 values and the column names


### "Exploratory Plot" Pane

This pane lets you choose three variables over your dataset (check column names in the data explorer as the variables to use are case-sensitive). What you will see here is a scatter plot using 2 variables in the axes and a "Categories" variable to color the dots for better visualization. 

### "Model Builder" Pane

As this is a simple modeler it only supports linear model. You must submit:
Target Variable: the name of the variable to predict.
Predictors: using R formulas format. You can provide either a single variable or a formula.


### "Predictor" Pane

This is where you pick a file with the registers containing at least the predictors used with the same column names (again, case-sensitive). The predicted value for each register is provided as a new column in a dataframe shown in the app.