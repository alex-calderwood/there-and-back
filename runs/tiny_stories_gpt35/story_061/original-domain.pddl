(define (domain magic-drum)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables :intentionality)
  (:types object - object)
  (:predicates
    (has ?character - object ?object - object)
    (at ?character - object ?place - object)
    (shrunken ?object - object)
    (smooth ?object - object)
    (played ?character - object ?object - object)
    (intends ?character - object ?predicate - predicate)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - object ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character takes an object.
  (:action take
    :parameters
      (?character - object ?object - object ?place - object)
    :precondition
      (and (at ?character ?place)
      (at ?object ?place))
    :effect
      (and (not (at ?object ?place))
      (at ?object ?character)
      (not (at ?character ?place))
      (at ?character ?object)
      (has ?character ?object))
    :agents
      (?character)
  )

  ;; A character drops an object.
  (:action drop
    :parameters
      (?character - object ?object - object ?place - object)
    :precondition
      (and (at ?character ?object)
      (at ?object ?character))
    :effect
      (and (not (at ?object ?character))
      (at ?object ?place)
      (not (at ?character ?object))
      (at ?character ?place)
      (not (has ?character ?object)))
    :agents
      (?character)
  )

  ;; A character plays with an object.
  (:action play
    :parameters
      (?character - object ?object - object)
    :precondition
      (and (at ?character ?object)
      (at ?object ?character)
      (smooth ?object))
    :effect
      (and (played ?character ?object))
    :agents
      (?character)
  )

  ;; An object shrinks.
  (:action shrink
    :parameters
      (?object - object)
    :precondition
      (and (played ?character ?object)
      (not (shrunken ?object)))
    :effect
      (and (shrunken ?object))
    :agents
      (?character)
  )

  ;; A character intends to show an object to another character.
  (:action show
    :parameters
      (?shower - object ?showee - object ?object - object)
    :precondition
      (and (at ?shower ?object)
      (at ?object ?shower)
      (at ?showee ?place)
      (has ?shower ?object)
      (intends ?shower (has ?showee ?object)))
    :effect
      (and (not (intends ?shower (has ?showee ?object)))
      (intends ?showee (has ?shower ?object)))
    :agents
      (?shower ?showee)
  )

  ;; A character intends to find out what the note means.
  (:action investigate
    :parameters
      (?character - object ?note - object ?drum - object ?place - object)
    :precondition
      (and (at ?character ?place)
      (at ?note ?drum)
      (has ?drum ?note)
      (intends ?character (played ?character ?drum)))
    :effect
      (and (not (intends ?character (played ?character ?drum)))
      (intends ?character (shrunken ?object)))
    :agents
      (?character)
  )
)