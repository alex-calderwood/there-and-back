(define (problem spot-perfume)
  (:domain
    spot-the-dog)
  (:objects
    spot - character
    perfume - object)
  (:init
    (impatient spot)
    (has-ball spot)
    (on-table perfume)
    (intends spot (has spot perfume))
    (intends spot (smells-nice spot))
    (intends spot (playing-with-ball spot))
  )
  (:goal
    (and (smells-nice spot)
    (playing-with-ball spot))
  )
)