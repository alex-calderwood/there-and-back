(define (problem death-wish-problem)
  (:domain death-wish)
  (:objects
    thomas high-council clerk - character
    "The Rains of Castamere" - song)
  (:init
    (alive thomas)
    (intends thomas (alive thomas))
    (intends thomas (playing thomas "The Rains of Castamere"))
    (intends thomas (at-wedding thomas))
    (intends thomas (shot-with-arrows thomas))
    (alive high-council)
    (alive clerk)
    (at clerk thomas)
    (at high-council thomas)
    (intends high-council (dead thomas))
    (intends high-council (not (shot-with-arrows thomas)))
    (intends high-council (not (playing thomas "The Rains of Castamere"))))
  (:goal
    (and (not (alive thomas))
    (shot-with-arrows thomas))
  )
)