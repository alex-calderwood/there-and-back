(define (problem find-tims-cap)
  (:domain find-cap)
  (:objects
    tim spot - object
    old-cap new-cap - object
    bedroom toy-box kitchen - object)
  (:init
    (has-cap tim)
    (at tim bedroom)
    (at old-cap toy-box)
    (at new-cap kitchen)
    (at spot bedroom)
    (intends tim (has-cap tim))
    (intends tim (not (has-new-cap tim)))
    (intends tim (not (has-cap spot))))
  (:goal
    (and (has-new-cap tim)
    (not (has-cap spot))))
)