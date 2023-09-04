(define (problem afterlife-return)
  (:domain
    afterlife-experience)
  (:objects
    protagonist - character
    condo-ground condo-roof hospital - place)
  (:init
    (alive protagonist)
    (at protagonist condo-roof)
    (intends protagonist (alive protagonist))
    (intends protagonist (understands-life protagonist)))
  (:goal
    (and (not (alive protagonist))
    (experienced-afterlife protagonist)
    (understands-life protagonist)))
)