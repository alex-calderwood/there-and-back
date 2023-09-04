(define (domain vase-party)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character item - object)
  (:constants vase - item)
  (:predicates
    (happy ?character - character)
    (at ?item - item ?place - object)
    (has ?character - character ?item - item)
    (party ?place - object)
    (cake ?place - object)
  )

  ;; A character makes a cake.
  (:action make-cake
    :parameters
      (?character - character ?place - object)
    :precondition
      (happy ?character)
    :effect
      (cake ?place)
    :agents
      (?character)
  )

  ;; A character puts an item in a place.
  (:action put
    :parameters
      (?character - character ?item - item ?place - object)
    :precondition
      (and (happy ?character)
      (has ?character ?item))
    :effect
      (at ?item ?place)
    :agents
      (?character)
  )

  ;; A character starts a party.
  (:action start-party
    :parameters
      (?character - character ?place - object)
    :precondition
      (happy ?character)
    :effect
      (party ?place)
    :agents
      (?character)
  )

  ;; A character enjoys the party.
  (:action enjoy-party
    :parameters
      (?character - character ?place - object)
    :precondition
      (and (happy ?character)
      (party ?place))
    :effect
      (happy ?character)
    :agents
      (?character)
  )
)