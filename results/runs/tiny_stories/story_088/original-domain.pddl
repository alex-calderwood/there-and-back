(define (domain curious-boy-egg)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (found ?character - character ?item - item)
    (has ?character - character ?item - item)
    (pointing ?character - character ?object - object)
    (walking-around ?character - character ?object - object)
    (on-ground ?item - item)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (not (at ?character ?place)))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character points at an object.
  (:action point
    :parameters
      (?character - character ?object - object)
    :precondition
      (alive ?character)
    :effect
      (pointing ?character ?object)
    :agents
      (?character)
  )

  ;; A character walks around an object.
  (:action walk-around
    :parameters
      (?character - character ?object - object)
    :precondition
      (alive ?character)
    :effect
      (walking-around ?character ?object)
    :agents
      (?character)
  )

  ;; A character picks up an item.
  (:action pick-up
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (on-ground ?item))
    :effect
      (and (not (on-ground ?item))
      (has ?character ?item))
    :agents
      (?character)
  )

  ;; A character shows an item to another character.
  (:action show
    :parameters
      (?shower - character ?item - item ?receiver - character)
    :precondition
      (and (alive ?shower)
      (has ?shower ?item)
      (alive ?receiver))
    :effect
      (found ?receiver ?item)
    :agents
      (?shower ?receiver)
  )
)