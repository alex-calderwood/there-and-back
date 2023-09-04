(define (problem destroy-evidence)
  (:domain
    time-traveler)
  (:objects
    protagonist - character
    dig-site sorting-site - place
    journal - item)
  (:init
    (alive protagonist)
    (at protagonist dig-site)
    (has protagonist journal)
    (intends protagonist (alive protagonist))
    (intends protagonist (destroyed journal))
    (buried journal dig-site))
  (:goal
    (and (destroyed journal)
    (not (buried journal dig-site))))
)