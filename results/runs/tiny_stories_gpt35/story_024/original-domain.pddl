(define (domain frog-pond)
  (:requirements :adl :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?location - location)
    (playing ?character - character)
    (friends ?character1 - character ?character2 - character)
    (scared ?character - character)
    (happy ?character - character)
    (whale ?character - character)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - location ?to - location)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character plays with another character.
  (:action play
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (at ?character1 ?location)
      (at ?character2 ?location)
      (not (= ?character1 ?character2)))
    :effect
      (and (playing ?character1)
      (playing ?character2))
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes scared.
  (:action scare
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (playing ?character))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action make-happy
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (scared ?character)))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character transforms into a whale.
  (:action transform
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (playing ?character)
      (not (whale ?character)))
    :effect
      (whale ?character)
    :agents
      (?character)
  )
)