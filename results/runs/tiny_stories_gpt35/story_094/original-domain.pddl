(define (domain tom-and-jane)
  (:requirements :strips :typing :equality :negative-preconditions :intentionality)
  (:types character - object toy - item)
  (:predicates
    (has ?character - character ?item - item)
    (at ?character - character ?location - object)
    (alive ?character - character)
    (intends ?character - character ?predicate - predicate)
  )

  ;; A character takes an item from a location.
  (:action take
    :parameters
      (?character - character ?item - item ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location)
      (at ?item ?location))
    :effect
      (and (not (at ?item ?location))
      (has ?character ?item))
    :agents
      (?character)
  )

  ;; A character gives an item to another character.
  (:action give
    :parameters
      (?giver - character ?item - item ?receiver - character ?location - object)
    :precondition
      (and (alive ?giver)
      (at ?giver ?location)
      (has ?giver ?item)
      (alive ?receiver)
      (at ?receiver ?location))
    :effect
      (and (not (has ?giver ?item))
      (has ?receiver ?item))
    :agents
      (?giver ?receiver)
  )

  ;; A character moves to a location.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
  )

  ;; The dog takes the toy from Tom and Jane.
  (:action take-toy
    :parameters
      (?dog - character ?toy - toy ?location - object)
    :precondition
      (and (alive ?dog)
      (at ?dog ?location)
      (has ?toy ?location))
    :effect
      (and (not (has ?toy ?location))
      (has ?dog ?toy))
    :agents
      (?dog)
  )
)