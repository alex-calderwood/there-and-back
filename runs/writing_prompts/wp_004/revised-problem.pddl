(define (problem earth-reentry)
  (:domain
    earth-reentry)
  (:objects
    squad-leader soldier1 soldier2 soldier3 - character
    earth - planet)
  (:init
    (intends squad-leader (on-planet squad-leader earth))
    (intends soldier1 (on-planet soldier1 earth))
    (intends soldier2 (on-planet soldier2 earth))
    (intends soldier3 (on-planet soldier3 earth)))
  (:goal
    (and (on-planet squad-leader earth)
    (on-planet soldier1 earth)
    (on-planet soldier2 earth)
    (on-planet soldier3 earth)))
)