(define (domain shelby-frost)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character creature - object)
  (:predicates
    (at ?character - character ?location - object)
    (alive ?character - character)
    (unwell ?character - character)
    (knows-name ?character1 - character ?character2 - character)
    (transformed ?character - character)
    (frozen ?character - character)
    (creature-attack ?creature - creature)
    (owe ?character1 - character ?character2 - character)
  )

  ;; A character goes to a location.
  (:action go-to
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (alive ?character)
      (not (at ?character ?location)))
    :effect
      (at ?character ?location)
    :agents
      (?character)
  )

  ;; A character reveals their name to another character.
  (:action reveal-name
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (knows-name ?character2 ?character1)))
    :effect
      (knows-name ?character2 ?character1)
    :agents
      (?character1)
  )

  ;; A character transforms.
  (:action transform
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (transformed ?character)))
    :effect
      (transformed ?character)
    :agents
      (?character)
  )

  ;; A character freezes another character.
  (:action freeze
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (frozen ?character2)))
    :effect
      (frozen ?character2)
    :agents
      (?character1)
  )

  ;; A character saves another character from a creature attack.
  (:action save
    :parameters
      (?savior - character ?character - character ?creature - creature)
    :precondition
      (and (alive ?savior)
      (alive ?character)
      (creature-attack ?creature)
      (frozen ?character))
    :effect
      (and (not (frozen ?character))
      (owe ?character ?savior))
    :agents
      (?savior)
  )
)