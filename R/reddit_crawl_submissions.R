#' reddit_crawl_submissions
#'
#' @param reddit_con Connection to Reddit
#' @param subreddit A subreddit name, defaults to all
#' @param limit Amount of submissions you want
#'
#' @return data.frame
#' @export reddit_crawl_submissions
reddit_crawl_submissions <- function(reddit_con, subreddit = NULL, limit = 10) {
  if (!is.null(subreddit)) {
    submission_response <- iterate(reddit_con$subreddit(subreddit)$new(limit = limit))
  } else {
    submission_response <- iterate(reddit_con$front$new(limit = limit))
  }

  names_nfp <- names(submission_response[[1]])

  reddit_data <- map_dfr(
    submission_response,
    function(submission) {
      map_dfr(
        names_nfp,
        function(submission_title) {
          table_obj <- tibble(
            name = submission_title,
            object = {
              tryCatch(expr = {
                unlist(as.character(submission[submission_title]))
              }, error = function(err) {
                as.character('Error')
              })
            }
          )
          table_obj$unique_id <-
            paste(
              submission$id,
              submission$author,
              submission$subreddit,
              submission$created_utc,
              sep = "-"
            )
          table_obj
        }
      )
    }
  )
}
