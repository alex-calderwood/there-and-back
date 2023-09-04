(define (domain max-and-ben)
  (:requirements :strips :typing :equality :quantified-preconditions)
  (:types dog bear ball - object)
  (:predicates
    (at ?object - object ?location - location)
    (has ?dog - dog ?ball - ball)
    (lost ?object - object)
    (friends ?dog - dog ?bear - bear)
    (frustrated ?object - object)
  )

  ;; A dog travels from one location to another.
  (:action travel
    :parameters
      (?dog - dog ?from - location ?to - location)
    :precondition
      (and (not (= ?from ?to))
      (at ?dog ?from))
    :effect  (and (not (at ?dog ?from))
      (at ?dog ?to))
  )

  ;; A dog looks for its ball.
  (:action search-ball
    :parameters
      (?dog - dog ?ball - ball ?location - location)
    :precondition
      (and (at ?dog ?location)
      (lost ?ball)
      (has ?dog ?ball))
    :effect
      (not (lost ?ball))
    :agents
      (?dog)
  )

  ;; A dog bumps into a bear.
  (:action bump-into-bear
    :parameters
      (?dog - dog ?bear - bear ?location - location)
    :precondition
      (and (at ?dog ?location)
      (at ?bear ?location)
      (not (= ?dog ?bear)))
    :effect
      (and (friends ?dog ?bear)
      (friends ?bear ?dog))
    :agents
      (?dog ?bear)
  )

  ;; A dog helps a bear find its way home.
  (:action help-bear
    :parameters
      (?dog - dog ?bear - bear ?location - location)
    :precondition
      (and (at ?dog ?location)
      (at ?bear ?location)
      (friends ?dog ?bear)
      (frustrated ?bear))
    :effect
      (not (frustrated ?bear))
    :agents
      (?dog)
  )

  ;; A dog finds its ball.
  (:action find-ball
    :parameters
      (?dog - dog ?ball - ball ?location - location)
    :precondition
      (and (at ?dog ?location)
      (lost ?ball))
    :effect
      (not (lost ?ball))
    :agents
      (?dog)
  )

  ;; A dog and a bear become friends in the fog.
  (:action become-friends
    :parameters
      (?dog - dog ?bear - bear ?location - location)
    :precondition
      (and (at ?dog ?location)
      (at ?bear ?location)
      (not (= ?dog ?bear)))
    :effect
      (and (friends ?dog ?bear)
      (friends ?bear ?dog))
    :agents
      (?dog ?bear)
  )
)