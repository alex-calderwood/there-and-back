(define (domain tim-and-the-bell)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (wants ?character - character ?item - item)
    (needs ?item - item ?character - character)
    (happy ?character - character)
    (proud ?character - character)
    (working ?item - item)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (not (at ?character ?place))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character buys an item.
  (:action buy
    :parameters
      (?character - character ?item - item)
    :precondition
      (not (has ?character ?item))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character gives an item to another character.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (has ?giver ?item)
      (needs ?item ?receiver))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item)
      (happy ?receiver)
      (proud ?giver))
    :agents
      (?giver ?receiver)
  )

  ;; A character receives a surprise item.
  (:action surprise
    :parameters
      (?giver - character ?item - item ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (has ?giver ?item)
      (wants ?receiver ?item))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item)
      (happy ?receiver)
      (proud ?giver))
    :agents
      (?giver ?receiver)
  )

  ;; A character fixes an item.
  (:action fix
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (not (working ?item))
      (has ?character ?item))
    :effect
      (working ?item)
    :agents
      (?character)
  )
)