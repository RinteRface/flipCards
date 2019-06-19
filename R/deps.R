flipCardDeps <- htmltools::htmlDependency(
  name = "flipBox",
  version = "1.0",
  src = system.file("css", package = "flipCards"),
  stylesheet = "rotating-card.css"
)
