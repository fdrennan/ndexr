#' @export reddit_pull_submission
reddit_pull_submission <- function(reddit = NULL, name = NULL, type = NULL, limit = 10) {
  subreddit <- reddit$subreddit(name)
  subreddit <- switch(type, controversial = {
    subreddit$controversial(limit = limit)
  }, hot = {
    subreddit$hot(limit = limit)
  }, new = {
    subreddit$new(limit = limit)
  }, top = {
    subreddit$top(limit = limit)
  }, )
  comments <- iterate(subreddit)
  meta_data <- map_df(comments, ~ parse_meta(.))
  meta_data %>%
    mutate(
      submission_key = glue("{subreddit_id}_{author}_{name}")
    ) %>%
    select(submission_key, created_utc, everything())
}
