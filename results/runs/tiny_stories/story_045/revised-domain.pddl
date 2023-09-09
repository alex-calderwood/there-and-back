(define (domain jack-and-jill)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:constants mirror - object)
  (:predicates
    (has ?character - character ?object - object)
    (shares ?character1 - character ?character2 - character ?object - object)
  )

  ;; A character finds an object.
  (:action find
    :parameters
      (?character - character ?object - object)
    :precondition
      (not (has ?character ?object))
    :effect
      (has ?character ?object)
    :agents
      (?character)
  )

  ;; A character shares an object with another character.
  (:action share
    :parameters
      (?sharer - character ?object - object ?receiver - character)
    :precondition
      (and (has ?sharer ?object)
      (not (shares ?sharer ?receiver ?object)))
    :effect
      (shares ?sharer ?receiver ?object)
    :agents
      (?sharer ?receiver)
  )

  ;; A character unshares an object with another character.
  (:action unshare
    :parameters
      (?sharer - character ?object - object ?receiver - character)
    :precondition
      (shares ?sharer ?receiver ?object)
    :effect
      (not (shares ?sharer ?receiver ?object))
    :agents
      (?sharer ?receiver)
  )
)