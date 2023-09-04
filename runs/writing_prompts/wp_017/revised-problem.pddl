(define (problem mortimers-joke-life)
  (:domain
    mortimers-life)
  (:objects
    mortimer mr-crawinski young-man - character
    elephant dog - animal
    lightbulb - object
    clockwise counter-clockwise - direction)
  (:init
    (not (awake mortimer))
    (wearing-pajamas elephant)
    (on-floor mortimer)
    (holding mr-crawinski lightbulb)
    (walking mr-crawinski counter-clockwise)
    (intends mortimer (awake mortimer))
    (intends mortimer (dressed mortimer))
    (intends mortimer (life-is-a-joke mortimer))
    (owns young-man dog)
    (bites dog))
  (:goal
    (life-is-a-joke mortimer))
)