(define (problem confront-winter-king)
  (:domain
    winter-king)
  (:objects
    man boatman king - character
    boat lake farrowind palace - place
    fire ice - power)
  (:init
    (at man boat)
    (at boatman boat)
    (at king palace)
    (alive man)
    (alive boatman)
    (alive king)
    (has-power man fire)
    (has-power king ice)
    (brothers man king)
    (tyrant king)
    (intends man (alive man))
    (intends man (alive boatman))
    (intends man (not (tyrant king))))
  (:goal
    (and (at man palace)
    (not (tyrant king))))
)