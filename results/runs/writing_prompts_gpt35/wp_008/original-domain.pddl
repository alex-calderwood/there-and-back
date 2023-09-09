(define (domain revive-soul)
  (:requirements :strips :typing :equality :quantified-preconditions)
  (:types person - object)
  (:predicates
    (dead ?person - person)
    (revived ?person - person)
    (best-friend ?person - person)
  )

  ;; A person tries to revive a dead person.
  (:action revive
    :parameters
      (?reviver - person ?dead-person - person)
    :precondition
      (and (dead ?dead-person)
      (best-friend ?reviver ?dead-person))
    :effect
      (and (revived ?dead-person)
      (not (dead ?dead-person)))
    :agents
      (?reviver)
  )
)