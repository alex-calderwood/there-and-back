(define (domain park-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?location - object)
    (hurt ?character - character)
    (touching ?character - character ?object - object)
    (scared ?character - character)
    (hugging ?character1 - character ?character2 - character)
  )

  ;; A character moves to a location.
  (:action move
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (not (at ?character ?location))
      (not (scared ?character)))
    :effect
      (at ?character ?location)
    :agents
      (?character)
  )

  ;; A character touches an object.
  (:action touch
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (not (touching ?character ?object))
      (at ?character ?location))
    :effect
      (touching ?character ?object)
    :agents
      (?character)
  )

  ;; A character stops touching an object.
  (:action stop-touching
    :parameters
      (?character - character ?object - object)
    :precondition
      (touching ?character ?object)
    :effect
      (not (touching ?character ?object))
    :agents
      (?character)
  )

  ;; A character gets hurt.
  (:action get-hurt
    :parameters
      (?character - character)
    :precondition
      (not (hurt ?character))
    :effect
      (hurt ?character)
    :agents
      (?character)
  )

  ;; A character gets scared.
  (:action get-scared
    :parameters
      (?character - character)
    :precondition
      (not (scared ?character))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character stops being scared.
  (:action stop-scared
    :parameters
      (?character - character)
    :precondition
      (scared ?character)
    :effect
      (not (scared ?character))
    :agents
      (?character)
  )

  ;; Two characters hug each other.
  (:action hug
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (hugging ?character1 ?character2))
      (not (hugging ?character2 ?character1)))
    :effect
      (hugging ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Two characters stop hugging each other.
  (:action stop-hug
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (hugging ?character1 ?character2)
    :effect
      (not (hugging ?character1 ?character2))
    :agents
      (?character1 ?character2)
  )
)