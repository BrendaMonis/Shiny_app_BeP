#####Shiny App#####

#####Introduction#####

  #If you haven’t already installed Shiny, install it now with:
  install.packages("shiny")

  #Then load in your current R session:
  library(shiny)

  ####Create App Directory and File####
  
    library(shiny) #It calls library(shiny) to load the shiny package
    #Nesse ponto definimos a interface que os usuários terão contato
    ui <- fluidPage(
      "Hello, world!" 
    )
    #Aqui decidimos o que rodará por trás do aplicativo
    server <- function(input, output, session) {
    }
    #Com isso, damos estar ao aplicativo
    shinyApp(ui, server)
    
    #Podemos rodar o aplicativo de diferente formas, dentre ela:
    shiny::runApp(file)
    
  ####Adding UI controls####
    
    ##We're gonna show you all the built-in data frames includedin the datasets package.
    library(shiny) 
    ui <- fluidPage(
      selectInput("dataset", label = "Dataset", #label = - It includes name
                  choices = ls("package:datasets")),
      verbatimTextOutput("summary"),
      tableOutput("table")
    )
    server <- function(input, output, session) {
    }
    shinyApp(ui, server)
    
    #fluidPage()- A layout function that sets up the basic visual structure of 
                  #the page.
    #selectInput()- An input control that lets the user interact with the app 
                    #by providing a value.
    #verbatimTextOutput() and tableOutput()- verbatimTextOutput() displays code,
                                             #and tableOutput()displays tables.

  ####Adding Behavior####
    
    library(shiny) 
    ui <- fluidPage(
      selectInput("dataset", label = "Dataset", #label = - It includes name
                  choices = ls("package:datasets")),
      verbatimTextOutput("summary"),
      tableOutput("table")
    )
    server <- function(input, output, session) {
      output$summary <- renderPrint({
        dataset <- get(input$dataset, "package:datasets")
        summary(dataset)
      })
      output$table <- renderTable({
        dataset <- get(input$dataset, "package:datasets") #Here, you created
        #the variable
        dataset #It's what the user'll see 
      })
    }
    shinyApp(ui, server)
    
    #output$ID - indicates that you’re providing the recipe for the Shiny output
      #with that ID.
    #Use a specific *render function* to wrap some code that you provide. Each
      #render{Type} function is designed to produce a particular type of output.
  
  ####Reducing Duplication with Reactive Expressions(pag.08)####
    
    library(shiny) 
    ui <- fluidPage(
      selectInput("dataset", label = "Dataset",
                  choices = ls("package:datasets")),
      verbatimTextOutput("summary"),
      tableOutput("table")
    )
    server <- function(input, output, session) {
      # Create a reactive expression
      dataset <- reactive({
        get(input$dataset, "package:datasets")
      })
      output$summary <- renderPrint({
        # Use a reactive expression by calling it like a function
        # Looking that we only called the variable here
        summary(dataset())
      })
      output$table <- renderTable({
        dataset()
      })
    }
    shinyApp(ui, server)
    
  ####Exercise####
    
  ##Exercise.01- Create an app that greets the user by name
    library(shiny) 
    ui <- fluidPage(
      selectInput("dataset", label = "Dataset",
                  choices = ls("package:datasets")),
    )
    server <- function(input, output, session) {
      tableOutput("mortgage")
      output$greeting <- renderText({
        paste0("Hello ", input$name)
      })
      numericInput("age", "How old are you?", value = NA)
      textInput("name", "What's your name?")
      textOutput("greeting")
      output$histogram <- renderPlot({
        hist(rnorm(1000))
      }, res = 96)
    }
    shinyApp(ui, server)
    
