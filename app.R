library(shiny)
library(ggplot2)


ui <- fluidPage(
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      
      
      # Input: Select a file ----
      fileInput("file1", "Choose Your File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv"))
      
),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("RawData", DT::dataTableOutput("mytable1")),
        tabPanel("Plot", DT::dataTableOutput("mytable2"))
      )
    )
)
)



server <- function(input, output) {
  

    
    output$mytable1 <- DT::renderDataTable({
      df <- read.delim(input$file1$datapath, header = T, col.names = c("Sequence", "Source", "Feature", "Start", "End", "Score", "Strand", "Phase", "Attributes"), comment.char="#")
      DT::datatable(df)
    })
    
      # Fill in the spot we created for a plot
      output$mytable2 <- renderPlot({
        
        # Render a barplot
        df <- barplot(shiny[,input$region]*1000, 
                main=input$region,
                ylab="Number of Telephones",
                xlab="Year")
      })
    }


shinyApp(ui, server)