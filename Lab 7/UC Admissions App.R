library(shiny)
library(tidyverse)

UC_admit <- readr::read_csv("data/UC_admit.csv") 

UC_admit2 <- UC_admit %>% 
  mutate(Academic_Yr = as_factor(Academic_Yr))

ui <- dashboardPage(
  dashboardHeader(title = "UC Admissions Ethnicity Stats"),
  dashboardSidebar(),
  dashboardBody(fluidPage(
    selectInput("x", "Select X Variable", choices = c("Category", "Campus", "Academic_Yr"),
                selected = "Ethnicity"),
    plotOutput("plot", width = "800px", height = "400px")))
  
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    ggplot(UC_admit2, aes_string(x = "Ethnicity", y = "FilteredCountFR", fill = input$x)) + 
      geom_bar(stat = "identity", position = "dodge") + 
      theme_light(base_size = 18)+
      theme(axis.text.x = element_text(angle = 60, hjust = 1), axis.text = element_text(size = 18), axis.title = element_text(size=18))
  })
  
}

shinyApp(ui, server)



