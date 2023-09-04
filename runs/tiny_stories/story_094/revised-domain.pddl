(define (domain cat-and-dog)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object toy - item)
  (:predicates
    (has ?character - character ?item - item)
    (happy ?character - character)
    (sad ?character - character)
    (at ?character - character ?place - place)
  )

  ;; A character receives a gift.
  (:action receive-gift
    :parameters
      (?receiver - character ?giver - character ?item - item)
    :precondition
      (and (not (= ?receiver ?giver))
      (happy ?giver)
      (not (has ?receiver ?item))
      (has ?giver ?item))
    :effect
      (and (has ?receiver ?item)
      (happy ?receiver))
    :agents
      (?receiver ?giver)
  )

  ;; A character plays with a toy.
  (:action play
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (has ?character ?item)
      (not (sad ?character)))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character takes a toy from another character.
  (:action take-toy
    :parameters
      (?taker - character ?victim - character ?item - item)
    :precondition
      (and (not (= ?taker ?victim))
      (has ?victim ?item)
      (not (has ?taker ?item)))
    :effect
      (and (not (has ?victim ?item))
      (has ?taker ?item)
      (sad ?victim))
    :agents
      (?taker)
  )

  ;; A character loses a toy.
  (:action lose-toy
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (has ?character ?item)
      (happy ?character))
    :effect
      (and (not (has ?character ?item))
      (sad ?character))
    :agents
      (?character)
  )
)