(define (domain christmas-conspiracy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object weapon - item)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?item - item)
    (armed ?character - character)
    (knows-secret ?character - character)
    (kissed ?character1 - character ?character2 - character)
    (published ?item - item)
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

  ;; A character gives an item to another.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?place - place)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (at ?giver ?place)
      (has ?giver ?item)
      (alive ?receiver)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; A character kisses another.
  (:action kiss
    :parameters
      (?character1 - character ?character2 - character ?place - place)
    :precondition
      (and (not (= ?character1 ?character2))
      (alive ?character1)
      (at ?character1 ?place)
      (alive ?character2)
      (at ?character2 ?place))
    :effect
      (kissed ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character publishes an item.
  (:action publish
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (published ?item)
    :agents
      (?character)
  )

  ;; A character kills another.
  (:action kill
    :parameters
      (?killer - character ?weapon - weapon ?victim - character ?place - place)
    :precondition
      (and (alive ?killer)
      (at ?killer ?place)
      (has ?killer ?weapon)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; When a character has a weapon, they are armed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (armed ?character))
      (exists (?w - weapon)
      (has ?character ?w)))
    :implies
      (armed ?character)
  )

  ;; When a character does not have a weapon, they are unarmed.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (armed ?character)
      (forall (?w - weapon)
      (not (has ?character ?w))))
    :implies
      (not (armed ?character))
  )
)