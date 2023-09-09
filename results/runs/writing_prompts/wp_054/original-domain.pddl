(define (domain irish-rebellion)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object weapon - item)
  (:constants crucifix - item)
  (:predicates
    (alive ?character - character)
    (armed ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (hidden ?item - item ?place - place)
    (informant ?character - character)
    (target ?character - character)
  )

  ;; A character retrieves a hidden item.
  (:action retrieve
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (hidden ?item ?place))
    :effect
      (and (not (hidden ?item ?place))
      (has ?character ?item))
    :agents  (?character)
  )

  ;; A character hides an item.
  (:action hide
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (hidden ?item ?place))
    :agents  (?character)
  )

  ;; One character kills another.
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

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
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