(define (problem killer-problem)
  (:domain killer)
  (:objects
    james paul - character
    house - object
    rifle handsaw - item)
  (:init
    (alive james)
    (at james house)
    (intends james (alive james))
    (intends james (knows james (not (trapped house)))))
  (:goal
    (and (not (alive james))