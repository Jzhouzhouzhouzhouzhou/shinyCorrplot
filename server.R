
shinyServer(
function(input, output){
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
)
