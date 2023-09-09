(define (domain conquistadors-landing)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:constants cthulhu dagon rlyeh - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has-flag ?character - character ?object - object)
    (worships ?character - character ?object - object)
    (accepts ?character - character ?object - object)
    (intends ?character - character ?predicate - predicate)
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

  ;; A character plants a flag at a place.
  (:action plant-flag
    :parameters
      (?character - character ?object - object ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (worships ?character ?object))
    :effect
      (and (has-flag ?character ?object)
      (accepts ?character ?object))
    :agents  (?character)
  )

  ;; A character tries to convert another character to their religion.
  (:action convert
    :parameters
      (?converter - character ?convertible - character ?object - object ?place - place)
    :precondition
      (and (alive ?converter)
      (at ?converter ?place)
      (worships ?converter ?object)
      (alive ?convertible)
      (at ?convertible ?place)
      (not (worships ?convertible ?object))))
    :effect
      (and (worships ?convertible ?object)
      (accepts ?convertible ?object))
    :agents
      (?converter)
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

  ;; A character intends to worship an object.
  (:action intend-worship
    :parameters
      (?character - character ?object - object)
    :precondition
      (alive ?character)
    :effect
      (intends ?character (worships ?character ?object))
    :agents
      (?character)
  )

  ;; A character intends to convert another character.
  (:action intend-convert
    :parameters
      (?converter - character ?convertible - character ?object - object ?place - place)
    :precondition
      (alive ?converter)
    :effect
      (intends ?converter (convert ?converter ?convertible ?object ?place))
    :agents
      (?converter)
  )

  ;; A character intends to kill another character.
  (:action intend-kill
    :parameters
      (?killer - character ?victim - character ?place - place)
    :precondition
      (alive ?killer)
    :effect
      (intends ?killer (kill ?killer ?victim ?place))
    :agents
      (?killer)
  )
)