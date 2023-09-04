(define (problem immortal-child-story)
  (:domain
    immortal-child)
  (:objects
    protagonist antagonist new-man - character)
  (:init
    (alive protagonist)
    (alive antagonist)
    (alive new-man)
    (immortal antagonist)
    (thirsty antagonist)
    (greedy antagonist)
    (intends protagonist (free protagonist))
    (intends antagonist (replaced protagonist))
    (intends new-man (pleasing antagonist))
    (intends protagonist (replaced protagonist))
    (intends protagonist (pleasing new-man))
  )
  (:goal
    (and (replaced protagonist)
    (free protagonist)
    (pleasing new-man))
  )
)