source("utils.R")

args <- commandArgs(trailingOnly=T);

port <- as.numeric(args[[1]]);

house <- read_csv("derived_data/clean_stats.csv") %>%
  nice_names()%>%
  na.omit()

stats <- house %>% select(-id, -date,-zipcode,-price) %>% names();

ui <- pageWithSidebar(
  headerPanel('Interaction Plot: Select GBM Parameters and Predictor You Want To Visualize'),
  sidebarPanel(
    sliderInput(inputId = "numTrees", label = "Number of decision trees", min = 1, max = 1000, value = 100),
    selectInput(inputId = "bagFrac", label = "Sub-sample train data size for each tree", choices = list(0.5,0.6,0.7,0.8,0.9,"1.0" = 1.0)),
    sliderInput(inputId = "depth", label = "Depth to which each tree should be grown", min = 1, max = 50, value = 5),
    selectInput(inputId = "shrinkage", label = "Shrinkage parameter", choices = list(1,0.1,0.01,0.001)),
    selectInput(inputId = "stat",
                label="Select Stat",
                choices=stats)
  ),
  mainPanel(
    plotOutput(outputId = "predictionPlot")
   
    )
) 

server<-function (input, output){
  
  set.seed(123)
  
  
  output$predictionPlot<-renderPlot({
    
        fit<-gbm (price~bedrooms+bathrooms+sqft_living+sqft_lot+floors+waterfront+view+
                condition+grade+sqft_above+sqft_basement+yr_built+yr_renovated+lat
              +long+sqft_living15+sqft_lot15, data=house,distribution="gaussian",n.trees=input$numTrees,
              shrinkage = as.numeric(input$shrinkage), interaction.depth = input$depth, 
              bag.fraction = as.numeric(input$bagFrac))
    
         predictions<-pdp::partial(fit, pred.var =input$stat, rug = TRUE, n.trees=input$numTrees)
    
         house$pred<-predict.gbm(fit, house,n.trees = input$numTrees,type = "link")
    
            a<-ggplot() + 
             geom_line(data = predictions, aes_(x=as.name(input$stat), y =as.name("yhat"),colour = "Partial dependency"),size=1) + 
             geom_line(data = house, aes_(x =as.name(input$stat), y =as.name("price"),colour = "Actual",alpha=0.4), size=1) +
             geom_line(data = house, aes_(x =as.name(input$stat), y =as.name("pred"),colour = "Full model prediction",alpha=0.4), size=1) +
             xlab("Predictor selected") + ylab("Price") +  
             theme(
               axis.title.x = element_text(color="blue", size=14, face="bold"),
               axis.title.y = element_text(color="maroon", size=14, face="bold"),
               axis.text.x = element_text(size=14),
               axis.text.y = element_text(size=14),
               legend.text = element_text(size = 16),
               legend.position = "right",
               legend.title = element_blank()
             )
         
            b<-ggplot(house,aes_(x=as.name("pred"),y=as.name("price"),color=as.name(input$stat),alpha=0.4))+
              geom_point() +
              xlab("Predicted price") + ylab("Actual price") +
              theme( 
              axis.title.x = element_text(color="blue", size=14, face="bold"),
              axis.title.y = element_text(color="maroon", size=14, face="bold"),
              axis.text.x = element_text(size=14),
              axis.text.y = element_text(size=14),
              legend.text = element_text(size = 16),
              legend.position = "right",
              legend.title = element_blank()
              )+title(main = 'point cloud of real estates actual price vs pridicted price ')
            grid.arrange(a,b)
         
        
         
  }, height = 500, width = 800)
  
  
}

print(sprintf("Starting shiny on port %d", port));
shinyApp(ui = ui, server = server, options = list(port=port, host="0.0.0.0"));


