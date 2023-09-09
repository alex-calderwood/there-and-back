(define (problem magic-drum-adventure)
  (:domain
    magic-drum)
  (:objects
    amy tom - character
    drum toy-car - item)
  (:init
    (alive amy)
    (intends amy (has amy drum))
    (intends amy (played tom drum))
    (intends amy (shrunken toy-car))
    (alive tom)
    (intends tom (played tom drum))
    (intends tom (shrunken toy-car))
    (shrinkable toy-car)
    (has tom toy-car))
  (:goal
    (and (has amy drum)
    (played tom drum)
    (shrunken toy-car))
  )
)