(define (problem kitty-buddy-puzzle)
  (:domain
    kitty-buddy-puzzle)
  (:objects
    kitty buddy - character)
  (:init
    (sad kitty)
    (intends kitty (happy kitty))
    (intends kitty (puzzle-finished))
    (intends buddy (happy buddy))
    (intends buddy (puzzle-finished)))
  (:goal
    (and (happy kitty)
    (happy buddy)
    (puzzle-finished)
    (friends kitty buddy))
  )
)