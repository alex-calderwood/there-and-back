(define (problem sun-helps-tree)
  (:domain
    sun-and-tree)
  (:objects
    big-sun - sun
    seed tree - plant
    animals birds - animal)
  (:init
    (gives-heat big-sun)
    (intends big-sun (awake animals))
    (intends big-sun (happy animals))
    (intends big-sun (growing seed))
    (intends big-sun (strong tree))
    (intends big-sun (provides-shade tree))
    (intends big-sun (provides-home tree))
    (generous big-sun)
  )
  (:goal
    (and (awake animals)
    (happy animals)
    (growing seed)
    (strong tree)
    (provides-shade tree)
    (provides-home tree))
  )
)