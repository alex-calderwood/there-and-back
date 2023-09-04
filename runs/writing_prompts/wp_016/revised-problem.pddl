(define (problem post-apocalyptic-queen)
  (:domain
    post-apocalyptic-world)
  (:objects
    protagonist - character
    townspeople - character
    town - place
    supplies - item)
  (:init
    (alive protagonist)
    (at protagonist town)
    (has protagonist supplies)
    (knows-survival-skills protagonist)
    (intends protagonist (alive protagonist))
    (intends protagonist (not (computers-working)))
    (alive townspeople)
    (at townspeople town)
    (not (knows-survival-skills townspeople))
    (intends townspeople (alive townspeople))
    (intends townspeople (knows-survival-skills townspeople))
    (computers-working))
  (:goal
    (and (not (computers-working))
    (knows-survival-skills townspeople)
    (alive protagonist)))
)