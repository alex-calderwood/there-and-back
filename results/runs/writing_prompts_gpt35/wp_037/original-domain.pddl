(define (domain finding-wilma)
  (:requirements :strips :negative-preconditions :typing :equality :quantified-preconditions :expression-variables :intentionality)
  (:types character - object)
  (:predicates
    (found ?character - character)
    (knows ?character - character ?fact - expression)
    (alive ?character - character)
    (missing ?character - character)
    (in-love ?character - character)
    (has ?character - character ?item - object)
    (at ?character - character ?place - object)
    (intends ?character - character ?fact - expression)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character finds another character.
  (:action find
    :parameters
      (?finder - character ?found - character)
    :precondition
      (and (alive ?finder)
      (missing ?found)
      (knows ?finder (found ?found))
      (at ?finder ?place))
    :effect
      (and (not (missing ?found))
      (found ?found))
    :agents
      (?finder)
  )

  ;; A character gives an item to another.
  (:action give
    :parameters
      (?giver - character ?item - object ?receiver - character)
    :precondition
      (and (alive ?giver)
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

  ;; A character expresses their love for another.
  (:action express-love
    :parameters
      (?lover - character ?beloved - character)
    :precondition
      (and (alive ?lover)
      (at ?lover ?place)
      (alive ?beloved)
      (at ?beloved ?place))
    :effect
      (in-love ?lover ?beloved)
    :agents
      (?lover)
  )

  ;; A character becomes missing.
  (:action go-missing
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (missing ?character)))
    :effect
      (missing ?character)
    :agents
      (?character)
  )

  ;; A character becomes found.
  (:action become-found
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (missing ?character))
    :effect
      (not (missing ?character))
    :agents
      (?character)
  )

  ;; A character intends to find another character.
  (:action intend-to-find
    :parameters
      (?character - character ?found - character)
    :precondition
      (and (alive ?character)
      (not (found ?found)))
    :effect
      (knows ?character (found ?found))
    :agents
      (?character)
  )

  ;; A character intends to express their love for another.
  (:action intend-to-express-love
    :parameters
      (?lover - character ?beloved - character)
    :precondition
      (and (alive ?lover)
      (alive ?beloved)
      (not (in-love ?lover ?beloved)))
    :effect
      (intends ?lover (in-love ?lover ?beloved))
    :agents
      (?lover)
  )

  ;; A character intends to give an item to another.
  (:action intend-to-give
    :parameters
      (?giver - character ?item - object ?receiver - character)
    :precondition
      (and (alive ?giver)
      (alive ?receiver)
      (has ?giver ?item)
      (not (has ?receiver ?item)))
    :effect
      (intends ?giver (has ?receiver ?item))
    :agents
      (?giver)
  )

  ;; A character intends to travel from one place to another.
  (:action intend-to-travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (alive ?character)
      (not (= ?from ?to)))
    :effect
      (intends ?character (at ?character ?to))
    :agents
      (?character)
  )
)