(define (problem end-of-the-world)
  (:domain end-of-the-world)
  (:objects
    protagonist - entity)
  (:init
    (alive protagonist)
    (intends protagonist (cause protagonist (destroy earth)))
  )
  (:goal
    (and (caused protagonist (destroyed earth))
    (dead protagonist))
  )
)