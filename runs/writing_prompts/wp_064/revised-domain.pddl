(define (domain mail-delivery)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (alive ?character - character)
    (delivered ?item - item)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character delivers an item to a destination.
  (:action deliver
    :parameters
      (?character - character ?item - item ?destination - place)
    :precondition
      (and (alive ?character)
      (at ?character ?destination)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (delivered ?item))
    :agents
      (?character)
  )

  ;; A character picks up an item.
  (:action pick-up
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )
)