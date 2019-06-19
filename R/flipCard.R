#' Rotating card
#'
#' flip card for Bootstrap.
#'
#' @param front Card front content.
#' @param front_footer Card front footer
#' @param back Card back content.
#' @param back_footer Card back footer.
#' @param back_header Card back header.  Slot for \link{backHeader}.
#' @param flip_cover Card front header cover. Slot for \link{flipCover}.
#' @param flip_user Card front user cover.  Slot for \link{flipUser}.
#' @param width Card width.
#' @param auto Whether to flip on hover or not. FALSE by default.
#'
#'
#' @return a shiny tag.
#' @export
#'
#' @examples
#' if (interactive()) {
#'  shinyApp(
#'   ui = fluidPage(
#'     flipCard(
#'       front = tagList(
#'         numericInput("n", "n", 1),
#'         plotOutput("plot")
#'       ),
#'       #flip_cover = flipCover("https://demos.creative-tim.com/rotating-css-card/images/rotating_card_thumb.png"),
#'       #flip_user = flipUser("https://demos.creative-tim.com/rotating-css-card/images/rotating_card_profile2.png"),
#'       front_footer = "I am the front footer",
#'       back = tagList(
#'         checkboxGroupInput(
#'           inline = TRUE,
#'           "variable",
#'           "Variables to show:",
#'           c("Cylinders" = "cyl",
#'             "Transmission" = "am",
#'             "Gears" = "gear")
#'         ),
#'         tableOutput("data")
#'       ),
#'       back_footer = "This is the back footer"
#'     )
#'   ),
#'   server = function(input, output) {
#'     output$plot <- renderPlot( plot(head(cars, input$n)) )
#'     output$data <- renderTable({
#'       mtcars[, c("mpg", input$variable), drop = FALSE]
#'     }, rownames = TRUE)
#'   }
#'  )
#' }
flipCard <- function(front = NULL, front_footer = NULL, back = NULL, back_footer = NULL,
                     back_header = NULL, flip_cover = NULL, flip_user = NULL, width = 6,
                     auto = FALSE) {

  frontTag <- htmltools::tags$div(
    class = "front",
    if (!is.null(flip_cover)) flip_cover,
    if (!is.null(flip_user)) flip_user,
    htmltools::tags$div(
      class = "content",
      htmltools::tags$div(class = "main", front),
      htmltools::tags$div(
        class = "footer",
        htmltools::tags$div(
          class = "rating",
          if (!auto) {
            shiny::tagList(
              htmltools::tags$button(
                class = "btn btn-simple",
                onclick = "rotateCard(this)",
                shiny::icon("mail-forward")
              ),
              front_footer
            )
          } else {
            shiny::taglist(shiny::icon("mail-forward"), front_footer)
          }
        )
      )
    )
  )

  backTag <- htmltools::tags$div(
    class = "back",
    if (!is.null(back_header)) back_header,
    htmltools::tags$div(
      class = "content",
      style = "overflow-y: auto;",
      htmltools::tags$div(class = "main", back)
    ),
    htmltools::tags$div(
      class = "footer",
      if (!auto) {
        shiny::tagList(
          htmltools::tags$button(
            class = "btn btn-simple",
            onclick = "rotateCard(this)",
            shiny::icon("mail-forward")
          ),
          back_footer
        )
      } else {
        shiny::taglist(shiny::icon("mail-forward"), back_footer)
      }
    )
  )

  containerCl <- "card-container"
  if (!auto) containerCl <- paste0(containerCl, " manual-flip")

  flipCardTag <- shiny::column(
    width = width,
    htmltools::tags$div(
      class = containerCl,
      htmltools::tags$div(class = "card", frontTag, backTag)
    )
  )

  htmltools::attachDependencies(flipCardTag, flipCardDeps())
}



#' Header tag for \link{flipCard}
#'
#' @param ... Header content.

#' @export
backHeader <- function(...) {
  htmltools::tags$div(class = "header", ...)
}



#' Cover tag for \link{flipCard}
#'
#' @param src Cover url or path.

#' @export
flipCover <- function(src = NULL) {
  htmltools::tags$div(class = "cover", htmltools::tags$img(src = src))
}



#' User image tag for \link{flipCard}
#'
#' @param src User url or path.

#' @export
flipUser <- function(src = NULL) {
  htmltools::tags$div(class = "user", htmltools::tags$img(class = "img-circle", src = src))
}

