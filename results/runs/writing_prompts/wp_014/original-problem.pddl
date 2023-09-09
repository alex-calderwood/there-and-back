(define (problem relaxation-journey-problem)
  (:domain
    relaxation-journey)
  (:objects
    protagonist - character
    home coast gas-station east beach sky field - place
    bike - vehicle)
  (:init
    (alive protagonist)
    (at protagonist home)
    (has protagonist bike)
    (intends protagonist (alive protagonist))
    (intends protagonist (relaxed protagonist)))
  (:goal
    (and (at protagonist field)
    (relaxed protagonist)))
)