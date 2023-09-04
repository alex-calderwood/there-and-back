(define (problem sonnet-21-rebirth)
  (:domain
    sonnet-21)
  (:objects
    protagonist death - character)
  (:init
    (dead protagonist)
    (intends protagonist (alive protagonist))
    (intends death (or (completed protagonist blood)
    (completed protagonist sweat)
    (completed protagonist tears))))
  (:goal
    (alive protagonist))
)