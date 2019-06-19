flipCardDeps <- function() {
  htmltools::htmlDependency(
    name = "flipBox",
    version = "1.0",
    src = system.file("flipBox-1.0", package = "flipCards"),
    stylesheet = "css/rotating-card.css",
    script = "js/rotating-card.js"
  )
}
