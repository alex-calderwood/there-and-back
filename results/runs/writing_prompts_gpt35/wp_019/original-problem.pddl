(define (problem archaeological-dig-problem)
  (:domain archaeological-dig)
  (:objects
    protagonist - character
    crew - character
    journal-site - place
    sorting-site - place
    explosives - item)
  (:init
    (alive protagonist)
    (at protagonist journal-site)
    (has protagonist journal)
    (intends protagonist (knows protagonist (sick protagonist)))
    (alive crew)
    (at crew journal-site)
    (intends crew (knows crew (move-items journal journal-site sorting-site)))
    (knows protagonist (button journal-site))
    (knows protagonist (flame journal))
    (knows protagonist (time-passed 3))
    (intends protagonist (knows protagonist (explosion journal-site)))
    (intends protagonist (knows protagonist (glee protagonist))))
  (:goal
    (and (not (has protagonist journal))
    (knows protagonist (glee protagonist))
    (knows protagonist (explosion journal-site))
    (knows protagonist (flame journal))
    (not (at crew journal-site))
    (at crew sorting-site)
    (not (alive crew))))
)