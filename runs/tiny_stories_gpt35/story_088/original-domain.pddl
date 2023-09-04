(define (domain curious-boy-egg)
  (:requirements :strips :typing :equality :quantified-preconditions)
  (:types object - item)
  (:predicates
    (found ?object - object)
    (held ?object - object)
    (explored ?object - object)
    (curious ?object - object)
    (happy ?object - object)
    (wondered ?object - object)
    (knows ?object - object)
  )

  ;; A character finds an object.
  (:action find
    :parameters
      (?character - object ?object - object)
    :precondition
      (and (not (found ?object))
      (at ?character ?place)
      (explored ?character))
    :effect
      (and (found ?object)
      (knows ?character ?object))
    :agents
      (?character)
  )

  ;; A character picks up an object.
  (:action pick-up
    :parameters
      (?character - object ?object - object)
    :precondition
      (and (found ?object)
      (not (held ?object))
      (at ?character ?place))
    :effect
      (held ?object)
    :agents
      (?character)
  )

  ;; A character explores an area.
  (:action explore
    :parameters
      (?character - object ?place - object)
    :precondition
      (and (not (explored ?place))
      (at ?character ?place))
    :effect
      (explored ?place)
    :agents
      (?character)
  )

  ;; A character becomes curious.
  (:action become-curious
    :parameters
      (?character - object)
    :precondition
      (and (not (curious ?character))
      (at ?character ?place))
    :effect
      (curious ?character)
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - object)
    :precondition
      (and (not (happy ?character))
      (held ?object)
      (at ?character ?place))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character wonders about an object.
  (:action wonder
    :parameters
      (?character - object ?object - object)
    :precondition
      (and (held ?object)
      (at ?character ?place))
    :effect
      (wondered ?character)
    :agents
      (?character)
  )
)