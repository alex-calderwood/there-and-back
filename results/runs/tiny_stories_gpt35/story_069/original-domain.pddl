(define (domain toy-box)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types character toy - object)
  (:predicates
    (has ?character - character ?toy - toy)
    (at ?toy - toy ?location - object)
    (alive ?character - character)
    (intends ?character - character ?predicate - predicate)
  )

  ;; A character travels from one location to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character picks up a toy.
  (:action pick-up
    :parameters
      (?character - character ?toy - toy ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location)
      (at ?toy ?location))
    :effect
      (and (not (at ?toy ?location))
      (at ?toy ?character)
      (has ?character ?toy))
    :agents
      (?character)
  )

  ;; A character puts down a toy.
  (:action put-down
    :parameters
      (?character - character ?toy - toy ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location)
      (at ?toy ?character)
      (has ?character ?toy))
    :effect
      (and (not (at ?toy ?character))
      (at ?toy ?location)
      (not (has ?character ?toy)))
    :agents
      (?character)
  )

  ;; A character runs away from a location.
  (:action run-away
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location))
    :effect
      (and (not (at ?character ?location))
      (not (intends ?character ?predicate))
      (intends ?character (alive ?character)))
    :agents
      (?character)
  )

  ;; A character witnesses toys fighting.
  (:action witness-fight
    :parameters
      (?character - character ?toy1 - toy ?toy2 - toy)
    :precondition
      (and (alive ?character)
      (at ?toy1 ?character)
      (at ?toy2 ?character)
      (not (= ?toy1 ?toy2)))
    :effect
      (and (intends ?character (run-away ?character))
      (not (intends ?character (has ?toy1)))
      (not (intends ?character (has ?toy2)))))
)