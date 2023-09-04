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

<|Solution|>

(define (plan hide-and-seek-fun-solution)
  (:problem hide-and-seek-fun)
  (:steps (start-hiding spot park)
          (start-seeking lily park)
          (find lily spot park)))