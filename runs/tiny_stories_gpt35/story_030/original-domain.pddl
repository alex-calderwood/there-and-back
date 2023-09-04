(define (domain dark-woods)
  (:requirements :strips :negative-preconditions :typing)
  (:types character - object)
  (:predicates
    (hungry ?character - character)
    (friend ?character - character)
    (ate ?character - character)
  )

  ;; A character walks from one place to another.
  (:action walk
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (not (ate ?character))
      (not (hungry ?character)))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?speaker - character ?listener - character)
    :precondition
      (and (not (= ?speaker ?listener))
      (not (ate ?speaker))
      (not (ate ?listener)))
    :effect
      (and (friend ?speaker ?listener)
      (friend ?listener ?speaker))
    :agents
      (?speaker ?listener)
  )

  ;; A character searches for food.
  (:action search-for-food
    :parameters
      (?character - character)
    :precondition
      (and (not (ate ?character))
      (not (hungry ?character)))
    :effect
      (hungry ?character)
    :agents
      (?character)
  )

  ;; A character finds food.
  (:action find-food
    :parameters
      (?character - character)
    :precondition
      (and (hungry ?character)
      (at ?character ?place))
    :effect
      (not (hungry ?character))
    :agents
      (?character)
  )

  ;; A character eats another character.
  (:action eat
    :parameters
      (?eater - character ?victim - character)
    :precondition
      (and (hungry ?eater)
      (at ?eater ?place)
      (at ?victim ?place)
      (not (= ?eater ?victim)))
    :effect
      (and (ate ?eater)
      (not (alive ?victim)))
    :agents
      (?eater)
  )
)