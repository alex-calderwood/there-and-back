(define (problem kangaroo-revenge)
  (:domain
    kangaroo-revenge)
  (:objects
    protagonist karl henchman1 henchman2 - character)
  (:init
    (alive protagonist)
    (intends protagonist (alive protagonist))
    (alive karl)
    (intends karl (not (alive protagonist)))
    (has-knife karl)
    (alive henchman1)
    (has-kangaroo henchman1)
    (has-santa-hat henchman1)
    (alive henchman2))
  (:goal
    (and (not (alive protagonist))
    (prepared-kangaroo henchman1)))
)