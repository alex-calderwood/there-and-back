(define (problem talk-down-serial-killer)
  (:domain
    serial-killer)
  (:objects
    protagonist serial-killer - character)
  (:init
    (alive protagonist)
    (intends protagonist (alive protagonist))
    (alive serial-killer)
    (has-gun serial-killer)
    (intends serial-killer (not (alive protagonist))))
  (:goal
    (and (alive protagonist)
    (not (alive serial-killer))))
)