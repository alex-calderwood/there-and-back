(define (problem mortimer-mystery)
  (:domain mortimer-mystery)
  (:objects
    mortimer crawinski boy dog banana lightbulb - object
    apartment hallway stoop - location)
  (:init
    (at mortimer apartment)
    (alive mortimer)
    (intends mortimer (alive mortimer))
    (intends mortimer (has mortimer clothes))
    (at crawinski hallway)
    (alive crawinski)
    (intends crawinski (alive crawinski))
    (has crawinski lightbulb)
    (at boy stoop)
    (alive boy)
    (intends boy (alive boy))
    (at dog stoop)
    (intends dog (alive dog))
    (not (dog-bites)))
  (:goal
    (and (not (alive mortimer))
    (dog-bites)))
)