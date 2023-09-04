(define (domain vase-party)
  (:requirements :strips :typing :equality :quantified-preconditions)
  (:types object - physical-object vase - object flower - object)
  (:predicates
    (has-flowers ?vase - vase)
    (has-cake)
    (on-table ?object - physical-object)
    (at-party ?object - physical-object)
    (happy ?object - physical-object)
  )

  ;; A character puts flowers in the vase.
  (:action put-flowers-in-vase
    :parameters
      (?vase - vase ?flowers - flower)
    :precondition
      (and (not (has-flowers ?vase))
      (not (= ?vase ?flowers)))
    :effect
      (and (has-flowers ?vase))
  )

  ;; A character puts an object on the table.
  (:action put-on-table
    :parameters
      (?object - physical-object)
    :precondition
      (not (on-table ?object))
    :effect
      (and (on-table ?object)))
  
  ;; A character goes to the party.
  (:action go-to-party
    :parameters
      (?object - physical-object)
    :precondition
      (not (at-party ?object))
    :effect
      (and (at-party ?object)
      (happy ?object)))
  
  ;; A character has cake.
  (:action have-cake
    :precondition
      (not (has-cake))
    :effect
      (has-cake)
  )
)