(define (problem dragon-guard-problem)
  (:domain
    dragon-guard)
  (:objects
    dragon gang thieves - character
    cave - place)
  (:init
    (awake dragon)
    (at dragon cave)
    (has-hoard dragon)
    (intends dragon (asleep dragon))
    (awake gang)
    (at gang cave)
    (intends gang (robbed gang))
    (awake thieves)
    (at thieves cave)
    (intends thieves (attacked dragon)))
  (:goal
    (and (asleep dragon)
    (robbed gang)
    (soundproof-door cave)
    (has-hoard dragon)))
)