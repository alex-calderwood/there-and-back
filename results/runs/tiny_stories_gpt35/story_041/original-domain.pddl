(define (domain billy-and-tommy)
  (:requirements :strips :typing :equality)
  (:types character - object)
  (:predicates
    (at ?character - character ?location - object)
    (lost ?character - character)
    (crying ?character - character)
    (happy ?character - character)
    (has ?character - character ?object - object)
    (helped ?character - character ?other - character)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character finds a lost character.
  (:action find
    :parameters
      (?finder - character ?lost - character ?location - object)
    :precondition
      (and (lost ?lost)
      (at ?finder ?location))
    :effect
      (and (not (lost ?lost))
      (not (crying ?lost))
      (at ?lost ?location)
      (helped ?finder ?lost))
  )

  ;; A character gives an object to another character.
  (:action give
    :parameters
      (?giver - character ?receiver - character ?object - object ?location - object)
    :precondition
      (and (has ?giver ?object)
      (at ?giver ?location)
      (at ?receiver ?location))
    :effect
      (and (not (has ?giver ?object))
      (has ?receiver ?object))
  )

  ;; A character becomes happy.
  (:action make-happy
    :parameters
      (?character - character)
    :precondition
      (and (helped ?other ?character))
    :effect
      (happy ?character)
  )
)