(define (problem tom-and-max-problem)
  (:domain tom-and-max)
  (:objects
    tom max - character
    ball - toy
    park - object)
  (:init
    (at tom park)
    (at max park)
    (intends tom (sharing-toys))
    (intends max (sharing-toys))
    (intends tom (playing tom))
    (intends max (playing max))
    (intends tom (has tom ball))
    (not (has max ball)))
  (:goal
    (and (sharing-toys)
    (playing tom)
    (playing max)
    (has tom ball)
    (has max ball))
  )
)