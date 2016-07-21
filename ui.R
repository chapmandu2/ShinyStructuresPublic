
library(shiny)

shinyUI(fluidPage(

    tags$head(tags$script(src="ChemDoodleWeb.js")),
    tags$head(tags$script(src='caffeine.js')),
    tags$head(tags$link(href="ChemDoodleWeb.css", rel="stylesheet" )),

    
  # Application title
  titlePanel("Shiny Structures"),

  sidebarLayout(
    sidebarPanel(
        selectInput(inputId='user_name', 
                    label='Select User:', 
                    choices=c('fbloggs', 'jdoe', 'fspencer')),
        sliderInput("N",
                  "Number of rows:",
                  min = 1,
                  max = 1000,
                  value = 50),
        submitButton()
    ),

    mainPanel(
      DT::dataTableOutput('dt')
    )
  )
))
