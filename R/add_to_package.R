#' add_to_package
#' @export add_to_package
add_to_package <- function(x = c("RPostgres", "DBI", "dbplyr")) {
  walk(x, function(y) {
    install.packages(y)
    usethis::use_package(y, type = "Depends")
  })
}
