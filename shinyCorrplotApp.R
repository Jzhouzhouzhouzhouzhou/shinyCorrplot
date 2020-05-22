library(shiny)
library(corrplot)
library(shinyBS)
library(RColorBrewer)
library(shinythemes)
ui <- navbarPage(
  title="corrplot",
  theme=shinytheme("journal"),
  windowTitle="make corrplot in R with shiny",
  
  tabPanel(
    "corrplot",
    
    sidebarPanel(
      fileInput("uploadCorrplotData", h4("Upload input data",
                                         bsButton("bsq0", label="", icon=icon("question"), style="info", size="small")
                                         ),multiple = FALSE),
      bsPopover("bsq0", "The first row and the first column of the uploaded file must have corresponding row and column names.", trigger = "focus"),
      radioButtons("var5",
                   h4("Is it a correlation matrix?",
                      bsButton("bsq5", label="", icon=icon("question"), style="info", size="small")),  
                   choices = list("YES" = "T", "NO" = "F"), selected = "T"),
      bsPopover("bsq5", "If not, select No.",
                trigger = "focus"),
      selectInput("var1",
                  h4("choose a visualization method to display", 
                     bsButton("bsq1", label="", icon=icon("question"), style="info", size="small")),
                  choices = c("circle",
                              "square",
                              "ellipse",
                              "number",
                              "shade",
                              "color",
                              "pie")),
      bsPopover("bsq1", "There are seven visualization methods (parameter method) in the corolot package.",
                trigger = "focus"),
      selectInput("var2",
                  h4("choose a Layout to display",
                     bsButton("bsq2", label="", icon=icon("question"), style="info", size="small")),
                  choices = c("full",
                              "upper",
                              "lower")),
      bsPopover("bsq2", "There are three layout types (parameter types): full(default): display the full correlation matrix, upper: display the upper triangle of the correlation matrix, lower: display the lower triangle of the correlation matrix",
                trigger = "focus"),
      conditionalPanel(condition = "input.var5 == 'T'",
                       selectInput("var3",
                                   h4("choose a method to reorder",
                                      bsButton("bsq3", label="", icon=icon("question"), style="info", size="small")),  
                                   choices = c("original", "AOE", "FPC", "hclust", "alphabet"))          
      ),
      bsPopover("bsq3", "There are 5 methods in the corolot (parameter order).",
                trigger = "focus"),
      
      conditionalPanel(condition = "input.var5 == 'F'",
                       selectInput("var6",
                                   h4("choose a method to reorder",
                                      bsButton("bsq33", label="", icon=icon("question"), style="info", size="small")),  
                                   choices = c("original", "FPC", "hclust"))          
      ),
      bsPopover("bsq33", "There are 3 methods in the corolot (parameter order).",
                trigger = "focus"),
      selectInput("var4",
                  h4("choose color",
                     bsButton("bsq4", label="", icon=icon("question"), style="info", size="small")),  
                  choices = c("Spectral", "RdYlGn", "RdYlBu", "RdGy", "RdBu", "PuOr", "PRGn", "PiYG", "BrBG")),
      bsPopover("bsq4", "Choose the color you want.",
                trigger = "focus"),
      numericInput("num",("addrect"),value = 1,min=1,max=15,step=1),
      bsPopover("num", "Only from 1 to 15 can be selected.",
                trigger = "focus"),
      actionButton("submit1", strong("Go!"))
    
    ),
    
    mainPanel(
      downloadButton("downloadcorrplot.pdf","Download pdf-file"),
      downloadButton("downloadcorrplot.svg","Download svg-file"),
       plotOutput("corrplot")
      
    )
    
  ),
  tabPanel("Help",includeMarkdown("HELP.md")),
  
  tabPanel("About",includeMarkdown("About.md"))
  )

server <- function(input, output){
  observe({
    if(input$submit1 > 0){
      isolate({
        data.in <- input$uploadCorrplotData$datapath
        output$corrplot <- renderPlot({
          file <- read.table(data.in, header = T, row.names = 1, sep = ",")
          file <- as.matrix(file)
          colors <- brewer.pal(11, input$var4)
          if (input$var5 == "T") {
            corrplot(file, method = input$var1, type = input$var2, order =input$var3, bg ="white",
                     is.corr = switch(input$var5,T = TRUE, F = FALSE), col = colors, addrect = input$num)
          } else {
            corrplot(file, method = input$var1, type = input$var2, order =input$var6, bg ="white",
                     is.corr = switch(input$var5,T = TRUE, F = FALSE), col = colors, addrect = input$num)
          }
          
        })
      })
    }else{
        NULL
      }
  })
  
  output$downloadcorrplot.pdf <- downloadHandler(
    filename = function(){paste('corrplot.pdf')},
    content <- function(file){
      pdf(file, width = 10, height = 10)    
      file <- read.table(input$uploadCorrplotData$datapath, header = T, row.names = 1 , sep = ",")
      file <- as.matrix(file)
      colors <- brewer.pal(11, input$var4)
      if (input$var5 == "T") {
        corrplot(file, method = input$var1, type = input$var2, order =input$var3, bg ="white",
                 is.corr = switch(input$var5,T = TRUE, F = FALSE), col = colors, addrect = input$num)
      } else {
        corrplot(file, method = input$var1, type = input$var2, order =input$var6, bg ="white",
                 is.corr = switch(input$var5,T = TRUE, F = FALSE), col = colors, addrect = input$num)
      }
      dev.off()},
    contentType = "application/pdf")
  
  output$downloadcorrplot.svg <- downloadHandler(
    filename = function(){paste('corrplot.svg')},
    content <- function(file){
      svg(file, width = 10, height = 10)    
      file <- read.table(input$uploadCorrplotData$datapath, header = T, row.names = 1 , sep = ",")
      file <- as.matrix(file)
      colors <- brewer.pal(11, input$var4)
      if (input$var5 == "T") {
        corrplot(file, method = input$var1, type = input$var2, order =input$var3, bg ="white",
                 is.corr = switch(input$var5,T = TRUE, F = FALSE), col = colors, addrect = input$num)
      } else {
        corrplot(file, method = input$var1, type = input$var2, order =input$var6, bg ="white",
                 is.corr = switch(input$var5,T = TRUE, F = FALSE), col = colors, addrect = input$num)
      }
      dev.off()},
    contentType = "application/svg")
}
shinyApp(ui, server)


