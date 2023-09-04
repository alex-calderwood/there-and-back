(define (domain planet-arda)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (wearing ?character - character ?item - item)
    (has ?character - character ?item - item)
    (breathable ?place - place)
    (smoking ?character - character)
    (dancing ?character - character)
    (eating ?character - character)
    (shrunk ?character - character)
  )

  ;; A character travels to a place.
  (:action travel
    :parameters
      (?character - character ?to - place)
    :precondition
      (and (alive ?character)
      (not (at ?character ?to)))
    :effect
      (at ?character ?to)
    :agents
      (?character)
  )

  ;; A character starts smoking.
  (:action start-smoking
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (not (smoking ?character)))
    :effect
      (smoking ?character)
    :agents
      (?character)
  )

  ;; A character starts dancing.
  (:action start-dancing
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (dancing ?character)))
    :effect
      (dancing ?character)
    :agents
      (?character)
  )

  ;; A character starts eating.
  (:action start-eating
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (not (eating ?character)))
    :effect
      (eating ?character)
    :agents
      (?character)
  )

  ;; A character shrinks.
  (:action shrink
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (shrunk ?character)))
    :effect
      (shrunk ?character)
    :agents
      (?character)
  )

  ;; A character changes clothes.
  (:action change-clothes
    :parameters
      (?character - character ?old-item - item ?new-item - item)
    :precondition
      (and (alive ?character)
      (wearing ?character ?old-item)
      (has ?character ?new-item))
    :effect
      (and (not (wearing ?character ?old-item))
      (wearing ?character ?new-item))
    :agents
      (?character)
  )

  ;; When a character is at a breathable place, they can breathe.
  (:axiom
    :vars
      (?character - character ?place - place)
    :context
      (and (at ?character ?place)
      (breathable ?place))
    :implies
      (alive ?character)
  )
)