(define (problem toy-factory-story)
  (:domain
    toy-factory)
  (:objects
    tom - character
    factory - object)
  (:init
    (nervous tom)
    (intends tom (worker tom))
    (intends tom (clean factory))
    (intends tom (makes-toys tom))
    (intends tom (happy tom))
    (intends tom (forall (?other - character) (friends-with tom ?other)))
  )
  (:goal
    (and (worker tom)
    (clean factory)
    (makes-toys tom)
    (happy tom)
    (forall (?other - character) (friends-with tom ?other)))
  )
)