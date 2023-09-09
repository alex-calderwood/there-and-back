(define (problem find-spaghetti)
  (:domain hide-and-seek)
  (:objects
    lily spaghetti - toy)
  (:init
    (not (hidden spaghetti))
    (not (found spaghetti)))
  (:goal
    (found spaghetti)
  )
)