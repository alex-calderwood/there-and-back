(define (domain tim-and-the-secret-room)
  (:requirements :strips :typing :equality :existential-preconditions)
  (:types object - physical-object)
  (:predicates
    (wears-hat ?object - object)
    (has-spade ?object - object)
    (at ?object - object ?location - object)
    (digs ?object - object)
    (found-box)
    (has-key)
    (opens ?object - object)
    (enters ?object - object)
    (plays ?object - object)
    (happy ?object - object)
  )

  ;; A character wears a hat.
  (:action wear-hat
    :parameters
      (?object - object)
    :precondition
      (not (wears-hat ?object))
    :effect
      (wears-hat ?object)
  )

  ;; A character has a spade.
  (:action have-spade
    :parameters
      (?object - object)
    :precondition
      (not (has-spade ?object))
    :effect
      (has-spade ?object)
  )

  ;; A character digs in a location.
  (:action dig
    :parameters
      (?object - object ?location - object)
    :precondition
      (and (has-spade ?object)
      (at ?object ?location))
    :effect
      (digs ?object)
    :agents
      (?object)
  )

  ;; A character finds a box.
  (:action find-box
    :precondition
      (digs ?object)
    :effect
      (found-box)
    :agents
      (?object)
  )

  ;; A character has a key.
  (:action have-key
    :parameters
      (?object - object)
    :precondition
      (and (found-box)
      (not (has-key)))
    :effect
      (has-key)
    :agents
      (?object)
  )

  ;; A character opens a door.
  (:action open-door
    :parameters
      (?object - object ?location - object)
    :precondition
      (and (has-key)
      (at ?object ?location)
      (opens ?location))
    :effect
      (enters ?object)
    :agents
      (?object)
  )

  ;; A character enters a room.
  (:action enter-room
    :parameters
      (?object - object ?location - object)
    :precondition
      (and (enters ?object)
      (at ?object ?location))
    :effect
      (plays ?object)
    :agents
      (?object)
  )

  ;; A character is happy.
  (:action be-happy
    :parameters
      (?object - object)
    :precondition
      (plays ?object)
    :effect
      (happy ?object)
    :agents
      (?object)
  )
)