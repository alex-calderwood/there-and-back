(define (domain dr-vertigo)
  (:requirements :adl :expression-variables :intentionality)
  (:types character place - object minibot - expression)
  (:constants secretary-general - character)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?minibot - minibot)
    (captured ?character - character)
    (damaged ?place - place)
    (barricaded ?place - place)
    (intends ?character - character ?expression - expression)
  )

  ;; A character moves from one place to another.
  (:action move
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

  ;; A character deploys a minibot.
  (:action deploy
    :parameters
      (?character - character ?minibot - minibot ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?minibot))
    :effect
      (and (not (has ?character ?minibot))
      (intends ?minibot (damaged ?place)))
    :agents  (?character)
  )

  ;; A character captures another character.
  (:action capture
    :parameters
      (?capturer - character ?victim - character ?place - place)
    :precondition
      (and (alive ?capturer)
      (at ?capturer ?place)
      (alive ?victim)
      (at ?victim ?place))
    :effect
      (and (not (alive ?victim))
      (captured ?victim))
    :agents
      (?capturer)
  )

  ;; A character damages a place.
  (:action damage
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (damaged ?place)
    :agents  (?character)
  )

  ;; A character barricades a place.
  (:action barricade
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (barricaded ?place)
    :agents  (?character)
  )

  ;; A character captures the Secretary General.
  (:action capture-secretary-general
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (intends ?character (captured secretary-general)))
    :effect
      (captured secretary-general)
    :agents  (?character)
  )

  ;; A character kills another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character ?place - place)
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

  ;; A character takes an expression variable as an argument.
  (:action take-expression
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (and (alive ?character)
      ?expression)
    :effect
      (intends ?character ?expression)
    :agents  (?character)
  )

  ;; A character delegates a goal to another character.
  (:action delegate
    :parameters
      (?delegator - character ?delegatee - character ?expression - expression)
    :precondition
      (and (alive ?delegator)
      (alive ?delegatee)
      ?expression)
    :effect
      (intends ?delegatee ?expression)
    :agents
      (?delegator))
)