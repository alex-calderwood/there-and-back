(define (problem afterlife-return)
  (:domain
    afterlife-experience)
  (:objects
    protagonist - character
    condo-ground condo-roof hospital - place)
  (:init
    (alive protagonist)
    (at protagonist condo-roof)
    (intends protagonist (not (alive protagonist)))
    (intends protagonist (experienced-afterlife protagonist))
    (intends protagonist (resurrected protagonist))
    (intends protagonist (understands-life protagonist)))
  (:goal
    (and (not (alive protagonist))
    (experienced-afterlife protagonist)
    (resurrected protagonist)
    (understands-life protagonist)))
)