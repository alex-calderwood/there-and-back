(define (problem vase-story-problem)
  (:domain vase-story)
  (:objects
    tim grandma - person
    vase - vase
    bug - bug
    living-room outside - place)
  (:init
    (at tim living-room)
    (at grandma living-room)
    (in bug vase living-room)
    (in vase living-room)
    (intends tim (not (scared tim))))
  (:goal
    (and (not (in bug vase living-room))
    (not (scared tim))))
)