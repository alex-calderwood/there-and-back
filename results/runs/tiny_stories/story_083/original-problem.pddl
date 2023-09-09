(define (problem spot-and-cat-friends)
  (:domain
    spot-and-cat)
  (:objects
    spot cat - character)
  (:init
    (fierce cat)
    (scared spot cat)
    (intends spot (friends spot cat))
    (intends cat (friends cat spot)))
  (:goal
    (and (friends spot cat)
    (not (scared spot cat))))
)