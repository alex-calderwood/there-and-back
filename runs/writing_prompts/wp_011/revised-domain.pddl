(define (domain space-fart-technology)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?object - object)
    (in-stasis ?character - character)
    (ancient-technology ?object - object)
    (propellant-device ?object - object)
    (shielded ?object - object)
    (requested-tow ?character - character ?place - place)
  )

  ;; A character discovers an ancient technology.
  (:action discover-technology
    :parameters
      (?character - character ?object - object ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (and (has ?character ?object)
      (ancient-technology ?object))
    :agents  (?character)
  )

  ;; A character detects lifeforms in stasis.
  (:action detect-stasis
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (alive ?character)
      (has ?character ?object)
      (ancient-technology ?object))
    :effect
      (in-stasis ?object)
    :agents  (?character)
  )

  ;; A character requests a tow-in.
  (:action request-tow
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (requested-tow ?character ?place)
    :agents  (?character)
  )

  ;; A character transports an object to a base.
  (:action transport-object
    :parameters
      (?character - character ?object - object ?from - place ?to - place)
    :precondition
      (and (alive ?character)
      (at ?character ?from)
      (has ?character ?object)
      (requested-tow ?character ?to))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to)
      (not (has ?character ?object)))
    :agents  (?character)
  )
)