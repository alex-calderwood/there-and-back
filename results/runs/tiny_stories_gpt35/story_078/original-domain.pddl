(define (domain city-support)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables :intentionality)
  (:types person - object)
  (:constants mom daughter man - person)
  (:predicates
    (at ?person - person ?location - object)
    (supports ?person - person ?cause - object)
    (volunteers ?person - person)
    (beautiful ?location - object)
    (project ?cause - object)
    (planted ?location - object)
    (clean ?location - object)
    (litter ?location - object)
    (persistent ?person - person)
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
    :agents
      (?person)
  )

  ;; A person supports a cause.
  (:action support
    :parameters
      (?person - person ?cause - object)
    :precondition
      (and (not (supports ?person ?cause)))
    :effect
      (supports ?person ?cause)
    :agents
      (?person)
  )

  ;; A person volunteers for a cause.
  (:action volunteer
    :parameters
      (?person - person ?cause - object)
    :precondition
      (and (supports ?person ?cause)
      (not (volunteers ?person)))
    :effect
      (volunteers ?person)
    :agents
      (?person)
  )

  ;; A person plants a tree.
  (:action plant
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (volunteers ?person)
      (beautiful ?location)
      (not (planted ?location)))
    :effect
      (planted ?location)
    :agents
      (?person)
  )

  ;; A person cleans up litter.
  (:action clean-up
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (volunteers ?person)
      (clean ?location)
      (litter ?location))
    :effect
      (not (litter ?location))
    :agents
      (?person)
  )

  ;; A person is persistent.
  (:axiom
    :vars
      (?person - person)
    :context
      (exists (?cause - object)
      (supports ?person ?cause))
    :implies
      (persistent ?person)
  )
)