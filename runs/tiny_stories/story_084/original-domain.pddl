(define (domain unusual-rocket)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object toy - item)
  (:constants rocket - toy)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (found ?character - character ?item - item)
    (played-with ?character - character ?item - item)
    (happy ?character - character)
  )

  ;; A character finds an item.
  (:action find
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (found ?character ?item)))
    :effect
      (and (found ?character ?item)
      (has ?character ?item)
      (happy ?character))
    :agents  (?character)
  )

  ;; A character shows an item to another character.
  (:action show
    :parameters
      (?shower - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?shower ?receiver))
      (at ?shower ?place)
      (has ?shower ?item)
      (at ?receiver ?place))
    :effect
      (happy ?receiver)
    :agents
      (?shower ?receiver)
  )

  ;; Characters play with an item at a specific place.
  (:action play
    :parameters
      (?character1 - character ?character2 - character ?item - item ?place - place)
    :precondition
      (and (not (= ?character1 ?character2))
      (at ?character1 ?place)
      (has ?character1 ?item)
      (at ?character2 ?place))
    :effect
      (played-with ?character1 ?item)
    :agents
      (?character1 ?character2)
  )

  ;; A character makes the rocket fly high.
  (:action fly-high
    :parameters
      (?character - character)
    :precondition
      (and (played-with ?character rocket))
    :effect
      (happy ?character)
    :agents  (?character)
  )
)