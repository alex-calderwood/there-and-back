(define (domain zara-and-momo)
  (:requirements :strips :typing :equality)
  (:types character - object toy - object)
  (:predicates
    (has ?character - character ?toy - toy)
    (playing ?character - character ?toy - toy)
  )

  ;; A character takes a toy.
  (:action take-toy
    :parameters
      (?character - character ?toy - toy)
    :precondition
      (and (not (has ?character ?toy)))
    :effect
      (has ?character ?toy)
    :agents
      (?character)
  )

  ;; A character shares a toy with another character.
  (:action share-toy
    :parameters
      (?giver - character ?receiver - character ?toy - toy)
    :precondition
      (and (has ?giver ?toy)
      (not (playing ?giver ?toy))
      (not (playing ?receiver ?toy)))
    :effect
      (and (playing ?giver ?toy)
      (playing ?receiver ?toy))
    :agents
      (?giver ?receiver)
  )
)