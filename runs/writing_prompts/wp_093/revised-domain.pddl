(define (domain reddit-civil-war)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character subreddit - object)
  (:predicates
    (wearing ?character - character ?clothing - object)
    (united ?subreddit1 - subreddit ?subreddit2 - subreddit)
    (truce ?subreddit1 - subreddit ?subreddit2 - subreddit)
    (exists ?subreddit - subreddit)
    (wall-built)
    (filled-with-water)
  )

  ;; A character wears a specific clothing.
  (:action wear
    :parameters
      (?character - character ?clothing - object)
    :effect
      (wearing ?character ?clothing)
    :agents
      (?character)
  )

  ;; Subreddits unite.
  (:action unite
    :parameters
      (?subreddit1 - subreddit ?subreddit2 - subreddit)
    :precondition
      (not (united ?subreddit1 ?subreddit2))
    :effect
      (united ?subreddit1 ?subreddit2)
    :agents
      (?subreddit1 ?subreddit2)
  )

  ;; A truce is established between subreddits.
  (:action establish-truce
    :parameters
      (?subreddit1 - subreddit ?subreddit2 - subreddit)
    :precondition
      (not (truce ?subreddit1 ?subreddit2))
    :effect
      (truce ?subreddit1 ?subreddit2)
    :agents
      (?subreddit1 ?subreddit2)
  )

  ;; A subreddit is created.
  (:action create-subreddit
    :parameters
      (?subreddit - subreddit)
    :effect
      (exists ?subreddit)
    :agents
      (?subreddit)
  )

  ;; A wall is built.
  (:action build-wall
    :effect
      (wall-built)
  )

  ;; The wall is filled with water.
  (:action fill-wall-with-water
    :precondition
      (wall-built)
    :effect
      (filled-with-water)
  )
)