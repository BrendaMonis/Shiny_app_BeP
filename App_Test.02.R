library(shiny)
library(car)

runApp(
  list(
    ui = pageWithSidebar(
      headerPanel('Analysis of Variance'),
      sidebarPanel(
        fileInput("file1", "CSV File",
                  accept=c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")),
        checkboxInput(
          "header", "Header", TRUE),
        radioButtons(
          'sep', 'Separator',c(Comma=',',Semicolon=';',Tab='\t'),','),
        selectInput(
          'type',
          'Please select Sums of Squares type', 
          c(I = 'type1', II = 'type2', III = 'type3'), 'type1')
        ,
        uiOutput('var') 
      ),
      mainPanel(    
        h3('ANOVA Table'),
        tableOutput('aovSummary')
      )
    ),
    server = function(input, output, session) {
      csvfile <- reactive({
        csvfile <- input$file1
        if (is.null(csvfile)){return(NULL)}
        dt <- read.csv(csvfile$datapath, header=input$header, sep=input$sep)
        dt
      })
      output$var <- renderUI({
        if(is.null(input$file1$datapath)){
          return()
        }else{
          list (radioButtons("dvar", "Please Pick The Dependent Variable", choices = names(csvfile())),
                radioButtons("ivar", "Please Pick The Independent Variable", choices = names(csvfile())),
                actionButton("submit", "Submit")
          )
        }
      })
      
      output$aovSummary = renderTable({
        if(is.null(input$file1$datapath)){return()}
        
        if(input$submit > 0){
          if(input$type == 'type1'){
            return(isolate(anova(lm(csvfile()[,input$dvar] ~ csvfile()[,input$ivar], data = csvfile()))))
          }
          
          if(input$type == 'type2'){
            return(isolate(Anova(lm(csvfile()[,input$dvar] ~ csvfile()[,input$ivar], data = csvfile())), 
                           Type = "II", test.statistic = "F"))
          }
          
          if(input$type == 'type3'){
            isolate(
              fit <- aov(csvfile()[,input$dvar] ~ csvfile()[,input$ivar], data = csvfile())
            )
            return(drop1(fit, ~ . , test = 'F'))
          }
        }
      })
    })
)
