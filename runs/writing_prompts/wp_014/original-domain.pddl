(define (domain relaxation-journey)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object vehicle - item)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (alive ?character - character)
    (riding ?character - character ?vehicle - vehicle)
    (relaxed ?character - character)
    (flying ?character - character)
    (in-vehicle ?character - character ?vehicle - vehicle)
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

  ;; A character starts riding a vehicle.
  (:action start-riding
    :parameters
      (?character - character ?vehicle - vehicle)
    :precondition
      (and (alive ?character)
      (has ?character ?vehicle)
      (not (riding ?character ?vehicle)))
    :effect
      (riding ?character ?vehicle)
    :agents  (?character)
  )

  ;; A character stops riding a vehicle.
  (:action stop-riding
    :parameters
      (?character - character ?vehicle - vehicle)
    :precondition
      (and (alive ?character)
      (riding ?character ?vehicle))
    :effect
      (not (riding ?character ?vehicle))
    :agents  (?character)
  )

  ;; A character starts flying.
  (:action start-flying
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (flying ?character)))
    :effect
      (flying ?character)
    :agents  (?character)
  )

  ;; A character stops flying.
  (:action stop-flying
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (flying ?character))
    :effect
      (not (flying ?character))
    :agents  (?character)
  )

  ;; A character tries to relax.
  (:action try-relax
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (relaxed ?character)))
    :effect
      (relaxed ?character)
    :agents  (?character)
  )

  ;; A character stops being relaxed.
  (:action stop-relax
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (relaxed ?character))
    :effect
      (not (relaxed ?character))
    :agents  (?character)
  )
)