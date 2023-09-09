(define (problem zigzag-park)
  (:domain zigzag-park)
  (:objects
    tim zigzag bird ball - object)
  (:init
    (at tim park)
    (at zigzag park)
    (at bird sky)
    (at ball park)
    (can-fly bird)
    (intends tim (happy tim))
    (intends zigzag (happy zigzag))
  )
  (:goal
    (and (happy tim)
    (happy zigzag))
  )
)