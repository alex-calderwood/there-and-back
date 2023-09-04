(define (domain big-red-ball)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object toy - item)
  (:constants ball - toy)
  (:predicates
    (has ?character - character ?item - item)
    (friends ?character1 - character ?character2 - character)
    (played-together ?character1 - character ?character2 - character)
    (happy ?character - character)
  )

  ;; A character gives a toy to another character.
  (:action give-toy
    :parameters
      (?giver - character ?toy - toy ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (has ?giver ?toy))
    :effect
      (and (not (has ?giver ?toy))
      (has ?receiver ?toy))
    :agents
      (?giver ?receiver)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Two characters play together with a toy.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character ?toy - toy)
    :precondition
      (and (not (= ?character1 ?character2))
      (has ?character1 ?toy)
      (friends ?character1 ?character2))
    :effect
      (and (played-together ?character1 ?character2)
      (happy ?character1)
      (happy ?character2))
    :agents
      (?character1 ?character2)
  )
)