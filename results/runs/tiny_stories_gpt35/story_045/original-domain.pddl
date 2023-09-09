(define (domain sharing-friends)
  (:requirements :strips :typing :equality)
  (:types friend - object)
  (:predicates
    (has ?friend - friend ?object - object)
    (at ?friend - friend ?place - place)
  )

  ;; A friend takes an object from a place.
  (:action take
    :parameters
      (?friend - friend ?object - object ?place - place)
    :precondition
      (and (at ?friend ?place)
      (at ?object ?place))
    :effect
      (and (not (at ?object ?place))
      (has ?friend ?object))
    :agents
      (?friend)
  )

  ;; A friend gives an object to another friend.
  (:action give
    :parameters
      (?giver - friend ?object - object ?receiver - friend)
    :precondition
      (and (has ?giver ?object)
      (at ?giver ?place)
      (at ?receiver ?place))
    :effect
      (and (not (has ?giver ?object))
      (has ?receiver ?object))
    :agents
      (?giver ?receiver)
  )
)