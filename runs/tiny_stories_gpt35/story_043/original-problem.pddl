(define (problem rabbit-tail-problem)
  (:domain rabbit-tail)
  (:objects
    remy - rabbit
    friend1 friend2 friend3 - rabbit)
  (:init
    (has-long-tail remy)
    (not (scared remy))
    (not (scared friend1))
    (not (scared friend2))
    (not (scared friend3))
  )
  (:goal (and (found-hole) (not (scared remy)))))