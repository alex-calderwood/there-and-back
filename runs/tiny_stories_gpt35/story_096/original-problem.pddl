(define (problem lily-swing)
  (:domain lily-swing)
  (:objects
    lily tom swing - object)
  (:init
    (at lily swing)
    (at tom swing)
    (intends lily (happy lily))
    (intends tom (happy tom)))
  (:goal
    (and (happy lily)
    (happy tom)))
)