#####Basic UI (pag. 16)#####
    
  #All input functions have the same first argument: inputID
  #If your UI has an input with ID "name", the server function will access it
    #with input$name
  #Most input functions have a second parameter called *label*. This is used to 
    #create a human-readable label for the control.
  #The third parameter is typically value, which, where possible, lets you set
    #the default value.
  
  ####Free Text####
    library(shiny) 
    ui <- fluidPage(
      textInput("name", "What's your name?"),
      passwordInput("password", "What's your password?"),
      textAreaInput("story", "Tell me about yourself", rows = 3)
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
  ####Numeric Imputs####
    library(shiny) 
    ui <- fluidPage(
      numericInput("num", "Number one", value = 0, min = 0, max = 100),
      sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
      sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100)
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
  ####Dates####
    library(shiny) 
    ui <- fluidPage(
      dateInput("dob", "When were you born?"),
      dateRangeInput("holiday", "When do you want to go on vacation next?")
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
  ####Limited Choices####
    library(shiny)
    animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
    ui <- fluidPage(
      selectInput("state", "What's your favourite state?", state.name),
      radioButtons("animal", "What's your favourite animal?", animals)
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
    ##choiceNames/choiceValues
    library(shiny)
    animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
    ui <- fluidPage(
      radioButtons("rb", "Choose one:",
                   choiceNames = list( #*choiceNames* determines what is shown to the user
                     icon("angry"),
                     icon("smile"),
                     icon("sad-tear")
                   ),
                   choiceValues = list("angry", "happy", "sad")
                   #*choiceValues* determines what is returned in your server function
      )
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
    ##Select multiple elements
    library(shiny)
    animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
    ui <- fluidPage(
      selectInput(
        "state", "What's your favourite state?", state.name,
        multiple = TRUE #Allow the user to select multiple elements
      )
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
    ##Select multiple values with buttons
    library(shiny)
    animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
    ui <- fluidPage(
      checkboxGroupInput("animal", "What animals do you like?", animals)
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
    ##Single checkbox for a single yes/no question
    library(shiny)
    ui <- fluidPage(
      checkboxInput("cleanup", "Clean up?", value = TRUE),
      checkboxInput("shutdown", "Shutdown?")
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
  ####File Uploads####
    library(shiny)
    ui <- fluidPage(
      fileInput("upload", NULL)
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
    #Another example
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
                       selected = "head")
          
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
          
          # Output: Data file ----
          tableOutput("contents")
          
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
      
    }
    shinyApp(ui, server)

  ####Action Buttons####
    library(shiny)
    ui <- fluidPage(
      actionButton("click", "Click me!"),
      actionButton("drink", "Drink me!", icon = icon("cocktail"))
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    #Action links and buttons are most naturally paired with *observeEvent()* or 
      #even *tReactive()* in your server function.
    
    #You can customize the appearance using the class argument
    library(shiny)
    ui <- fluidPage(
      fluidRow(
        actionButton("click", "Click me!", class = "btn-danger"),
        actionButton("drink", "Drink me!", class = "btn-lg btn-success")
      ),
      fluidRow(
        actionButton("eat", "Eat me!", class = "btn-block")
      )
    )
    server <- function(input, output, session) {
      
    }
    shinyApp(ui, server)
    
    
#####Outputs (pag. 16)####
    
    ##Each output function on the frontend is coupled with a render function in 
      #the back‐end.
    ##Outputs in the UI create placeholders that are later filled by the 
      #server function.
    
  ####Text####
    
    library(shiny)
    ui <- fluidPage(
      textOutput("text"),
      verbatimTextOutput("code")
    )
    server <- function(input, output, session) {
      output$text <- renderText({
        "Hello friend!"
      })
      output$code <- renderPrint({
        summary(1:10)
      })
    }
    shinyApp(ui, server)
    
    ##Note that the {} are only required in render functions if you need to run
      #multiple lines of code.
    ##renderText() - This combines the result into a single string and is usually
      #paired with textOutput().
    ##renderPrint() - This prints the result, as if you were in an R console, and
      #is usually paired with verbatimTextOutput().
    ##Example
      library(shiny)
      ui <- fluidPage(
        textOutput("text"),
        verbatimTextOutput("print")
      )
      server <- function(input, output, session) {
        output$text <- renderText("hello!")
        output$print <- renderPrint("hello!")
      }
      shinyApp(ui, server)
    
  ####Tables####
      
    ##tableOutput() and renderTable() - These render a static table of data, 
      #showing all the data at once.
    ##dataTableOutput() and renderDataTable() - These render a dynamic table, showing
      #a fixed number of rows along with controls to change which rows are visible.
  
      library(shiny)
      ui <- fluidPage(
        tableOutput("static"),
        dataTableOutput("dynamic")
      )
      server <- function(input, output, session) {
        output$static <- renderTable(head(mtcars))
        output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
      } 
      shinyApp(ui, server)
    
  ####Plots####
    
    ##You can display any type of R graphic (e.g., base or ggplot2) with 
      #plotOutput() and renderPlot()
      
      library(shiny)
      ui <- fluidPage(
        plotOutput("plot", width = "400px")
      )
      server <- function(input, output, session) {
        output$plot <- renderPlot(plot(1:5), res = 96)
      }
      shinyApp(ui, server)
  
    ##By default, plotOutput() will take up the full width of its container
      #(more on that shortly) and will be 400 pixels high.
    ##plotOutput() has a number of arguments like click, dblclick, and hover. 
      #If you pass these a string, like click = "plot_click", they’ll create a 
      #reactive input (input$plot_click) that you can use to handle user 
      #interaction on the plot (e.g., clicking on the plot).
        
  ####Downloads####
     
      ##You can let the user download a file with downloadButton() or 
        #downloadLink().

#####Basic Reactivity (pag. 27)#####
      
  ####Input####
      
    ##The input argument is a list-like object that contains all the input data 
      #sent from the browser, named according to the input ID.
    ##This error occurs because input reflects what’s happening in the browser, 
      #and the browser is Shiny’s “single source of truth.” 
    ##One more important thing about input: it’s selective about who is allowed
      #to read it.
      
  ####Output####
      
    ##output is very similar to input: it’s also a list-like object named 
      #according to the output ID. The main difference is that you use it for
      #sending output instead of receiving input.
    ##The render function does two things:
      ## It sets up a special reactive context that automatically tracks what
        #inputs the output uses.
      ##It converts the output of your R code into HTML suitable for display on a
        #web page.
      
  ####Reactive Programming####
      
    library(shiny)
    ui <- fluidPage(
      textInput("name", "What's your name?"),
      textOutput("greeting") #Looking that, you need a window in the UI that holds the output
    )
    server <- function(input, output, session) {
      output$greeting <- renderText({
        paste0("Hello ", input$name, "!")
    })
    }
    shinyApp(ui, server)
    
    ##This is the big idea in Shiny: you don’t need to tell an output when to 
      #update, because Shiny automatically figures it out for you.
    
  ####Imperative Versus Declarative Programming####
    
    ##Imperative Programming
      #Issue a specific command and it’s carried out immediately. This is the 
      #style of programming you’re used to in your analysis scripts.
    
    ##Declarative programming
      #Express higher-level goals or describe important constraints, and rely on
      #someone else to decide how and/or when to translate that into action. 
      #This is the style of programming you use in Shiny.
    
    ##Imperative code is assertive; declarative code is passive-aggressive.
    
  ####Reactive Graph####
    
    ##To describe this relationship, we’ll often say that greeting has a reactive
      #dependency on name.
    
  ####Reactive expression####
    
    ##think of it as a tool that reduces duplication in your reactive code by 
      #introducing additional nodes into the reactive graph.

    library(shiny)
    ui <- fluidPage(
      textInput("name", "What's your name?"),
      textOutput("greeting")
    )
    server <- function(input, output, session) {
      string <- reactive(paste0("Hello ", input$name, "!"))
      output$greeting <- renderText(string())
    }
    shinyApp(ui, server)
    
    ##Example-Importance of reactive expression
    library(ggplot2)
    freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
      df <- data.frame(
        x = c(x1, x2),
        g = c(rep("x1", length(x1)), rep("x2", length(x2)))
      )
      ggplot(df, aes(x, colour = g)) +
        geom_freqpoly(binwidth = binwidth, size = 1) +
        coord_cartesian(xlim = xlim)
    }
    t_test <- function(x1, x2) {
      test <- t.test(x1, x2)
      # use sprintf() to format t.test() results compactly
      sprintf(
        "p value: %0.3f\n[%0.2f, %0.2f]",
        test$p.value, test$conf.int[1], test$conf.int[2]
      )
    }
    
    ##Simulated data
    x1 <- rnorm(100, mean = 0, sd = 0.5)
    x2 <- rnorm(200, mean = 0.15, sd = 0.9)
    freqpoly(x1, x2)
    cat(t_test(x1, x2))
    
    ##The App - This Shiny app lets you compare two simulated distributions with
      #a t-test and a frequency polygon.
    library(shiny)
    ui <- fluidPage(
      fluidRow(
        column(4,
               "Distribution 1",
               numericInput("n1", label = "n", value = 1000, min = 1),
               numericInput("mean1", label = "µ", value = 0, step = 0.1),
               numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
        ),
        column(4,
               "Distribution 2",
               numericInput("n2", label = "n", value = 1000, min = 1),
               numericInput("mean2", label = "µ", value = 0, step = 0.1),
               numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
        ),
        column(4,
               "Frequency polygon",
               numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
               sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
        )
      ),
      fluidRow(
        column(9, plotOutput("hist")),
        column(3, verbatimTextOutput("ttest"))
      )
    )
    server <- function(input, output, session) {
      output$hist <- renderPlot({
        x1 <- rnorm(input$n1, input$mean1, input$sd1)
        x2 <- rnorm(input$n2, input$mean2, input$sd2)
        freqpoly(x1, x2, binwidth = input$binwidth, xlim = input$range)
      }, res = 96)
      output$ttest <- renderText({
        x1 <- rnorm(input$n1, input$mean1, input$sd1)
        x2 <- rnorm(input$n2, input$mean2, input$sd2)
        t_test(x1, x2)
      })
    }
    shinyApp(ui, server)
    
    
  ####Reactive Graph####
  
    ##Shiny is smart enough to update an output only when the inputs it refers 
      #to change; it’s not smart enough to only selectively run pieces of code inside an output.
    ##This creates two problems:
      #The app is hard to understand because there are so many connections.
      #The app is inefficient because it does more work than necessary.
    
    x1 <- rnorm(input$n1, input$mean1, input$sd1)
    x2 <- rnorm(input$n2, input$mean2, input$sd2)
    t_test(x1, x2)
    
    
  ####Simplifying the Graph####
    
    ##To create a reactive expression, we call reactive() and assign the results
      #to a variable. To later use the expression, we call the variable like it’s a function:
      
    ##Example - Using reactive expressions considerably simplifies the graph, 
      #making it much easier to understand.
    library(shiny)
    ui <- fluidPage(
      fluidRow(
        column(4,
               "Distribution 1",
               numericInput("n1", label = "n", value = 1000, min = 1),
               numericInput("mean1", label = "µ", value = 0, step = 0.1),
               numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
        ),
        column(4,
               "Distribution 2",
               numericInput("n2", label = "n", value = 1000, min = 1),
               numericInput("mean2", label = "µ", value = 0, step = 0.1),
               numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
        ),
        column(4,
               "Frequency polygon",
               numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
               sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
        )
      ),
      fluidRow(
        column(9, plotOutput("hist")),
        column(3, verbatimTextOutput("ttest"))
      )
    )
    server <- function(input, output, session) {
      x1 <- reactive(rnorm(input$n1, input$mean1, input$sd1))
      x2 <- reactive(rnorm(input$n2, input$mean2, input$sd2))
      output$hist <- renderPlot({
        freqpoly(x1(), x2(), binwidth = input$binwidth, xlim = input$range)
      }, res = 96)
      output$ttest <- renderText({
        t_test(x1(), x2())
      })
    }
    shinyApp(ui, server)
    
    ##Modules are an extremely useful and powerful technique for more complex apps.
    ##“Rule of three” of programming: whenever you copy and paste something three
      #times, you should figure out how to reduce the duplication(typically by writing a function).
    
    ##In Shiny, however, I think you should consider the rule of one: whenever 
      #you copy and paste something once, you should consider extracting the 
      #repeated code out into a reactive expression. 
    
    ####Why Do We Need Reactive Expressions?####
    
    library(shiny)
    ui <- fluidPage(
      fluidRow(
        column(4,
               "Distribution 1",
               numericInput("n1", label = "n", value = 1000, min = 1),
               numericInput("mean1", label = "µ", value = 0, step = 0.1),
               numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
        ),
        column(4,
               "Distribution 2",
               numericInput("n2", label = "n", value = 1000, min = 1),
               numericInput("mean2", label = "µ", value = 0, step = 0.1),
               numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
        ),
        column(4,
               "Frequency polygon",
               numericInput("binwidth", label = "Bin width", value = 0.1, step = 0.1),
               sliderInput("range", label = "range", value = c(-3, 3), min = -5, max = 5)
        )
      ),
      fluidRow(
        column(9, plotOutput("hist")),
        column(3, verbatimTextOutput("ttest"))
      )
    )
    server <- function(input, output, session) {
      x1 <- function() rnorm(input$n1, input$mean1, input$sd1)
      x2 <- function() rnorm(input$n2, input$mean2, input$sd2)
      output$hist <- renderPlot({
        freqpoly(x1(), x2(), binwidth = input$binwidth, xlim = input$range)
      }, res = 96)
      output$ttest <- renderText({
        t_test(x1(), x2())
      })
    }
    shinyApp(ui, server)
    
    ##If you run this code, you’ll get an error because you’re attempting to 
      #access input values outside of a reactive context. 
    ##Even if you didn’t get that error, you’d still have a problem: x1 and x2 
      #would only be computed once, when the session begins, not every time one 
      #of the inputs was updated.

  ####Controlling Timing of Evaluation####
    
    library(shiny)
    library(ggplot2)
    ui <- fluidPage(
      fluidRow(
        column(3,
               numericInput("lambda1", label = "lambda1", value = 3),
               numericInput("lambda2", label = "lambda2", value = 5),
               numericInput("n", label = "n", value = 1e4, min = 0)
        ),
        column(9, plotOutput("hist"))
      )
    )
    server <- function(input, output, session) {
      x1 <- reactive(rpois(input$n, input$lambda1))
      x2 <- reactive(rpois(input$n, input$lambda2))
      output$hist <- renderPlot({
        freqpoly(x1(), x2(), binwidth = 1, xlim = c(0, 40))
      }, res = 96)
    }
    shinyApp(ui, server)
    
  ##Timed Invalidation
    
    ##We can increase the frequency of updates with a new function: reactiveTimer().
    
    library(shiny)
    library(ggplot2)
    ui <- fluidPage(
      fluidRow(
        column(3,
               numericInput("lambda1", label = "lambda1", value = 3),
               numericInput("lambda2", label = "lambda2", value = 5),
               numericInput("n", label = "n", value = 1e4, min = 0)
        ),
        column(9, plotOutput("hist"))
      )
    )
    server <- function(input, output, session) {
      timer <- reactiveTimer(500)
      x1 <- reactive({
        timer()
        rpois(input$n, input$lambda1)
      })
      x2 <- reactive({
        timer()
        rpois(input$n, input$lambda2)
      })
      output$hist <- renderPlot({
        freqpoly(x1(), x2(), binwidth = 1, xlim = c(0, 40))
      }, res = 96)
    }
    shinyApp(ui, server)
    
    ##For example, the following code uses an interval of 500 ms so that the plot
      #will update twice a second.
    
  ####On Click (Pag. 46) - Pretty interesting####
    
    ##The same problem can happen if someone is rapidly clicking buttons in your
      #app and the computation you are doing is relatively expensive.
    ##It’s possible to create a big backlog of work for Shiny, and while it’s 
      #working on the backlog, it can’t respond to any new events.
    ##If this situation arises in your app, you might want to require the user 
      #to opt in to performing the expensive calculation by requiring them to 
      #click a button.
    
    library(shiny)
    library(ggplot2)
    ui <- fluidPage(
      fluidRow(
        column(3,
               numericInput("lambda1", label = "lambda1", value = 3),
               numericInput("lambda2", label = "lambda2", value = 5),
               numericInput("n", label = "n", value = 1e4, min = 0),
               actionButton("simulate", "Simulate!")
        ),
        column(9, plotOutput("hist"))
      )
    )
    server <- function(input, output, session) {
      x1 <- reactive({
        input$simulate #Look that
        rpois(input$n, input$lambda1)
      })
      x2 <- reactive({
        input$simulate
        rpois(input$n, input$lambda2)
      })
      output$hist <- renderPlot({
        freqpoly(x1(), x2(), binwidth = 1, xlim = c(0, 40))
      }, res = 96)
    }
    shinyApp(ui, server)
    
    ##This doesn’t achieve our goal because it just introduces a new dependency:
      #x1() and x2() will update when we click the simulate button, but they’ll 
      #also continue to update when lambda1, lambda2, or n change. 
    ##We want to replace the existing dependencies, not add to them.
    
    ##To solve this problem we need a new tool: a way to use input values without
      #taking a reactive dependency on them. 
    ##We need **eventReactive()**, which has two arguments:
      #the first argument specifies what to take a dependency on, and the second 
      #argument specifies what to compute.
    
    library(shiny)
    library(ggplot2)
    ui <- fluidPage(
      fluidRow(
        column(3,
               numericInput("lambda1", label = "lambda1", value = 3),
               numericInput("lambda2", label = "lambda2", value = 5),
               numericInput("n", label = "n", value = 1e4, min = 0),
               actionButton("simulate", "Simulate!")
        ),
        column(9, plotOutput("hist"))
      )
    )
    server <- function(input, output, session) {
      x1 <- eventReactive(input$simulate, {
        rpois(input$n, input$lambda1)
      })
      x2 <- eventReactive(input$simulate, {
        rpois(input$n, input$lambda2)
      })
      output$hist <- renderPlot({
        freqpoly(x1(), x2(), binwidth = 1, xlim = c(0, 40))
      }, res = 96)
    }
    shinyApp(ui, server)
    
    
