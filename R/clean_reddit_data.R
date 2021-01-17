#' clean_reddit_data
#'
#' @param reddit_data A dataframe of reddit data
#'
#' @return data.frame
#' @export clean_reddit_data
clean_reddit_data <- function(reddit_data = NULL) {
  reddit_data <-
    reddit_data %>%
    select(unique_id, name, object) %>%
    pivot_wider(names_from = name, values_from = object, values_fill = NA)

  reddit_data <- split(reddit_data, reddit_data$unique_id)

  reddit_data <- map_df(
    reddit_data,
    function(submission) {
      map(submission, function(item) {
        unlist(as.character(item))
      })
    }
  )

  reddit_data
}
