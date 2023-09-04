(define (domain tom-and-max)
  (:requirements :strips :typing :equality :negative-preconditions :intentionality)
  (:types character - object toy - item)
  (:predicates
    (at ?character - character ?location - object)
    (has ?character - character ?toy - toy)
    (playing ?character - character)
    (sharing-toys)
  )

  ;; A character travels from one location to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character picks up a toy.
  (:action pick-up-toy
    :parameters
      (?character - character ?toy - toy ?location - object)
    :precondition
      (and (not (has ?character ?toy))
      (at ?character ?location))
    :effect
      (and (has ?character ?toy))
    :agents  (?character)
  )

  ;; A character puts down a toy.
  (:action put-down-toy
    :parameters
      (?character - character ?toy - toy ?location - object)
    :precondition
      (and (has ?character ?toy)
      (at ?character ?location))
    :effect
      (and (not (has ?character ?toy)))
    :agents  (?character)
  )

  ;; A character starts playing.
  (:action start-playing
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (not (playing ?character))
      (at ?character ?location))
    :effect
      (and (playing ?character))
    :agents  (?character)
  )

  ;; A character stops playing.
  (:action stop-playing
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (playing ?character)
      (at ?character ?location))
    :effect
      (and (not (playing ?character)))
    :agents  (?character)
  )

  ;; A character shares their toys.
  (:action share-toys
    :parameters
      (?character - character)
    :precondition
      (and (not (sharing-toys))
      (playing ?character))
    :effect
      (and (sharing-toys))
    :agents  (?character)
  )

  ;; A character apologizes.
  (:action apologize
    :parameters
      (?character - character)
    :precondition
      (and (not (sharing-toys))
      (not (playing ?character)))
    :effect
      (and (sharing-toys))
    :agents  (?character)
  )
)