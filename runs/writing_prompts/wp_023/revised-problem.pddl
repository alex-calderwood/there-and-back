(define (problem thomas-fredson-death-problem)
  (:domain
    thomas-fredson-death)
  (:objects
    thomas high-council - character)
  (:init
    (alive thomas)
    (has-plan thomas)
    (intends thomas (alive thomas))
    (intends thomas (has-idea thomas))
    (alive high-council)
    (intends high-council (dead thomas))
    (intends high-council (has-time thomas))
    (has-tv-show-reference thomas))
  (:goal
    (and (has-idea thomas)
    (not (has-creative-plan thomas))
    (has-time thomas)
    (alive thomas))
  )
)