(define (problem tom-plays)
  (:domain tom-the-cat)
  (:objects
    tom - cat
    mouse - toy)
  (:init
    (awake tom)
    (has tom mouse)
    (intends tom (playing tom mouse)))
  (:goal
    (and (awake tom)
    (playing tom mouse)))
)