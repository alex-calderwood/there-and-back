(define (problem free-the-world)
  (:domain immortal-prisoner)
  (:objects
    protagonist - character
    prison - expression
    convent - expression)
  (:init
    (alive protagonist)
    (has protagonist serum)
    (intends protagonist (believes protagonist (not (believes protagonist convent)))))
  (:goal
    (and (believes protagonist (not (believes protagonist convent)))
    (not (believes protagonist (believes protagonist prison)))))
)