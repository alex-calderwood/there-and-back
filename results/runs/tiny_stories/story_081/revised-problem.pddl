(define (problem play-with-toy-cat)
  (:domain
    toy-cat-story)
  (:objects
    boy - character
    toy-cat - character
    house - place
    square-box - item)
  (:init
    (at boy house)
    (inside square-box house)
    (inside toy-cat square-box)
    (not (happy toy-cat))
    (intends boy (happy toy-cat))
  )
  (:goal
    (happy toy-cat)
  )
)