(define (problem lily-and-tim-problem)
  (:domain lily-and-tim)
  (:objects
    lily tim - character
    ball - ball)
  (:init
    (has lily ball)
    (played lily)
    (intends lily (friends lily tim))
    (intends tim (friends tim lily)))
  (:goal
    (and (friends lily tim)
    (friends tim lily)))
)