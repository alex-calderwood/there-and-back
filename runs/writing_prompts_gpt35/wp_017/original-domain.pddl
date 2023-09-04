(define (domain mortimer-mystery)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions)
  (:types person - object)
  (:predicates
    (at ?person - person ?location - object)
    (has ?person - person ?item - object)
    (alive ?person - person)
    (dog-bites)
  )

  ;; A person moves from one location to another.
  (:action move
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from)
      (alive ?person))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person picks up an item.
  (:action pick-up
    :parameters
      (?person - person ?item - object ?location - object)
    :precondition
      (and (at ?person ?location)
      (not (has ?person ?item))
      (alive ?person))
    :effect
      (and (not (at ?item ?location))
      (has ?person ?item))
  )

  ;; A person puts down an item.
  (:action put-down
    :parameters
      (?person - person ?item - object ?location - object)
    :precondition
      (and (at ?person ?location)
      (has ?person ?item)
      (alive ?person))
    :effect
      (and (at ?item ?location)
      (not (has ?person ?item)))
  )

  ;; A person is bitten by a dog.
  (:action dog-bite
    :parameters
      (?person - person ?dog - object ?location - object)
    :precondition
      (and (at ?person ?location)
      (at ?dog ?location)
      (not (dog-bites))
      (alive ?person))
    :effect
      (and (not (alive ?person))
      (dog-bites))
  )
)