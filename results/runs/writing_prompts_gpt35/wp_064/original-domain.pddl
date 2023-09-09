(define (domain postal-service)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables)
  (:types person - object)
  (:constants
    envelope - object
    amazon-gift-card - object
    cousin - person)
  (:predicates
    (at ?person - person ?location - object)
    (has ?person - person ?object - object)
    (sent ?object - object)
    (delivered ?object - object)
    (good-music ?person - person)
    (bad-music ?person - person)
    (tall ?person - person)
    (owns ?person - person ?object - object)
    (is-related ?person1 - person ?person2 - person)
    (raining)
    (supercell)
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
  )

  ;; A person drops an object in a mailbox.
  (:action drop-in-mailbox
    :parameters
      (?person - person ?object - object ?location - object)
    :precondition
      (and (at ?person ?location)
      (has ?person ?object))
    :effect
      (and (not (has ?person ?object))
      (sent ?object))
  )

  ;; A person receives an object.
  (:action receive
    :parameters
      (?person - person ?object - object)
    :precondition
      (sent ?object)
    :effect
      (and (not (sent ?object))
      (delivered ?object)
      (has ?person ?object))
  )

  ;; A person calls another person.
  (:action call
    :parameters
      (?caller - person ?callee - person)
    :precondition
      (is-related ?caller ?callee)
    :effect
      (and (not (good-music ?callee))
      (good-music ?caller))
  )

  ;; A person is too tall for their bike.
  (:action too-tall
    :parameters
      (?person - person)
    :precondition
      (owns ?person ?object)
    :effect
      (and (not (tall ?person))
      (is-related ?person ?object)
      (tall ?object))
  )

  ;; A person is caught in a supercell.
  (:action caught-in-storm
    :parameters
      (?person - person)
    :precondition
      (raining)
    :effect
      (and (not (alive ?person))
      (supercell))
  )
)