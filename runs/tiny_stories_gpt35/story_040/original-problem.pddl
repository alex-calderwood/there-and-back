(define (problem mountain-adventure)
  (:domain mountain-adventure)
  (:objects
    tim bird toy - object
    mountain home - place)
  (:init
    (at tim home)
    (at bird home)
    (at toy mountain)
    (lost toy)
    (scared tim)
    (intends tim (not (lost toy)))
    (intends tim (not (scared tim))))
  (:goal
    (and (at tim home)
    (not (lost toy))
    (happy tim)
    (friend tim bird))
  )
)