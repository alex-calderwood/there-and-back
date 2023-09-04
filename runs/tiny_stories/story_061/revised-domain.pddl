(define (domain magic-drum)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character item - object)
  (:predicates
    (has ?character - character ?item - item)
    (shrinkable ?item - item)
    (shrunken ?item - item)
    (played ?character - character ?item - item)
  )

  ;; A character finds an item.
  (:action find
    :parameters
      (?character - character ?item - item)
    :precondition
      (alive ?character)
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character plays an item.
  (:action play
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (played ?character ?item)
    :agents
      (?character)
  )

  ;; A character shrinks an item.
  (:action shrink
    :parameters
      (?character - character ?item - item ?target - item)
    :precondition
      (and (alive ?character)
      (played ?character ?item)
      (shrinkable ?target)
      (not (shrunken ?target)))
    :effect
      (shrunken ?target)
    :agents
      (?character)
  )

  ;; A character shows an item to another character.
  (:action show
    :parameters
      (?shower - character ?item - item ?receiver - character)
    :precondition
      (and (not (= ?shower ?receiver))
      (alive ?shower)
      (has ?shower ?item)
      (alive ?receiver))
    :effect
      (played ?receiver ?item)
    :agents
      (?shower ?receiver)
  )
)