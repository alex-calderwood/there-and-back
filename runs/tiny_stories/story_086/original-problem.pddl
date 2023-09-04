(define (problem mixy-and-mommy)
  (:domain
    mixy-and-mommy)
  (:objects
    mixy mommy - character)
  (:init
    (intends mixy (happy mixy))
    (intends mommy (happy mixy))
    (intends mommy (cake-made)))
  (:goal
    (and (happy mixy)
    (cake-made))
  )
)