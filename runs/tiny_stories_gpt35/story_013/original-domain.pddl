(define (domain sue-and-cat)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types person cat toy - object)
  (:predicates
    (at ?person - person ?location - object)
    (has ?person - person ?toy - toy)
    (lost ?cat - cat ?toy - toy)
    (happy ?cat - cat)
    (found ?toy - toy)
    (play ?person - person ?toy - toy)
    (intends ?person - person ?predicate - predicate)
    (expression-variable ?var - object)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
    :agents
      (?person)
  )

  ;; A person finds a toy.
  (:action find-toy
    :parameters
      (?person - person ?toy - toy ?location - object)
    :precondition
      (and (at ?person ?location)
      (found ?toy)
      (intends ?person (found ?toy)))
    :effect
      (and (not (found ?toy))
      (has ?person ?toy))
    :agents
      (?person)
  )

  ;; A person gives a toy to a cat.
  (:action give-toy
    :parameters
      (?person - person ?toy - toy ?cat - cat ?location - object)
    :precondition
      (and (at ?person ?location)
      (has ?person ?toy)
      (at ?cat ?location)
      (lost ?cat ?toy)
      (intends ?person (has ?cat ?toy)))
    :effect
      (and (not (has ?person ?toy))
      (not (lost ?cat ?toy))
      (happy ?cat)
      (play ?person ?toy))
    :agents
      (?person)
  )

  ;; A cat expresses sadness.
  (:action express-sadness
    :parameters
      (?cat - cat ?location - object)
    :precondition
      (at ?cat ?location)
    :effect
      (intends ?cat (lost ?var))
    :expression-variables
      (?var - toy)
    :agents
      (?cat)
  )

  ;; A cat expresses gratitude.
  (:action express-gratitude
    :parameters
      (?cat - cat ?location - object)
    :precondition
      (and (at ?cat ?location)
      (happy ?cat))
    :effect
      (intends ?cat (found ?var))
    :expression-variables
      (?var - toy)
    :agents
      (?cat)
  )
)