(define (problem dog-race-story)
  (:domain
    dog-race)
  (:objects
    sam ben - dog)
  (:init
    (friend sam ben)
    (intends sam (practices sam ben))
    (intends sam (wins ben))
    (intends sam (plays-with-toy-stack sam))
    (intends ben (wins ben))
    (intends ben (plays-with-toy-stack ben)))
  (:goal
    (and (wins ben)
    (plays-with-toy-stack sam)
    (plays-with-toy-stack ben)))
)