(define (domain winter-palace)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object place - object)
  (:constants
    king - character
    winter - expression)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (knows ?character - character ?expression - expression)
    (intends ?character - character ?expression - expression)
    (has ?character - character ?expression - expression)
    (frozen ?character - character)
    (conjured ?expression - expression)
    (subjugated ?place - place)
    (tyrant ?character - character)
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

  ;; A character conjures an expression.
  (:action conjure
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (and (alive ?character)
      (intends ?character ?expression))
    :effect
      (and (conjured ?expression)
      (has ?character ?expression))
    :agents  (?character)
  )

  ;; A character freezes another character.
  (:action freeze
    :parameters
      (?freezer - character ?frozen - character)
    :precondition
      (and (alive ?freezer)
      (alive ?frozen)
      (conjured winter)
      (at ?freezer ?place)
      (at ?frozen ?place))
    :effect
      (and (frozen ?frozen))
    :agents
      (?freezer)
  )

  ;; A character subjugates a place.
  (:action subjugate
    :parameters
      (?tyrant - character ?place - place)
    :precondition
      (and (alive ?tyrant)
      (at ?tyrant ?place))
    :effect
      (subjugated ?place)
    :agents
      (?tyrant)
  )

  ;; One character gives an expression to another.
  (:action give
    :parameters
      (?giver - character ?expression - expression ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (at ?giver ?place)
      (has ?giver ?expression)
      (alive ?receiver)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?expression))
      (has ?receiver ?expression))
    :agents
      (?giver ?receiver)
  )

  ;; One character kills another.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (at ?killer ?place)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; A character confronts the king.
  (:action confront-king
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (subjugated ?place)
      (at king ?place)
      (alive king)
      (tyrant king))
    :effect
      (and (not (alive king))
      (intends ?character (has ?character winter)))
    :agents
      (?character)
  )
)