(define (problem spot-fluffy-blocks)
  (:domain
    spot-and-fluffy)
  (:objects
    spot fluffy - character)
  (:init
    (intends spot (happy spot))
    (intends fluffy (happy fluffy))
    (intends fluffy (helping fluffy spot))
  )
  (:goal
    (and (happy spot)
    (happy fluffy)
    (stack-strong spot))
  )
)