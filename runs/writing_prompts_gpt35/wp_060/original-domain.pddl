(define (domain mr-anglewood)
  (:requirements :strips :typing :equality :quantified-preconditions)
  (:types person - object letter - item)
  (:predicates
    (clean ?item - item)
    (alive ?person - person)
    (has ?person - person ?item - item)
    (at ?person - person ?location - object)
    (locked ?object - object)
  )

  ;; A person cleans an item.
  (:action clean-item
    :parameters
      (?person - person ?item - item)
    :precondition
      (and (alive ?person)
      (at ?person ?item)
      (not (clean ?item)))
    :effect
      (clean ?item)
    :agents
      (?person)
  )

  ;; A person moves to a location.
  (:action move
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (alive ?person)
      (at ?person ?from)
      (not (locked ?to)))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
    :agents
      (?person)
  )

  ;; A person unlocks an object.
  (:action unlock
    :parameters
      (?person - person ?object - object)
    :precondition
      (and (alive ?person)
      (at ?person ?object)
      (locked ?object))
    :effect
      (not (locked ?object))
    :agents
      (?person)
  )

  ;; A person gives an item to another person.
  (:action give
    :parameters
      (?giver - person ?item - item ?receiver - person ?location - object)
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
)