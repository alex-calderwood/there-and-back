(define (domain emma-birthday-party)
  (:requirements :strips :typing)
  (:types person - object)
  (:constants emma - person toy - object)
  (:predicates
    (at ?person - person ?location - object)
    (has ?person - person ?object - object)
    (happy ?person - person)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect  (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person gives an object to another person.
  (:action give
    :parameters
      (?giver - person ?object - object ?receiver - person)
    :precondition
      (and (not (= ?giver ?receiver))
      (at ?giver ?location)
      (has ?giver ?object))
    :effect
      (and (not (has ?giver ?object))
      (has ?receiver ?object))
  )

  ;; A person becomes happy.
  (:action make-happy
    :parameters
      (?person - person)
    :precondition
      (at ?person ?location)
    :effect
      (happy ?person)
  )

)