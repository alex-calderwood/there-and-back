(define (problem magic-drum-problem)
  (:domain magic-drum)
  (:objects
    amy tom drum note toy-car - object
    amy-room tom-house - place)
  (:init
    (at amy amy-room)
    (at tom tom-house)
    (at drum amy-room)
    (smooth drum)
    (has amy drum)
    (intends amy (has tom drum))
    (intends amy (played amy drum))
    (intends tom (played tom drum))
    (at note drum)
    (has drum note)
    (at toy-car tom-house)
    (intends amy (shrunken toy-car)))
  (:goal
    (and (at toy-car amy-room)
    (shrunken toy-car)
    (intends amy (shrunken toy-car))))
)