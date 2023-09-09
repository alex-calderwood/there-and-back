(define (domain spirit-eviction)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person - object)
  (:predicates
    (has-spirit ?person - person)
    (alive ?person - person)
  )

  ;; A person evicts a spirit from their body.
  (:action evict-spirit
    :parameters
      (?person - person)
    :precondition
      (and (has-spirit ?person)
      (alive ?person))
    :effect
      (and (not (has-spirit ?person))
      (not (alive ?person)))
  )
)