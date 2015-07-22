library(UsingR)
library(stats)
library(caret)
library(ISLR)
library(ggplot2)


# Global variables to control when a button is clicked
clickedCsv <- 0
clickedGalton <- 0
clickedWages <- 0
clickedRunQuery <- 0
clickedPredict <- 0
clickedRunModel <- 0
clickedRunPlot <- 0

# Globa variables that will be used in several distinct reactive statements
status <- ""
current_query = ""
con <- NULL
dataset <- data.frame()
fit <- NULL
g <- ggplot()

shinyServer(function(input, output) {

	# Statement that handles the Data Explorer, which shows only the "head" of 
	# the loaded data
	output$data_sample <- renderTable({ 
		output$status_bar <- renderText({ "Application Ready" })
 		datasample <- dataset
		if(input$load_csv > clickedCsv) {
			clickedCsv <<- input$load_csv
			if(is.null(input$data_file)) 
				return()
			output$status_bar <- renderText({ "Loading file" })
			dataset <<- read.csv(input$data_file$datapath, header = T)
			datasample <- head(dataset, 10)
			status <<- paste0("Using data file: ", input$data_file$datapath)
			output$status_bar <- renderText({ "Data file loaded successfully" })
		}

		if(input$load_galton > clickedGalton) {
			clickedGalton <<- input$load_galton
			data(galton)
			dataset <<- galton
			datasample <- head(dataset, 10)
			output$status_bar <- renderText({ "Galton's data loaded" })
		}

		if(input$load_wages > clickedWages) {
			clickedWages <<- input$load_wages
			data(Wage)
			dataset <<- Wage
			datasample <- head(dataset, 10)
			output$status_bar <- renderText({ "Wages data loaded" })
		}
 		datasample
	})

	# This reactive statement handles the generation of the formula and it's
	# execution depending on what the user chose in the methods list
	get_formula <- reactive({
		target <- input$target
		predictors <- input$predictors
		perc_train <- input$perc_train
		if(is.null(target)) target <- names(dataset)[1]
		if(length(target) < 1) target <- names(dataset)[1]
		if(is.null(predictors)) predictors <- "."
		fit <<- lm(as.formula(paste0(target, " ~ ", predictors)), 
				   data = dataset)
		output$status_bar <- renderText({
			paste0("Linear model fitted with: ", target, " ~ ", predictors) 
		})
	})

	# Statement to handle the results of the model in a HTML table in the tab 
	# "Model Builder"
	output$model_results <- renderTable({
		if(input$run_model > clickedRunModel) {
			clickedRunModel <<- input$run_model
			isolate(get_formula())
			fit
		}
	})

	# Statement that handles the scatterplot that will help in a simple data 
	# visualization before running any model. Used in the tab "Model Builder"
	output$model_plot <- renderPlot({
		if(input$run_plot > clickedRunPlot && !is.null(dataset)) {
			clickedRunPlot <<- input$run_plot
 			if(input$chart_cat == "") 
				g <<- ggplot(dataset, aes_string(x = input$x_axis, 
												 y = input$y_axis))
			else 
				g <<- ggplot(dataset, aes_string(x = input$x_axis, 
												 y = input$y_axis, 
												 color = input$chart_cat))
			print(g + geom_point())
		}
	})

	# This statement handles the table that will show the predicted values for 
	# a given File in the tab "Predictor"
	output$pred_results <- renderTable({
		if(input$run_predict > clickedPredict) {
			clickedPredict <<- input$run_predict
			df <- read.csv(input$predict_file$datapath, header = T)
			df$Predicted <- predict(fit, newdata = df)
			df
		}
	})
})
