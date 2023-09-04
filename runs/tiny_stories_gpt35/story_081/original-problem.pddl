(define (problem toy-cat-playtime)
  (:domain toy-cat)
  (:objects
    square-box tidy-house toy-cat - toy
    little-boy - object)
  (:init
    (not (inside toy-cat square-box))
    (inside square-box tidy-house)
    (not (happy toy-cat))
    (intends little-boy (play-with toy-cat))
  )
  (:goal
    (and (played toy-cat)
    (happy toy-cat))
  )
)