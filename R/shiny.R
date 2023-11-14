library(shiny)
library(dplyr)
library(ggplot2)

# Sample dataframe
your_data <- data.frame(
  primtype = as.factor(c("Category1", "Category2", "Category1", "Category3")),
  arrest = as.factor(c("Yes", "No", "Yes", "No")),
  domestic = as.factor(c("No", "Yes", "No", "Yes")),
  beat = c(123, 456, 789, 321),
  district = c(1, 2, 3, 4),
  ward = c(10, 20, 30, 40),
  community_area = c(100, 200, 300, 400),
  month = c(1, 2, 3, 4),
  day = c(5, 10, 15, 20),
  hour = c(8, 12, 16, 20)
)

# Define UI
ui <- fluidPage(
  titlePanel("Linear Regression Model Builder"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("response_var", "Select Response Variable", names(your_data), selected = "primtype", multiple = FALSE),
      selectInput("predictor_vars", "Select Predictor Variables", names(your_data), selected = names(your_data)[-1], multiple = TRUE),
      actionButton("build_model", "Build Model"),
      actionButton("btn2","Show Stats")
    ),
    
    mainPanel(
      plotOutput("regression_plot")
    )
  )
)

# Define server
server <- function(input, output) {
  observeEvent(input$build_model, {
    # Create formula for linear regression
    formula <- as.formula(paste(input$response_var, "~", paste(input$predictor_vars, collapse = " + ")))
    
    # Build linear regression model
    model <- lm(formula, data = your_data)
    
    # Display regression plot
    output$regression_plot <- renderPlot({
      ggplot(your_data, aes_string(x = input$response_var, y = "predicted")) +
        geom_point() +
        geom_smooth(method = "lm", se = FALSE, color = "red") +
        labs(title = "Linear Regression Model")
      
      summary_stats <- eventReactive(input$btn2,{
        summary(model)
        })
    })
  })
}


# Run the Shiny app
shinyApp(ui = ui, server = server)
