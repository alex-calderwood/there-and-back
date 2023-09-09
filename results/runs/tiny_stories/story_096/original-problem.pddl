(define (problem swing-friends)
  (:domain
    swing-time)
  (:objects
    lily tom - character)
  (:init
    (has-swing lily)
    (intends lily (happy lily))
    (intends lily (happy tom))
    (intends tom (happy tom))
  )
  (:goal
    (and (happy lily)
    (happy tom))
  )
)