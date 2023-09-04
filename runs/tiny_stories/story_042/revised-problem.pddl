(define (problem carnival-day)
  (:domain
    carnival)
  (:objects
    lily mom - character)
  (:init
    (intends lily (at-carnival lily))
    (intends mom (at-carnival mom))
    (intends lily (played lily))
    (intends mom (played lily))
    (intends mom (comforted lily)))
  (:goal
    (and (played lily)
    (upset lily)
    (comforted lily))
  )
)