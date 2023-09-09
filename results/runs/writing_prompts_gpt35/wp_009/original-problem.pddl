(define (problem spirit-eviction-problem)
  (:domain spirit-eviction)
  (:objects
    protagonist - person)
  (:init
    (has-spirit protagonist)
    (alive protagonist))
  (:goal
    (not (has-spirit protagonist)))
)