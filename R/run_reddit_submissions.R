# run_reddit_submissions
#' @export run_reddit_submissions
run_reddit_submissions <- function( subreddit = 'all', limit = 1000, sleep = 1) {
  con <- connection_postgres()
  on.exit({dbDisconnect(con)})
  reddit_con <- connection_reddit()
  # debug(reddit_crawl_submissions)
  reddit_response <- reddit_crawl_submissions(reddit_con, subreddit = subreddit, limit = limit)
  reddit_data <- clean_reddit_data(reddit_response)
  
  # dbRemoveTable(conn = con, name = "submissions")
  if (!dbExistsTable(conn = con, name = "submissions")) {
    dbCreateTable(conn = con, name = "submissions", fields = reddit_data)
  }
  
  dbxUpsert(con, "submissions", reddit_data, where_cols=c("unique_id"))
  print(reddit_data)
  message(glue("Sleeping for {sleep} seconds"))
  Sys.sleep(sleep)
}
