(define (problem tom-plays-and-naps)
  (:domain
    tom-the-cat)
  (:objects
    tom - character)
  (:init
    (awake tom)
    (has-energy tom)
    (intends tom (playing tom))
    (intends tom (sleeping tom))
    (intends tom (awake tom))
    (intends tom (has-energy tom)))
  (:goal
    (and (awake tom)
    (has-energy tom)
    (playing tom)))
)