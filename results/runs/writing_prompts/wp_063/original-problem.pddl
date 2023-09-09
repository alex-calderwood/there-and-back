(define (problem death-calculator-problem)
  (:domain
    death-calculator)
  (:objects
    protagonist pat stephen - character
    room1 room2 - place
    door - object
    officer - character)
  (:init
    (at protagonist room1)
    (at pat room1)
    (at stephen room1)
    (alive protagonist)
    (alive pat)
    (alive stephen)
    (intends protagonist (alive protagonist))
    (intends pat (alive pat))
    (intends stephen (alive stephen))
    (intends protagonist (death-averted protagonist))
    (intends pat (death-averted pat))
    (intends stephen (death-averted stephen))
    (at officer room2))
  (:goal
    (and (death-averted protagonist)
    (death-averted pat)
    (death-averted stephen)))
)