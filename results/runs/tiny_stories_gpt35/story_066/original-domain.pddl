(define (domain tom-and-sue)
  (:requirements :strips :typing)
  (:types character - object gift - item)
  (:predicates
    (has-gift ?character - character ?gift - gift)
    (at ?character - character ?location - object)
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
  )

  ;; A character gives a gift to another.
  (:action give
    :parameters
      (?giver - character ?gift - gift ?receiver - character ?location - object)
    :precondition
      (and (not (= ?giver ?receiver))
      (at ?giver ?location)
      (has-gift ?giver ?gift)
      (at ?receiver ?location))
    :effect
      (and (not (has-gift ?giver ?gift))
      (has-gift ?receiver ?gift))
  )
)