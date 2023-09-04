(define (domain harry-feldman-trucker)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object vehicle - item)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (has-vehicle ?character - character ?vehicle - vehicle)
    (driving ?character - character ?vehicle - vehicle)
    (intergalactic ?vehicle - vehicle)
    (freedom ?place - place)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place ?vehicle - vehicle)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from)
      (has-vehicle ?character ?vehicle)
      (driving ?character ?vehicle))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character acquires a vehicle.
  (:action acquire-vehicle
    :parameters
      (?character - character ?vehicle - vehicle)
    :precondition
      (not (has-vehicle ?character ?vehicle))
    :effect
      (has-vehicle ?character ?vehicle)
    :agents
      (?character)
  )

  ;; A character starts driving a vehicle.
  (:action start-driving
    :parameters
      (?character - character ?vehicle - vehicle)
    :precondition
      (and (has-vehicle ?character ?vehicle)
      (not (driving ?character ?vehicle)))
    :effect
      (driving ?character ?vehicle)
    :agents
      (?character)
  )

  ;; A character stops driving a vehicle.
  (:action stop-driving
    :parameters
      (?character - character ?vehicle - vehicle)
    :precondition
      (driving ?character ?vehicle)
    :effect
      (not (driving ?character ?vehicle))
    :agents
      (?character)
  )

  ;; A character spreads freedom to a place.
  (:action spread-freedom
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (freedom ?place)))
    :effect
      (freedom ?place)
    :agents
      (?character)
  )
)