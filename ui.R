library(shiny)

shinyUI(fluidPage(
	titlePanel("Simple LM Predictor"),
	sidebarLayout(sidebarPanel(
		h3("Data Source"), 
		fileInput("data_file", label = "Data File"), 
		actionButton("load_csv", label = "Load CSV"), 
		tags$hr(),
		actionButton("load_galton", label = "Load Galton's Data"), 
		tags$hr(),
		actionButton("load_wages", label = "Load Wages Data") 
	), 
	mainPanel(verbatimTextOutput('status_bar'), 
		tabsetPanel(type = "tabs", 
			tabPanel("Data Explorer", 
				tableOutput("data_sample")
			), 
			tabPanel("Exploratory Plot", 
				textInput("x_axis", label = "X Axis Variable"), 
				textInput("y_axis", label = "Y Axis Variable"), 
				textInput("chart_cat", label = "Categories"), 
				actionButton("run_plot", label = "Plot"), 
				plotOutput("model_plot")
			), 
			tabPanel("Model Builder", 
				textInput("target", label = "Target Variable"), 
				textInput("predictors", label = "Predictors", "."), 
				actionButton("run_model", label = "Run Model"), 
				br(), 
				tableOutput("model_results") 
			), 
			tabPanel("Predictor", 
 				h5('Load a file to predict with, predicted value in the last 
 				   column after clicking "predict"'), 
				tags$hr(),
				fileInput("predict_file", label = 
					"Load a file to predict with"), 
				tags$hr(),
				actionButton("run_predict", label = "Predict"), 
				tags$hr(),
				tableOutput("pred_results")
			), 
			tabPanel("Help", 
				includeHTML("helpfile.htm")
			)
		)
	))
))

