(define (problem lily-and-spot)
  (:domain hide-and-seek)
  (:objects
    lily spot - dog
    ball doll - toy
    tree bush - object
    park - object)
  (:init
    (at ball park)
    (at doll park)
    (at lily park)
    (at spot park)
    (intends lily (found ball))
    (intends lily (found doll))
    (intends spot (hidden ball))
    (intends spot (hidden doll))
    (intends spot (found lily))
    (intends lily (found spot))
    (intends lily (at ball park))
    (intends lily (at doll park))
    (intends spot (at bush park))
    (intends lily (at tree park)))
  (:goal
    (and (found ball)
    (found doll)
    (found spot)
    (found lily)))
)