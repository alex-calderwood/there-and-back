(define (problem lily-fairy-friends)
  (:domain
    lily-and-fairy)
  (:objects
    lily dog fairy - character)
  (:init
    (wearing-hat dog)
    (is-dog dog)
    (intends lily (not (wearing-hat dog)))
    (intends lily (is-fairy fairy))
    (intends lily (has-magic-flower lily))
    (intends lily (friends lily fairy))
    (intends lily (playing-together lily fairy)))
  (:goal
    (and (has-magic-flower lily)
    (friends lily fairy)
    (playing-together lily fairy)))
)