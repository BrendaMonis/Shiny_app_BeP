#
# This is based in Mastering Shiny
#
library(shiny)
# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Uploading Files"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select a file ----
      fileInput("file1", "Choose CSV File",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", TRUE),
      
      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),
      
      # Input: Select quotes ----
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select number of rows to display ----
      radioButtons("disp", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head"),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select the colunna for analysis ----
      radioButtons("x", "Lab_x",
                   choices = c(1:5),
                   selected = "1"),
      
      # Input: Select the colunna for analysis ----
      radioButtons("y", "Lab_y",
                   choices = c(1:5),
                   selected = "1")
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Data file ----
      tableOutput("contents"),
      verbatimTextOutput("print")
      # tableOutput("print")
    )
    
  )
)

# Define server logic to read selected file ----
server <- function(input, output) {
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    #What's that? - Ensure that values are available ("truthy") before 
    #proceeding with a calculation or action.
    req(input$file1)
    
    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
    
    #What's that? - These functions provide a mechanism for handling unusual
    #conditions, including errors and warnings.
    tryCatch(
      {
        df <- read.csv(input$file1$datapath,
                       header = input$header,
                       sep = input$sep,
                       quote = input$quote)
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
        #What's that? - This should be used when you want to let the user 
        #see an error message even if the default is to sanitize all errors.
        #If you have an error e and call stop(safeError(e)), then Shiny 
        #will ignore the value of getOption("shiny.sanitize.errors") and 
        #always display the error in the app itself.
      }
    )
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
  })
  
  output$print <- renderPrint(
    tryCatch(
      {
        df <- read.csv(input$file1$datapath,
                       header = input$header,
                       sep = input$sep,
                       quote = input$quote)
      },
      error = function(e) {
        stop(safeError(e))
      }
    ),
    ## Nessa parte para correr a análise, sempre dá erro
    # desing <- aov(df[,input$y] ~ df[,input$x], df),
    # return(summary(aov(df[,input$y] ~ df[,input$x], df)))
    # desing <- reactive({
    #   aov(df[,input$y] ~ df[,input$x])
    # }),
    # return(df$phen1)
    )
}
shinyApp(ui, server)
