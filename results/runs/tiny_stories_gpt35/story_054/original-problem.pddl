(define (problem rabbit-race)
  (:domain rabbit-race)
  (:objects
    rabbit kid1 kid2 - participant
    start finish - location)
  (:init
    (at rabbit start)
    (at kid1 start)
    (at kid2 start)
    (intends rabbit (not (finished rabbit)))
    (intends kid1 (not (finished kid1)))
    (intends kid2 (not (finished kid2))))
  (:goal
    (and (at rabbit finish)
    (finished rabbit)
    (winner rabbit)))
)