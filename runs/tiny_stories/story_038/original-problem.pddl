(define (problem hide-and-seek-fun)
  (:domain
    hide-and-seek)
  (:objects
    lily spot - character
    park tree bush - place)
  (:init
    (at lily park)
    (at spot park)
    (intends lily (found lily spot))
    (intends spot (hiding spot))
  )
  (:goal
    (found lily spot)
  )
)