(define (problem max-and-ben)
  (:domain
    max-and-ben)
  (:objects
    max ben - dog
    ball - ball
    forest - location)
  (:init
    (at max forest)
    (has max ball)
    (lost ball)
    (at ben forest)
    (lost ben)
    (frustrated max)
    (frustrated ben)
    (intends max (not (frustrated max))))
  (:goal
    (and (friends max ben)
    (not (frustrated max))
    (not (frustrated ben))
    (not (lost ball))
    (at max forest)
    (at ben forest))
  )
)