# flipCards
[![CRAN status](https://www.r-pkg.org/badges/version/flipCards)](https://cran.r-project.org/package=flipCards)
[![Travis build status](https://travis-ci.org/RinteRface/flipCards.svg?branch=master)](https://travis-ci.org/RinteRface/flipCards)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/RinteRface/flipCards?branch=master&svg=true)](https://ci.appveyor.com/project/RinteRface/flipCards)

> Rotating cards with Bootstrap 


## Demonstration

```r
library(shiny)
library(flipCards)
 
 shinyApp(
  ui = fluidPage(
    flipCard(
      front = tagList(
        numericInput("n", "n", 1),
        plotOutput("plot")
      ),
      flip_cover = flipCover("https://image.flaticon.com/icons/svg/186/186236.svg"),
      flip_user = flipUser("https://image.flaticon.com/icons/svg/145/145867.svg"),
      front_footer = "I am the front footer",
      back = tagList(
        checkboxGroupInput(
          inline = TRUE,
          "variable",
          "Variables to show:",
          c("Cylinders" = "cyl",
            "Transmission" = "am",
            "Gears" = "gear")
        ),
        tableOutput("data")
      ),
      back_footer = "This is the back footer"
    )
  ),
  server = function(input, output) {
    output$plot <- renderPlot( plot(head(cars, input$n)) )
    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)
  }
 )
```
