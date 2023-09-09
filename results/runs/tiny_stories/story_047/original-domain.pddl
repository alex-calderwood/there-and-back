(define (domain sharing-forest)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character toy - object)
  (:predicates
    (has ?character - character ?toy - toy)
    (playing-together ?character1 - character ?character2 - character ?toy - toy)
    (happy ?character - character)
  )

  ;; A character shares a toy with another character.
  (:action share
    :parameters
      (?sharer - character ?toy - toy ?receiver - character)
    :precondition
      (and (not (= ?sharer ?receiver))
      (has ?sharer ?toy))
    :effect
      (and (not (has ?sharer ?toy))
      (has ?receiver ?toy))
    :agents
      (?sharer ?receiver)
  )

  ;; Two characters play together with a toy.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character ?toy - toy)
    :precondition
      (and (not (= ?character1 ?character2))
      (has ?character1 ?toy)
      (has ?character2 ?toy))
    :effect
      (and (playing-together ?character1 ?character2 ?toy)
      (happy ?character1)
      (happy ?character2))
    :agents
      (?character1 ?character2)
  )

  ;; A character finds a toy.
  (:action find
    :parameters
      (?character - character ?toy - toy)
    :effect
      (has ?character ?toy)
    :agents
      (?character)
  )
)