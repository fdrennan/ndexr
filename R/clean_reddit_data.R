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

  reddit_data <- transmute(
    reddit_data,
    unique_id = as.character(unique_id),
    allow_live_comments = as.logical(allow_live_comments),
    archived = as.logical(archived),
    author = as.character(author),
    author_flair_type = as.character(author_flair_type),
    author_fullname = as.character(author_fullname),
    author_patreon_flair = as.logical(author_patreon_flair),
    author_premium = as.logical(author_premium),
    can_gild = as.logical(can_gild),
    can_mod_post = as.logical(can_mod_post),
    clicked = as.logical(clicked),
    comment_limit = as.double(comment_limit),
    comment_sort = as.character(comment_sort),
    contest_mode = as.logical(contest_mode),
    created = as.double(created),
    downs = as.double(downs),
    edited = as.logical(edited),
    fullname = as.character(fullname),
    gilded = as.double(gilded),
    hidden = as.logical(hidden),
    hide_score = as.logical(hide_score),
    id = as.character(id),
    is_crosspostable = as.logical(is_crosspostable),
    is_meta = as.logical(is_meta),
    is_original_content = as.logical(is_original_content),
    is_reddit_media_domain = as.logical(is_reddit_media_domain),
    is_robot_indexable = as.logical(is_robot_indexable),
    is_self = as.logical(is_self),
    is_video = as.logical(is_video),
    locked = as.logical(locked),
    media_only = as.logical(media_only),
    name = as.character(name),
    no_follow = as.logical(no_follow),
    num_comments = as.double(num_comments),
    num_crossposts = as.double(num_crossposts),
    over_18 = as.logical(over_18),
    parent_whitelist_status = as.character(parent_whitelist_status),
    permalink = as.character(permalink),
    pinned = as.logical(pinned),
    pwls = as.double(pwls),
    quarantine = as.logical(quarantine),
    saved = as.logical(saved),
    score = as.double(score),
    selftext = as.character(selftext),
    send_replies = as.logical(send_replies),
    shortlink = as.character(shortlink),
    spoiler = as.logical(spoiler),
    stickied = as.logical(stickied),
    STR_FIELD = as.character(STR_FIELD),
    subreddit = as.character(subreddit),
    subreddit_id = as.character(subreddit_id),
    subreddit_name_prefixed = as.character(subreddit_name_prefixed),
    subreddit_subscribers = as.double(subreddit_subscribers),
    subreddit_type = as.character(subreddit_type),
    thumbnail = as.character(thumbnail),
    title = as.character(title),
    total_awards_received = as.double(total_awards_received),
    ups = as.double(ups),
    upvote_ratio = as.double(upvote_ratio),
    url = as.character(url),
    visited = as.logical(visited),
    whitelist_status = as.character(whitelist_status),
    wls = as.double(wls)
  )
  
  reddit_data
}
