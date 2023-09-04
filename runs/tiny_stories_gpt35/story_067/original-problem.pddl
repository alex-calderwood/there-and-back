(define (problem toy-factory-problem)
  (:domain toy-factory)
  (:objects
    tom - worker
    factory toy1 toy2 toy3 - object)
  (:init
    (at tom factory)
    (clean factory)
    (intends tom (and (at tom factory) (clean factory)))
    (intends tom (and (made toy1) (made toy2) (made toy3)))
    (intends tom (friend tom ?other-worker))
    (intends tom (friend ?other-worker tom))
  )
  (:goal
    (and (made toy1) (made toy2) (made toy3))
  )
)