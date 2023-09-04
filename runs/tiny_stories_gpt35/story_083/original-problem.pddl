(define (problem spot-and-cat-play)
  (:domain spot-and-cat)
  (:objects
    spot cat - animal)
  (:init
    (scared spot)
    (not (friendly cat))
    (intends spot (friendly cat))
    (intends cat (friendly spot)))
  (:goal
    (and (playing spot)
    (playing cat)
    (not (scared spot))
    (not (scared cat)))
  )
)