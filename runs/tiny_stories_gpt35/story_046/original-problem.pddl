(define (problem spot-gets-perfume)
  (:domain spot-and-the-perfume)
  (:objects
    spot - dog
    perfume - item)
  (:init
    (on-table perfume)
    (smells-nice perfume)
    (intends spot (has spot perfume))
    (intends spot (smells-nice spot)))
  (:goal
    (and (has spot perfume)
    (smells-nice spot)))
)