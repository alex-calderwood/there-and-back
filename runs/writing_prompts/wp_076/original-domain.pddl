(define (domain neverland)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character group - object place - object)
  (:constants peter - character hook - character lost-boys - group pirates - group)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has-weapon ?character - character)
    (in-group ?character - character ?group - group)
    (group-exists ?group - group)
    (has-electronics ?character - character)
    (believes-in-fairies ?character - character)
  )

  ;; A character travels to another place.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
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

  ;; A character fights with another character.
  (:action fight
    :parameters
      (?fighter1 - character ?fighter2 - character)
    :precondition
      (and (not (= ?fighter1 ?fighter2))
      (alive ?fighter1)
      (has-weapon ?fighter1)
      (alive ?fighter2)
      (has-weapon ?fighter2))
    :effect
      (and)
    :agents
      (?fighter1 ?fighter2)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )

  ;; A character acquires electronics.
  (:action acquire-electronics
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (has-electronics ?character)))
    :effect
      (has-electronics ?character)
    :agents
      (?character)
  )

  ;; A character stops believing in fairies.
  (:action stop-believing
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (believes-in-fairies ?character))
    :effect
      (not (believes-in-fairies ?character))
    :agents
      (?character)
  )
)